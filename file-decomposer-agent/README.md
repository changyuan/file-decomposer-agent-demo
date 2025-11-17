# 大文件分解和理解 Agent

基于 LangChain v1.0 和 deepagents 框架的智能文件分析系统，能够分解大文件并深入理解其内容。

## 🚀 特性

### 核心功能
- **多格式支持**: PDF, TXT, CSV, HTML, JSON, Markdown 等
- **智能分割**: 使用 RecursiveCharacterTextSplitter 优化文档分割
- **内容分析**: 自动分析文件结构、主题和关键信息
- **向量搜索**: 基于嵌入向量的相似性搜索
- **交互问答**: 与文件内容进行自然语言对话
- **信息提取**: 提取特定类型的实体和信息

### 技术特性
- **LangChain v1.0**: 使用最新的 create_agent 标准
- **中间件支持**: 集成 TodoList、ContextEditing、PIIMiddleware 等
- **向量存储**: FAISS 向量数据库支持
- **模型兼容**: 支持 Claude、OpenAI 等多种 LLM
- **错误处理**: 完善的错误处理和日志记录

## 📦 安装

### 1. 安装依赖

```bash
# 使用 pip
pip install -r requirements.txt

# 或使用 uv (推荐)
uv add langchain>=1.0.0 langchain-community pypdf faiss-cpu
```

### 2. 环境配置

创建 `.env` 文件并配置 API 密钥：

```bash
# .env 文件
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here
MODEL_NAME=claude-sonnet-4-5-20250929
```

### 3. 验证安装

```bash
python config.py
```

## 🎯 快速开始

### 基本使用

```python
from file_decomposer_agent import FileDecomposerAgent

# 创建 Agent 实例
agent = FileDecomposerAgent(model_name="claude-sonnet-4-5-20250929")

# 加载文件
result = agent._load_file_tool("/path/to/your/file.pdf")

# 分析内容
analysis = agent._analyze_content_tool("/path/to/your/file.pdf")

# 建立向量索引
index = agent.build_vector_index("/path/to/your/file.pdf")

# 与文件对话
answer = agent.chat_with_file(
    "/path/to/your/file.pdf",
    "这个文件的主要主题是什么？"
)

print(answer)
```

### 演示脚本

```bash
# 运行自动演示
python demo_file_decomposition.py

# 运行交互式演示
python demo_file_decomposition.py interactive
```

## 🛠️ API 参考

### FileDecomposerAgent 类

#### 主要方法

##### `__init__(model_name: str = "claude-sonnet-4-5-20250929")`
初始化 Agent 实例。

**参数:**
- `model_name`: 使用的语言模型名称

##### `load_file_tool(file_path: str) -> str`
加载和解析文件。

**支持格式:**
- PDF: PyPDFLoader
- TXT: TextLoader
- CSV: CSVLoader
- HTML: UnstructuredHTMLLoader
- JSON: JSONLoader
- MD/Markdown: TextLoader

##### `split_document_tool(file_path: str, chunk_size: int = 1000, chunk_overlap: int = 200) -> str`
分割文档为可管理的块。

##### `analyze_content_tool(file_path: str) -> str`
分析文件内容和统计信息。

##### `build_vector_index(file_path: str) -> str`
为文件内容建立向量索引。

##### `search_similar_content_tool(query: str, k: int = 3) -> str`
基于向量相似性搜索相关内容。

##### `chat_with_file(file_path: str, question: str) -> str`
与文件内容进行自然语言对话。

##### `extract_key_info_tool(file_path: str, info_type: str = "main_points") -> str`
提取特定类型的关键信息。

**信息类型:**
- `main_points`: 主要观点
- `names`: 名称实体
- `dates`: 日期时间
- `numbers`: 数字统计
- `questions`: 问题疑问
- `actions`: 行动建议

## 📊 使用示例

### 示例 1: 分析技术文档

```python
# 创建 Agent
agent = FileDecomposerAgent()

# 加载 PDF 技术文档
pdf_file = "technical_manual.pdf"
agent.load_file_tool(pdf_file)

# 建立索引
agent.build_vector_index(pdf_file)

# 询问技术问题
answer = agent.chat_with_file(
    pdf_file,
    "这个系统的架构是怎样的？"
)
```

### 示例 2: 处理 CSV 数据

```python
# 加载 CSV 文件
csv_file = "sales_data.csv"
agent.load_file_tool(csv_file)

# 分析数据结构
analysis = agent.analyze_content_tool(csv_file)
print(analysis)

# 提取关键指标
metrics = agent.extract_key_info_tool(csv_file, "numbers")
```

### 示例 3: 批量文件处理

