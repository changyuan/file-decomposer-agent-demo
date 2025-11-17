# 项目设置指南

## 🚀 快速开始

### 1. 环境配置
```bash
# 设置环境变量
cp .env.example .env
# 编辑 .env 文件，添加您的 API 密钥
```

### 2. 安装依赖
```bash
# 使用 uv 安装所有依赖
make install
# 或者
uv sync
```

### 3. 验证安装
```bash
# 运行简单测试
make check
```

### 4. 使用项目
```bash
# 运行简单演示
make run-simple

# 运行完整演示
make run-demo

# 使用命令行工具
uv run main <your-file.txt>

# 交互式模式
uv run main <your-file.txt>
```

## 📁 项目结构

```
file-decomposer-agent/
├── src/file_decomposer_agent/    # 主要源代码
│   ├── __init__.py               # 包初始化
│   ├── file_decomposer_agent.py  # 核心 Agent 类
│   ├── config.py                 # 配置管理
│   └── quickstart.py             # 快速启动脚本
├── examples/                      # 示例和演示
│   └── demo_file_decomposition.py
├── tests/                         # 测试文件
├── main.py                        # 主入口文件
├── pyproject.toml                 # 项目配置
├── Makefile                       # 构建脚本
├── README.md                      # 文档
└── .env.example                   # 环境变量示例
```

## 🔧 可用命令

### Makefile 命令
```bash
make help              # 显示帮助
make install           # 安装依赖
make dev-install       # 安装开发依赖
make test              # 运行测试
make lint              # 代码检查
make format            # 代码格式化
make run-demo          # 运行演示
make run-simple        # 运行简单演示
make quickstart        # 快速启动
make setup-env         # 设置环境
make clean             # 清理临时文件
make check             # 检查项目状态
```

### uv 命令
```bash
uv run main <file>                 # 分析文件
uv run quickstart.py               # 快速开始
uv run demo_file_decomposition.py  # 完整演示
uv run simple_demo.py              # 简单演示
uv pip list                        # 查看已安装包
uv sync                            # 同步依赖
uv add <package>                   # 添加依赖
uv remove <package>                # 移除依赖
```

## 🔑 API 密钥配置

### 必需
- `ANTHROPIC_API_KEY`: 用于 Claude 模型访问

### 可选
- `OPENAI_API_KEY`: 用于 OpenAI 嵌入模型

### 获取密钥
- Anthropic: https://console.anthropic.com/
- OpenAI: https://platform.openai.com/api-keys

## 📝 使用示例

### 基本用法
```python
from src.file_decomposer_agent import FileDecomposerAgent

# 创建 Agent
agent = FileDecomposerAgent()

# 加载文件
agent._load_file_tool("document.pdf")

# 建立索引
agent.build_vector_index("document.pdf")

# 问答
answer = agent.chat_with_file("document.pdf", "这个文档的主要观点是什么？")
```

### 命令行用法
```bash
# 分析文件并提问
uv run main document.pdf --question "主要内容包括什么？"

# 交互式模式
uv run main document.pdf
```

## 🐛 故障排除

### 依赖安装失败
```bash
# 清理并重新安装
rm -rf .venv
uv sync
```

### API 密钥错误
```bash
# 检查环境变量
cat .env
echo $ANTHROPIC_API_KEY
```

### 权限问题
```bash
# 确保文件有执行权限
chmod +x main.py
```

## 📚 更多信息

- 完整文档: [README.md](README.md)
- 项目总结: [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)
- 配置说明: [src/file_decomposer_agent/config.py](src/file_decomposer_agent/config.py)