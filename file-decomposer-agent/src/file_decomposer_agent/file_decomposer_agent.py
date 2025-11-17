#!/usr/bin/env python3
"""
大文件分解和理解 Agent
基于 LangChain v1.0 和 deepagents 框架
支持多种文件格式的智能分解和内容分析
"""

import os
import json
import logging
from dataclasses import dataclass, field
from typing import List, Dict, Any, Optional, Union
from pathlib import Path
import hashlib

# LangChain v1.0 核心组件
from langchain.agents import create_agent, AgentState
from langchain.agents.middleware import (
    TodoListMiddleware,
    ContextEditingMiddleware,
    ClearToolUsesEdit,
    PIIMiddleware
)
from langchain.messages import HumanMessage, AIMessage
from langchain.tools import tool, ToolRuntime
from langchain.chat_models import init_chat_model
from langchain.embeddings import init_embeddings

# 文档加载和分割
from langchain_community.document_loaders import (
    PyPDFLoader,
    TextLoader,
    CSVLoader,
    UnstructuredHTMLLoader,
    JSONLoader
)
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_core.documents import Document

# 向量存储
from langchain_community.vectorstores import FAISS

# 工具和运行时
from langgraph.store.memory import InMemoryStore

# 日志配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

@dataclass
class FileContext:
    """文件处理上下文"""
    file_path: str
    file_type: str
    file_size: int
    chunk_count: int = 0
    processed_at: Optional[str] = None
    content_hash: Optional[str] = None
    analysis_results: Dict[str, Any] = field(default_factory=dict)

