#!/usr/bin/env python3
"""
大文件分解和理解 Agent 使用示例
演示如何使用 LangChain v1.0 和 deepagents 框架来分析文件
"""

import os
from pathlib import Path
from file_decomposer_agent import FileDecomposerAgent, HumanMessage

def create_sample_files():
    """创建示例文件用于测试"""
    sample_dir = Path("sample_files")
    sample_dir.mkdir(exist_ok=True)

    # 创建示例文本文件
    sample_text = """
    人工智能的发展历程

    人工智能（Artificial Intelligence，AI）是计算机科学的一个分支，它试图理解智能的实质，
    并生产出一种新的能以人类智能相似的方式做出反应的智能机器。

    ## 历史发展

    人工智能的发展可以追溯到20世纪40年代。1943年，McCulloch和Pitts提出了第一个人工神经元模型。
    1956年，在达特茅斯会议上，"人工智能"这一术语正式被提出。

    ## 发展阶段

    ### 第一阶段（1950年代-1960年代）
    这一阶段主要是符号主义AI的发展，主要集中在逻辑推理和知识表示方面。

    ### 第二阶段（1970年代-1980年代）
    专家系统的兴起，基于知识的AI系统开始在特定领域发挥重要作用。

    ### 第三阶段（1990年代-2000年代）
    机器学习算法的发展，特别是统计学习方法的应用。

    ### 第四阶段（2010年代至今）
    深度学习的兴起，基于神经网络的AI系统取得了突破性进展。

    ## 当前应用

    人工智能在许多领域都有广泛应用：
    - 自然语言处理（NLP）
    - 计算机视觉
    - 推荐系统
    - 自动驾驶
    - 医疗诊断

    ## 未来展望

    随着技术的不断发展，人工智能将在更多领域发挥重要作用，
    为人类社会带来更大的价值。
    """

    with open(sample_dir / "ai_history.txt", "w", encoding="utf-8") as f:
        f.write(sample_text)

    # 创建示例CSV文件
    sample_csv = """公司,成立年份,创始人,总部位置,主要产品
Google,1998,拉里·佩奇,加利福尼亚,搜索引擎
Microsoft,1975,比尔·盖茨,华盛顿州,操作系统
Apple,1976,史蒂夫·乔布斯,加利福尼亚,消费电子产品
Amazon,1994,杰夫·贝索斯,华盛顿州,电子商务
Tesla,2003,埃隆·马斯克,加利福尼亚,电动汽车
"""

    with open(sample_dir / "tech_companies.csv", "w", encoding="utf-8") as f:
        f.write(sample_csv)

    # 创建示例JSON文件
    sample_json = {
        "项目信息": {
            "名称": "大文件分解系统",
            "版本": "1.0.0",
            "开发者": "AI助手",
            "创建日期": "2024-12-19"
        },
        "功能列表": [
            "文件加载和解析",
            "智能文档分割",
            "内容分析和摘要",
            "向量相似性搜索",
            "交互式问答"
        ],
        "技术栈": {
            "核心框架": "LangChain v1.0",
            "向量数据库": "FAISS",
            "嵌入模型": "OpenAI text-embedding-3-small",
            "语言模型": "Claude Sonnet"
        },
        "性能指标": {
            "支持文件类型": ["PDF", "TXT", "CSV", "HTML", "JSON", "MD"],
            "最大文件大小": "100MB",
            "处理速度": "1000字符/秒",
            "准确性": "95%+"
        }
    }

    with open(sample_dir / "project_config.json", "w", encoding="utf-8") as f:
        import json
        json.dump(sample_json, f, ensure_ascii=False, indent=2)

    print(f"示例文件已创建在 {sample_dir} 目录中")
    return sample_dir

