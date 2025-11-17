#!/usr/bin/env python3
"""
快速启动脚本 - 大文件分解和理解 Agent
一键测试所有核心功能
"""

import os
import sys
from pathlib import Path

# 添加当前目录到 Python 路径
sys.path.insert(0, str(Path(__file__).parent))

def check_dependencies():
    """检查依赖是否已安装"""
    required_packages = [
        'langchain',
        'langchain_community',
        'langchain_core',
        'langchain_text_splitters',
        'faiss',
        'pypdf'
    ]

    missing_packages = []

    for package in required_packages:
        try:
            __import__(package.replace('-', '_'))
        except ImportError:
            missing_packages.append(package)

    if missing_packages:
        print("❌ 缺少以下依赖包:")
        for package in missing_packages:
            print(f"   - {package}")
        print("\n请运行以下命令安装:")
        print(f"pip install {' '.join(missing_packages)}")
        return False

    print("✅ 所有依赖包已安装")
    return True

def check_api_keys():
    """检查 API 密钥配置"""
    anthropic_key = os.getenv('ANTHROPIC_API_KEY')
    openai_key = os.getenv('OPENAI_API_KEY')

    if not anthropic_key:
        print("⚠️  未设置 ANTHROPIC_API_KEY")
        print("   请在 .env 文件中设置您的 Anthropic API 密钥")
        print("   获取地址: https://console.anthropic.com/")
        return False

    print("✅ Anthropic API 密钥已配置")

    if not openai_key:
        print("⚠️  未设置 OPENAI_API_KEY (可选)")
        print("   如需使用嵌入功能，请设置 OpenAI API 密钥")
        print("   获取地址: https://platform.openai.com/api-keys")

    return True

def create_test_file():
    """创建测试文件"""
    test_dir = Path("test_files")
    test_dir.mkdir(exist_ok=True)

    test_content = """
    大数据技术概述

    大数据是指无法使用传统数据处理工具在合理时间内处理的大量、高速、多样的数据资产。
    大数据的五个V特征包括：Volume（体量大）、Velocity（速度快）、Variety（种类多）、
    Veracity（真实性）和Value（价值密度低）。

    ## 主要技术栈

    ### 数据存储
    - Hadoop HDFS: 分布式文件系统
    - Apache Cassandra: 分布式数据库
    - MongoDB: 文档数据库
    - Redis: 内存数据库

    ### 数据处理
    - Apache Spark: 大数据处理引擎
    - Apache Flink: 流处理框架
    - Apache Storm: 实时计算系统
    - Hadoop MapReduce: 分布式计算框架

    ### 数据分析
    - Apache Hive: 数据仓库工具
    - Apache Pig: 数据分析平台
    - Apache Kafka: 消息队列系统
    - Elasticsearch: 搜索引擎

    ## 应用场景

    大数据技术广泛应用于以下场景：
    1. 电子商务推荐系统
    2. 金融风控和欺诈检测
    3. 智慧城市建设
    4. 医疗健康数据分析
    5. 工业互联网和智能制造

    ## 技术发展趋势

    随着人工智能和机器学习技术的快速发展，大数据技术正朝着更加智能化、自动化的方向发展。
    实时数据处理、云原生大数据平台、以及隐私计算技术成为新的热点。

    ## 挑战与机遇

    大数据技术的发展面临着数据安全、隐私保护、技术标准化等挑战，
    同时也为各行各业带来了巨大的创新机遇。
    """

    test_file = test_dir / "big_data_overview.txt"
    with open(test_file, 'w', encoding='utf-8') as f:
        f.write(test_content)

    print(f"✅ 测试文件已创建: {test_file}")
    return test_file

def run_quick_test():
    """运行快速测试"""
    print("\n🚀 开始快速功能测试")
    print("="*50)

    try:
        from file_decomposer_agent import FileDecomposerAgent

        # 创建测试文件
        test_file = create_test_file()

        # 创建 Agent
        print("\n📋 步骤 1: 创建 Agent 实例")
        agent = FileDecomposerAgent()
        print("✅ Agent 创建成功")

        # 测试文件加载
        print("\n📋 步骤 2: 测试文件加载")
        load_result = agent._load_file_tool(str(test_file))
        print("✅ 文件加载成功")
        print(f"   预览: {load_result[:100]}...")

        # 测试文档分割
        print("\n📋 步骤 3: 测试文档分割")
        split_result = agent._split_document_tool(str(test_file))
        print("✅ 文档分割成功")

        # 测试内容分析
        print("\n📋 步骤 4: 测试内容分析")
        analysis_result = agent._analyze_content_tool(str(test_file))
        print("✅ 内容分析完成")

        # 测试摘要生成
        print("\n📋 步骤 5: 测试摘要生成")
        summary_result = agent._generate_summary_tool(str(test_file))
        print("✅ 摘要生成完成")

        # 测试向量索引
        print("\n📋 步骤 6: 测试向量索引")
        index_result = agent.build_vector_index(str(test_file))
        print("✅ 向量索引建立完成")

        # 测试搜索功能
        print("\n📋 步骤 7: 测试搜索功能")
        search_result = agent._search_similar_content_tool("大数据技术", k=2)
        print("✅ 搜索功能正常")

        # 测试信息提取
        print("\n📋 步骤 8: 测试信息提取")
        extract_result = agent._extract_key_info_tool(str(test_file), "main_points")
        print("✅ 信息提取完成")

        # 测试对话功能
        print("\n📋 步骤 9: 测试对话功能")
        chat_result = agent.chat_with_file(str(test_file), "大数据的主要特征是什么？")
        print("✅ 对话功能正常")

        print("\n🎉 所有功能测试通过！")
        print("\n📊 测试总结:")
        print("   ✅ 文件加载和解析")
        print("   ✅ 文档智能分割")
        print("   ✅ 内容分析和统计")
        print("   ✅ 自动摘要生成")
        print("   ✅ 向量索引建立")
        print("   ✅ 相似性搜索")
        print("   ✅ 关键信息提取")
        print("   ✅ 交互式问答")

        return True

    except Exception as e:
        print(f"\n❌ 测试失败: {e}")
        print("\n🔧 故障排除:")
        print("   1. 检查 API 密钥是否正确配置")
        print("   2. 确认所有依赖包已安装")
        print("   3. 查看完整错误信息进行调试")
        return False

