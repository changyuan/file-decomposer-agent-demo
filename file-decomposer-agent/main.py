"""Main entrypoint for the package."""

import sys
import argparse
from pathlib import Path

# Add src to path for imports
sys.path.insert(0, str(Path(__file__).parent / "src"))

from file_decomposer_agent import FileDecomposerAgent


def main():
    """主入口函数"""
    parser = argparse.ArgumentParser(description="大文件分解和理解 Agent")
    parser.add_argument("file", help="要分析的文件路径")
    parser.add_argument("--question", "-q", help="要问的问题")
    parser.add_argument("--chunk-size", type=int, default=1000, help="文档块大小")
    parser.add_argument("--chunk-overlap", type=int, default=200, help="文档块重叠")

    args = parser.parse_args()

    try:
        # 创建 Agent
        agent = FileDecomposerAgent()

        # 加载文件
        print(f"正在加载文件: {args.file}")
        agent._load_file_tool(args.file)

        # 分割文档
        print("正在分割文档...")
        agent._split_document_tool(args.file, args.chunk_size, args.chunk_overlap)

        # 分析内容
        print("正在分析内容...")
        analysis = agent._analyze_content_tool(args.file)
        print(analysis)

        # 建立索引
        print("正在建立向量索引...")
        agent.build_vector_index(args.file)

        if args.question:
            # 回答问题
            print(f"\n正在回答问题: {args.question}")
            answer = agent.chat_with_file(args.file, args.question)
            print(f"\n答案: {answer}")
        else:
            # 交互式问答
            print("\n💬 交互式问答模式 (输入 'quit' 退出):")
            while True:
                question = input("\n您的问题: ").strip()
                if question.lower() in ['quit', 'q', 'exit']:
                    break
                if question:
                    answer = agent.chat_with_file(args.file, question)
                    print(f"答案: {answer}")

    except Exception as e:
        print(f"错误: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