class FileDecomposerAgent:
    """大文件分解和理解 Agent"""

    def __init__(self, model_name: str = "claude-sonnet-4-5-20250929"):
        """
        初始化文件分解 Agent

        Args:
            model_name: 使用的语言模型名称
        """
        self.model_name = model_name
        self.vector_store = None
        self.embeddings = None
        self.text_splitter = None
        self.store = InMemoryStore()
        self.agent = None
        self.file_contexts: Dict[str, FileContext] = {}

        # 初始化组件
        self._initialize_components()

    def _initialize_components(self):
        """初始化 LangChain 组件"""
        try:
            # 初始化语言模型
            self.model = init_chat_model(self.model_name)

            # 初始化文本嵌入模型
            self.embeddings = init_embeddings("openai:text-embedding-3-small")

            # 初始化文本分割器
            self.text_splitter = RecursiveCharacterTextSplitter(
                chunk_size=1000,
                chunk_overlap=200,
                add_start_index=True,
                length_function=len,
            )

            # 创建 Agent
            self._create_agent()

            logger.info("文件分解 Agent 初始化成功")

        except Exception as e:
            logger.error(f"初始化失败: {e}")
            raise

    def _create_agent(self):
        """创建带有中间件的 Agent"""

        # 定义 Agent 工具
        tools = [
            self._load_file_tool,
            self._split_document_tool,
            self._analyze_content_tool,
            self._search_similar_content_tool,
            self._generate_summary_tool,
            self._extract_key_info_tool,
        ]

        # 配置中间件
        middleware = [
            TodoListMiddleware(),
            ContextEditingMiddleware(
                edits=[
                    ClearToolUsesEdit(
                        trigger=2000,
                        keep=3,
                        clear_tool_inputs=False,
                        exclude_tools=["load_file"]
                    )
                ]
            ),
            PIIMiddleware(
                "email",
                strategy="redact",
                apply_to_input=True
            ),
        ]

        # 系统提示词
        system_prompt = """
        你是一个专业的文件分析助手，专门负责大文件的分解和理解。

        核心能力：
        1. 加载和解析多种格式的文件（PDF, TXT, CSV, HTML, JSON等）
        2. 智能分割大文件为可管理的块
        3. 分析文件内容结构和主题
        4. 提供内容摘要和关键信息提取
        5. 回答关于文件内容的具体问题

        工作流程：
        - 首先加载文件并检测文件类型
        - 使用适当的加载器解析文件
        - 将内容分割成较小的块
        - 为每个块生成向量嵌入
        - 存储到向量数据库中
        - 提供分析和查询功能

        回答要求：
        - 准确分析文件内容
        - 提供结构化的分析结果
        - 在不确定时明确说明
        - 保护敏感信息
        """

        # 创建 Agent
        self.agent = create_agent(
            model=self.model,
            tools=tools,
            middleware=middleware,
            system_prompt=system_prompt,
            store=self.store
        )

    @tool
    def _load_file_tool(self, file_path: str) -> str:
        """加载文件工具 - 支持多种格式"""
        try:
            file_path = Path(file_path)

            if not file_path.exists():
                return f"错误：文件 {file_path} 不存在"

            # 检测文件类型
            file_extension = file_path.suffix.lower()

            # 创建文档加载器
            if file_extension == '.pdf':
                loader = PyPDFLoader(str(file_path))
                docs = loader.load()
                content_type = "PDF文档"

            elif file_extension == '.txt':
                loader = TextLoader(str(file_path), encoding='utf-8')
                docs = loader.load()
                content_type = "文本文件"

            elif file_extension == '.csv':
                loader = CSVLoader(str(file_path))
                docs = loader.load()
                content_type = "CSV数据文件"

            elif file_extension == '.html':
                loader = UnstructuredHTMLLoader(str(file_path))
                docs = loader.load()
                content_type = "HTML网页"

            elif file_extension == '.json':
                loader = JSONLoader(str(file_path), jq_schema='.')
                docs = loader.load()
                content_type = "JSON数据"

            elif file_extension in ['.md', '.markdown']:
                loader = TextLoader(str(file_path), encoding='utf-8')
                docs = loader.load()
                content_type = "Markdown文档"

            else:
                # 默认使用文本加载器
                loader = TextLoader(str(file_path), encoding='utf-8')
                docs = loader.load()
                content_type = f"{file_extension[1:].upper()}文件"

            # 计算文件哈希
            with open(file_path, 'rb') as f:
                file_hash = hashlib.md5(f.read()).hexdigest()

            # 创建文件上下文
            file_context = FileContext(
                file_path=str(file_path),
                file_type=content_type,
                file_size=file_path.stat().st_size,
                content_hash=file_hash
            )

            self.file_contexts[str(file_path)] = file_context

            logger.info(f"成功加载 {content_type}: {file_path}")

            return f"""
            文件加载成功！
            文件路径: {file_path}
            文件类型: {content_type}
            文件大小: {file_path.stat().st_size:,} 字节
            文档数量: {len(docs)}
            文件哈希: {file_hash[:8]}...

            示例内容预览:
            {docs[0].page_content[:300] if docs else "无内容"}
            """

        except Exception as e:
            logger.error(f"加载文件失败: {e}")
            return f"加载文件失败: {str(e)}"

    @tool
    def _split_document_tool(self, file_path: str, chunk_size: int = 1000, chunk_overlap: int = 200) -> str:
        """分割文档工具"""
        try:
            file_path = Path(file_path)

            if str(file_path) not in self.file_contexts:
                return f"错误：文件 {file_path} 未加载，请先使用 load_file 工具"

            # 重新加载文件
            loader = TextLoader(str(file_path), encoding='utf-8')
            docs = loader.load()

            # 使用文本分割器
            text_splitter = RecursiveCharacterTextSplitter(
                chunk_size=chunk_size,
                chunk_overlap=chunk_overlap,
                add_start_index=True
            )

            # 分割文档
            all_splits = text_splitter.split_documents(docs)

            # 更新文件上下文
            file_context = self.file_contexts[str(file_path)]
            file_context.chunk_count = len(all_splits)

            logger.info(f"文档分割完成：{len(all_splits)} 个块")

            return f"""
            文档分割完成！
            原始文档数: {len(docs)}
            分割块数量: {len(all_splits)}
            块大小: {chunk_size} 字符
            重叠字符: {chunk_overlap}

            前3个块的预览:
            """

            # 添加块预览
            for i, split in enumerate(all_splits[:3]):
                return += f"""
                块 {i+1} (起始位置: {split.metadata.get('start_index', 'N/A')}):
                {split.page_content[:200]}...
                """

        except Exception as e:
            logger.error(f"文档分割失败: {e}")
            return f"文档分割失败: {str(e)}"

    @tool
    def _analyze_content_tool(self, file_path: str) -> str:
        """分析文件内容工具"""
        try:
            if str(file_path) not in self.file_contexts:
                return f"错误：文件 {file_path} 未加载"

            file_context = self.file_contexts[str(file_path)]
            file_path_obj = Path(file_path)

            # 加载文件内容
            if file_path_obj.suffix == '.pdf':
                loader = PyPDFLoader(str(file_path_obj))
                docs = loader.load()
            else:
                loader = TextLoader(str(file_path_obj), encoding='utf-8')
                docs = loader.load()

            # 基础统计
            total_chars = sum(len(doc.page_content) for doc in docs)
            total_words = sum(len(doc.page_content.split()) for doc in docs)
            total_lines = sum(doc.page_content.count('\n') + 1 for doc in docs)

            # 内容分析
            analysis = {
                "文件信息": {
                    "路径": file_context.file_path,
                    "类型": file_context.file_type,
                    "大小": f"{file_context.file_size:,} 字节",
                    "哈希": file_context.content_hash[:8] + "..." if file_context.content_hash else "N/A"
                },
                "内容统计": {
                    "文档数": len(docs),
                    "字符数": total_chars,
                    "单词数": total_words,
                    "行数": total_lines,
                    "块数": file_context.chunk_count
                }
            }

            # 更新上下文
            file_context.analysis_results = analysis

            # 生成分析报告
            report = "## 文件内容分析报告\n\n"
            for section, data in analysis.items():
                report += f"### {section}\n"
                for key, value in data.items():
                    report += f"- **{key}**: {value}\n"
                report += "\n"

            logger.info(f"文件分析完成: {file_path}")

            return report

        except Exception as e:
            logger.error(f"内容分析失败: {e}")
            return f"内容分析失败: {str(e)}"

    @tool
    def _search_similar_content_tool(self, query: str, file_path: Optional[str] = None, k: int = 3) -> str:
        """搜索相似内容工具"""
        try:
            # 如果指定了文件，只在该文件中搜索
            if file_path and str(file_path) in self.file_contexts:
                # TODO: 实现文件特定的搜索
                return "文件特定搜索功能待实现"

            # 如果没有向量存储，提示先建立索引
            if self.vector_store is None:
                return "错误：未建立向量索引。请先加载文件并分割文档。"

            # 执行相似性搜索
            results = self.vector_store.similarity_search(query, k=k)

            if not results:
                return f"未找到与查询 '{query}' 相似的内容"

            # 格式化结果
            response = f"## 搜索结果：'{query}'\n\n找到 {len(results)} 个相关内容：\n\n"

            for i, doc in enumerate(results, 1):
                response += f"""
                ### 结果 {i}
                **内容**: {doc.page_content[:300]}...
                **元数据**: {doc.metadata}
                **相似度**: {getattr(doc, 'similarity_score', 'N/A')}
                ---
                """

            return response

        except Exception as e:
            logger.error(f"搜索失败: {e}")
            return f"搜索失败: {str(e)}"

    @tool
    def _generate_summary_tool(self, file_path: str) -> str:
        """生成文件摘要工具"""
        try:
            if str(file_path) not in self.file_contexts:
                return f"错误：文件 {file_path} 未加载"

            # 使用 Agent 生成摘要
            query = f"请为文件 {file_path} 生成一个详细的摘要，包括主要内容和关键信息。"

            response = self.agent.invoke({
                'messages': [HumanMessage(content=query)]
            })

            summary = response['messages'][-1].content

            return f"## 文件摘要: {file_path}\n\n{summary}"

        except Exception as e:
            logger.error(f"摘要生成失败: {e}")
            return f"摘要生成失败: {str(e)}"

    @tool
    def _extract_key_info_tool(self, file_path: str, info_type: str = "main_points") -> str:
        """提取关键信息工具"""
        try:
            if str(file_path) not in self.file_contexts:
                return f"错误：文件 {file_path} 未加载"

            # 定义不同类型的信息提取
            extract_prompts = {
                "main_points": "请提取文件的主要观点和要点",
                "names": "请提取文件中的所有重要名称、人名、地名等实体",
                "dates": "请提取文件中的所有日期、时间信息",
                "numbers": "请提取文件中的所有数字、统计数据等",
                "questions": "请提取文件中的所有问题或疑问",
                "actions": "请提取文件中的所有行动项目或建议"
            }

            if info_type not in extract_prompts:
                return f"不支持的信息类型: {info_type}。支持的类型: {list(extract_prompts.keys())}"

            # 使用 Agent 提取信息
            query = f"{extract_prompts[info_type]}，文件路径: {file_path}"

            response = self.agent.invoke({
                'messages': [HumanMessage(content=query)]
            })

            extracted_info = response['messages'][-1].content

            return f"## {info_type.replace('_', ' ').title()}: {file_path}\n\n{extracted_info}"

        except Exception as e:
            logger.error(f"信息提取失败: {e}")
            return f"信息提取失败: {str(e)}"

    def build_vector_index(self, file_path: str) -> str:
        """建立向量索引"""
        try:
            if str(file_path) not in self.file_contexts:
                return f"错误：文件 {file_path} 未加载"

            file_path_obj = Path(file_path)

            # 加载和分割文档
            loader = TextLoader(str(file_path_obj), encoding='utf-8')
            docs = loader.load()

            all_splits = self.text_splitter.split_documents(docs)

            # 创建向量存储
            self.vector_store = FAISS.from_documents(all_splits, self.embeddings)

            logger.info(f"向量索引建立完成: {len(all_splits)} 个向量")

            return f"向量索引建立完成！\n文档块数: {len(all_splits)}\n向量维度: {self.embeddings.dimensionality}"

        except Exception as e:
            logger.error(f"向量索引建立失败: {e}")
            return f"向量索引建立失败: {str(e)}"

    def chat_with_file(self, file_path: str, question: str) -> str:
        """与文件对话"""
        try:
            if not self.vector_store:
                # 如果没有向量索引，先建立索引
                self.build_vector_index(file_path)

            # 使用 Agent 回答问题
            query = f"基于文件 {file_path} 的内容，请回答以下问题: {question}"

            response = self.agent.invoke({
                'messages': [HumanMessage(content=query)]
            })

            answer = response['messages'][-1].content

            return f"## 问题: {question}\n\n**答案**: {answer}"

        except Exception as e:
            logger.error(f"对话失败: {e}")
            return f"对话失败: {str(e)}"

    def get_file_status(self) -> Dict[str, Any]:
        """获取所有文件的处理状态"""
        status = {}
        for file_path, context in self.file_contexts.items():
            status[file_path] = {
                "file_type": context.file_type,
                "file_size": context.file_size,
                "chunk_count": context.chunk_count,
                "analysis_results": context.analysis_results
            }
        return status