def interactive_menu():
    """交互式菜单"""
    while True:
        print("\n" + "="*60)
        print("🎯 大文件分解和理解 Agent - 快速启动")
        print("="*60)
        print("1. 运行快速功能测试")
        print("2. 分析自定义文件")
        print("3. 查看使用说明")
        print("4. 检查环境配置")
        print("5. 退出")
        print("-"*60)

        choice = input("请选择操作 (1-5): ").strip()

        if choice == '1':
            run_quick_test()

        elif choice == '2':
            file_path = input("请输入要分析的文件路径: ").strip()
            if Path(file_path).exists():
                try:
                    from file_decomposer_agent import FileDecomposerAgent

                    agent = FileDecomposerAgent()
                    agent._load_file_tool(file_path)
                    agent.build_vector_index(file_path)

                    print(f"\n💬 文件 {file_path} 已准备就绪，您可以开始提问:")
                    while True:
                        question = input("\n您的问题 (输入 'quit' 返回菜单): ").strip()
                        if question.lower() in ['quit', 'q', 'exit']:
                            break
                        if question:
                            answer = agent.chat_with_file(file_path, question)
                            print(f"\n📝 答案:\n{answer}")
                except Exception as e:
                    print(f"❌ 分析失败: {e}")
            else:
                print("❌ 文件不存在")

        elif choice == '3':
            show_usage_guide()

        elif choice == '4':
            check_environment()

        elif choice == '5':
            print("👋 感谢使用！")
            break

        else:
            print("❌ 无效选择，请重试")

def show_usage_guide():
    """显示使用指南"""
    print("\n📖 使用指南")
    print("="*50)
    print("""
🔧 基本使用流程:

1. 准备文件
   - 支持格式: PDF, TXT, CSV, HTML, JSON, MD
   - 文件大小建议: < 100MB

2. 配置环境
   - 复制 .env.example 为 .env
   - 设置 ANTHROPIC_API_KEY
   - (可选) 设置 OPENAI_API_KEY

3. 运行分析
   python quickstart.py

💡 主要功能:

📄 文件加载
   agent._load_file_tool(file_path)

✂️ 智能分割
   agent._split_document_tool(file_path, chunk_size=1000)

📊 内容分析
   agent._analyze_content_tool(file_path)

🔍 向量搜索
   agent._search_similar_content_tool(query, k=3)

💬 智能问答
   agent.chat_with_file(file_path, question)

🎯 信息提取
   agent._extract_key_info_tool(file_path, "main_points")

📈 性能建议:
   - 小文件: chunk_size=500
   - 中等文件: chunk_size=1000
   - 大文件: chunk_size=2000
""")

def check_environment():
    """检查环境配置"""
    print("\n🔍 环境检查")
    print("="*30)

    # 检查依赖
    print("1. 检查依赖包...")
    deps_ok = check_dependencies()

    # 检查 API 密钥
    print("\n2. 检查 API 密钥...")
    keys_ok = check_api_keys()

    # 检查配置文件
    print("\n3. 检查配置文件...")
    if Path('.env').exists():
        print("✅ .env 文件存在")
    else:
        print("⚠️  .env 文件不存在，已创建示例文件")
        Path('.env.example').rename('.env')
        print("   请编辑 .env 文件并设置您的 API 密钥")

    # 检查 Python 版本
    print("\n4. 检查 Python 版本...")
    import sys
    python_version = sys.version_info
    if python_version >= (3, 8):
        print(f"✅ Python 版本: {python_version.major}.{python_version.minor}.{python_version.micro}")
    else:
        print(f"⚠️  Python 版本过低: {python_version.major}.{python_version.minor}")
        print("   建议升级到 Python 3.8+")

    # 总结
    print("\n📋 环境状态总结:")
    print(f"   依赖包: {'✅' if deps_ok else '❌'}")
    print(f"   API 密钥: {'✅' if keys_ok else '⚠️'}")
    print(f"   配置文件: {'✅' if Path('.env').exists() else '⚠️'}")

def main():
    """主函数"""
    print("🎉 欢迎使用大文件分解和理解 Agent!")
    print("基于 LangChain v1.0 和 deepagents 框架")

    # 检查是否在交互模式
    if len(sys.argv) > 1:
        if sys.argv[1] == 'test':
            run_quick_test()
        elif sys.argv[1] == 'check':
            check_environment()
        elif sys.argv[1] == 'guide':
            show_usage_guide()
    else:
        interactive_menu()

if __name__ == "__main__":
    main()