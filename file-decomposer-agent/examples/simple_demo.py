#!/usr/bin/env python3
"""
简单使用示例
演示如何使用大文件分解和理解 Agent
"""

import sys
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

from file_decomposer_agent import FileDecomposerAgent, config

def simple_demo():
    """简单的演示"""
    print("🚀 大文件分解和理解 Agent - 简单演示")
    print("="*50)

    # 创建示例文件
    sample_content = """
    这是一个示例文档，用于测试文件分解功能。

    ## 主要内容
    人工智能（AI）是计算机科学的一个分支，它试图理解智能的实质，
    并生产出一种新的能以人类智能相似的方式做出反应的智能机器。

    ## 应用领域
    - 自然语言处理
    - 计算机视觉
    - 机器学习
    - 专家系统

    ## 技术发展
    近年来，深度学习技术的发展为人工智能带来了重大突破。
    """

    # 保存示例文件
    sample_file = Path(__file__).parent / "sample.txt"
    with open(sample_file, 'w', encoding='utf-8') as f:
        f.write(sample_content)

    print(f"✅ 创建示例文件: {sample_file}")

    try:
        # 创建 Agent
        print("\n📋 创建 Agent...")
        agent = FileDecomposerAgent()
        print("✅ Agent 创建成功")

        # 加载文件
        print(f"\n📋 加载文件: {sample_file}")
        result = agent._load_file_tool(str(sample_file))
        print("✅ 文件加载成功")

        # 分析内容
        print("\n📋 分析内容...")
        analysis = agent._analyze_content_tool(str(sample_file))
        print("✅ 内容分析完成")

        print("\n📊 分析结果预览:")
        print(analysis[:200] + "...")

        # 演示成功
        print("\n🎉 简单演示完成！")
        print("\n💡 使用提示:")
        print("1. 现在您可以使用 uv run main <your-file> 来分析任何文件")
        print("2. 或者使用 uv run quickstart 来运行完整的演示")
        print("3. 在 examples/ 目录下查看更多示例")

    except Exception as e:
        print(f"❌ 演示过程中出现错误: {e}")
        print("请检查是否已正确配置 API 密钥")

    finally:
        # 清理示例文件
        if sample_file.exists():
            sample_file.unlink()
            print(f"\n🧹 清理示例文件: {sample_file}")

if __name__ == "__main__":
    simple_demo()