def main():
    """主函数 - 演示如何使用文件分解 Agent"""
    # 创建 Agent 实例
    agent = FileDecomposerAgent()

    print("🚀 大文件分解和理解 Agent 已启动")
    print("=" * 50)

    # 演示用法
    example_files = [
        "/path/to/your/document.pdf",
        "/path/to/your/text.txt",
        "/path/to/your/data.csv"
    ]

    print("\n📖 使用示例:")
    print("1. 加载文件: agent._load_file_tool('/path/to/your/file.txt')")
    print("2. 分割文档: agent._split_document_tool('/path/to/your/file.txt')")
    print("3. 分析内容: agent._analyze_content_tool('/path/to/your/file.txt')")
    print("4. 建立向量索引: agent.build_vector_index('/path/to/your/file.txt')")
    print("5. 与文件对话: agent.chat_with_file('/path/to/your/file.txt', '这个文件的主要内容是什么？')")

    print("\n🔧 可用的信息提取类型:")
    extract_types = ["main_points", "names", "dates", "numbers", "questions", "actions"]
    for i, extract_type in enumerate(extract_types, 1):
        print(f"{i}. {extract_type}")

    print("\n💡 提示: 请将上述示例文件路径替换为您的实际文件路径")


if __name__ == "__main__":
    main()