def demo_file_analysis():
    """演示文件分析功能"""
    print("\n" + "="*60)
    print("🚀 大文件分解和理解 Agent 演示")
    print("="*60)

    # 创建示例文件
    sample_dir = create_sample_files()

    try:
        # 初始化 Agent
        print("\n📋 步骤 1: 初始化文件分解 Agent")
        agent = FileDecomposerAgent(model_name="claude-sonnet-4-5-20250929")
        print("✅ Agent 初始化成功")

        # 分析文本文件
        print("\n📋 步骤 2: 分析文本文件")
        txt_file = sample_dir / "ai_history.txt"

        # 加载文件
        print(f"正在加载文件: {txt_file}")
        load_result = agent._load_file_tool(str(txt_file))
        print(load_result)

        # 分割文档
        print("\n正在分割文档...")
        split_result = agent._split_document_tool(str(txt_file), chunk_size=500, chunk_overlap=100)
        print(split_result)

        # 分析内容
        print("\n正在分析内容...")
        analysis_result = agent._analyze_content_tool(str(txt_file))
        print(analysis_result)

        # 生成摘要
        print("\n正在生成摘要...")
        summary_result = agent._generate_summary_tool(str(txt_file))
        print(summary_result)

        # 建立向量索引
        print("\n正在建立向量索引...")
        index_result = agent.build_vector_index(str(txt_file))
        print(index_result)

        # 演示搜索功能
        print("\n📋 步骤 3: 演示搜索功能")
        search_result = agent._search_similar_content_tool("人工智能的历史发展", k=2)
        print(search_result)

        # 演示对话功能
        print("\n📋 步骤 4: 演示与文件对话")
        chat_result = agent.chat_with_file(
            str(txt_file),
            "人工智能经历了哪几个主要发展阶段？"
        )
        print(chat_result)

        # 演示信息提取
        print("\n📋 步骤 5: 演示信息提取")
        extract_types = ["main_points", "names", "dates"]

        for extract_type in extract_types:
            print(f"\n提取 {extract_type}:")
            extract_result = agent._extract_key_info_tool(str(txt_file), extract_type)
            print(extract_result)

        # 分析CSV文件
        print("\n📋 步骤 6: 分析CSV文件")
        csv_file = sample_dir / "tech_companies.csv"

        print(f"正在加载CSV文件: {csv_file}")
        csv_load_result = agent._load_file_tool(str(csv_file))
        print(csv_load_result)

        csv_analysis = agent._analyze_content_tool(str(csv_file))
        print("\nCSV文件分析结果:")
        print(csv_analysis)

        # 分析JSON文件
        print("\n📋 步骤 7: 分析JSON文件")
        json_file = sample_dir / "project_config.json"

        print(f"正在加载JSON文件: {json_file}")
        json_load_result = agent._load_file_tool(str(json_file))
        print(json_load_result)

        json_analysis = agent._analyze_content_tool(str(json_file))
        print("\nJSON文件分析结果:")
        print(json_analysis)

        # 获取所有文件状态
        print("\n📋 步骤 8: 获取文件处理状态")
        status = agent.get_file_status()
        print("\n所有文件状态:")
        for file_path, file_status in status.items():
            print(f"文件: {file_path}")
            print(f"  类型: {file_status['file_type']}")
            print(f"  大小: {file_status['file_size']:,} 字节")
            print(f"  块数: {file_status['chunk_count']}")
            print()

        print("\n🎉 演示完成！")
        print("\n💡 使用提示:")
        print("1. 将示例文件路径替换为您自己的文件路径")
        print("2. 根据需要调整分割参数（chunk_size, chunk_overlap）")
        print("3. 使用不同的信息提取类型来获取特定内容")
        print("4. 通过向量搜索快速定位相关内容")
        print("5. 使用对话功能进行深入分析")

    except Exception as e:
        print(f"\n❌ 演示过程中出现错误: {e}")
        print("请检查:")
        print("1. 是否安装了所有必需的依赖")
        print("2. API密钥是否正确配置")
        print("3. 文件路径是否正确")

def interactive_demo():
    """交互式演示"""
    print("\n" + "="*60)
    print("🎮 交互式文件分析演示")
    print("="*60)

    try:
        agent = FileDecomposerAgent()

        print("\n请输入要分析的文件路径 (按回车使用示例):")
        file_path = input("文件路径: ").strip()

        if not file_path:
            sample_dir = create_sample_files()
            file_path = str(sample_dir / "ai_history.txt")
            print(f"使用示例文件: {file_path}")

        # 检查文件是否存在
        if not Path(file_path).exists():
            print(f"❌ 文件不存在: {file_path}")
            return

        print(f"\n🚀 开始分析文件: {file_path}")

        # 加载文件
        print("\n1. 加载文件...")
        load_result = agent._load_file_tool(file_path)
        print(load_result)

        # 分析内容
        print("\n2. 分析内容...")
        analysis_result = agent._analyze_content_tool(file_path)
        print(analysis_result)

        # 建立索引
        print("\n3. 建立向量索引...")
        index_result = agent.build_vector_index(file_path)
        print(index_result)

        # 交互式问答
        print("\n💬 现在您可以与文件对话 (输入 'quit' 退出):")
        while True:
            question = input("\n您的问题: ").strip()
            if question.lower() in ['quit', 'exit', 'q']:
                break

            if question:
                chat_result = agent.chat_with_file(file_path, question)
                print(chat_result)

        print("\n感谢使用！👋")

    except Exception as e:
        print(f"\n❌ 交互式演示错误: {e}")

if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "interactive":
        interactive_demo()
    else:
        demo_file_analysis()

        print("\n" + "="*60)
        print("💡 运行选项:")
        print("1. python demo_file_decomposition.py          # 自动演示")
        print("2. python demo_file_decomposition.py interactive  # 交互式演示")
        print("="*60)