```python
file_list = ["doc1.pdf", "report.docx", "data.csv"]

for file_path in file_list:
    print(f"\n处理文件: {file_path}")

    # 加载和分析
    agent.load_file_tool(file_path)
    agent.analyze_content_tool(file_path)

    # 生成摘要
    summary = agent.generate_summary_tool(file_path)
    print(summary)
```

### 示例 4: 交互式分析

```python
# 创建交互式分析循环
def interactive_analysis():
    agent = FileDecomposerAgent()

    while True:
        file_path = input("输入文件路径 (quit 退出): ")

        if file_path.lower() in ['quit', 'exit']:
            break

        # 加载文件
        agent.load_file_tool(file_path)
        agent.build_vector_index(file_path)

        # 问答循环
        while True:
            question = input("您的问题 (返回上一文件输入空行): ")

            if not question:
                break

            answer = agent.chat_with_file(file_path, question)
            print(f"答案: {answer}\n")

interactive_analysis()
```

## 🔧 配置选项

### 配置模板

```python
from config import AgentConfig, load_config

# 开发环境配置
dev_config = load_config("development")

# 生产环境配置
prod_config = load_config("production")

# 研究环境配置
research_config = load_config("research")
```

### 自定义配置

```python
from config import AgentConfig

# 创建自定义配置
custom_config = AgentConfig(
    MODEL_NAME="claude-sonnet-4-5-20250929",
    DEFAULT_CHUNK_SIZE=1500,
    DEFAULT_CHUNK_OVERLAP=300,
    MAX_FILE_SIZE=200 * 1024 * 1024  # 200MB
)

# 验证配置
if custom_config.validate():
    print("配置有效")
```

## 📈 性能优化

### 分块策略

- **小文件** (< 1MB): chunk_size=500, chunk_overlap=100
- **中等文件** (1-10MB): chunk_size=1000, chunk_overlap=200
- **大文件** (> 10MB): chunk_size=2000, chunk_overlap=400

### 内存优化

```python
# 对于大文件，使用流式处理
def process_large_file(file_path, chunk_size=500):
    agent = FileDecomposerAgent()

    # 分批处理
    for i in range(0, get_file_line_count(file_path), chunk_size):
        batch_file = f"{file_path}.batch_{i}"
        extract_batch(file_path, i, i+chunk_size, batch_file)

        agent.load_file_tool(batch_file)
        # 处理批次...
```

### 并行处理

```python
from concurrent.futures import ThreadPoolExecutor
import threading

def parallel_file_analysis(file_list, max_workers=4):
    lock = threading.Lock()

    def process_single_file(file_path):
        agent = FileDecomposerAgent()
        try:
            with lock:
                print(f"处理文件: {file_path}")

            result = agent.analyze_content_tool(file_path)
            return file_path, result

        except Exception as e:
            return file_path, f"错误: {e}"

    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        results = list(executor.map(process_single_file, file_list))

    return results
```

## 🐛 故障排除

### 常见问题

#### 1. 导入错误
```bash
# 确保安装了所有依赖
pip install -r requirements.txt

# 检查 Python 版本 (推荐 3.8+)
python --version
```

#### 2. API 密钥错误
```bash
# 检查环境变量
echo $OPENAI_API_KEY
echo $ANTHROPIC_API_KEY

# 或在 Python 中检查
import os
print(os.getenv('OPENAI_API_KEY'))
```

#### 3. 文件格式不支持
```python
# 检查支持的文件格式
from config import config
print("支持格式:", config.SUPPORTED_FORMATS)
```

#### 4. 内存不足
```python
# 减少块大小
agent.split_document_tool(
    file_path,
    chunk_size=500,      # 减少到 500
    chunk_overlap=50     # 减少重叠
)
```

### 调试模式

```python
import logging
logging.basicConfig(level=logging.DEBUG)

# 现在会显示详细的调试信息
agent = FileDecomposerAgent()
```

## 🤝 贡献

欢迎提交问题报告和功能请求！

### 开发环境设置

```bash
# 克隆项目
git clone <repository-url>
cd file-decomposer-agent

# 安装开发依赖
pip install -r requirements-dev.txt

# 运行测试
python -m pytest tests/

# 代码格式化
black *.py
```

## 📄 许可证

MIT License

## 🙏 致谢

- [LangChain](https://github.com/langchain-ai/langchain) - 核心框架
- [FAISS](https://github.com/facebookresearch/faiss) - 向量搜索
- [pypdf](https://pypdf.readthedocs.io/) - PDF 处理

## 📞 支持

如有问题或建议，请：
1. 查看本文档的故障排除部分
2. 搜索现有的 GitHub Issues
3. 创建新的 Issue 并提供详细信息