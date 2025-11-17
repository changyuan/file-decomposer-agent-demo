.PHONY: help install dev-install test lint format run-demo run-simple clean

help: ## 显示帮助信息
	@echo "大文件分解和理解 Agent - 可用命令:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

install: ## 安装项目依赖
	uv sync

dev-install: ## 安装开发依赖
	uv sync --dev

test: ## 运行测试
	uv run pytest tests/

lint: ## 运行代码检查
	uv run flake8 src/
	uv run mypy src/

format: ## 格式化代码
	uv run black src/ tests/ examples/
	uv run isort src/ tests/ examples/

run-demo: ## 运行完整演示
	@echo "正在启动完整演示..."
	uv run demo_file_decomposition.py

run-simple: ## 运行简单演示
	@echo "正在启动简单演示..."
	uv run simple_demo.py

run-interactive: ## 运行交互模式
	@echo "启动交互模式..."
	@echo "使用方法: uv run main <文件路径> [--question '问题']"
	uv run main --help

quickstart: ## 快速启动
	@echo "正在启动快速开始向导..."
	uv run quickstart.py

setup-env: ## 设置环境变量
	@if [ ! -f .env ]; then \
		echo "创建 .env 文件..."; \
		cp .env.example .env; \
		echo "请编辑 .env 文件并设置您的 API 密钥"; \
	else \
		echo ".env 文件已存在"; \
	fi

clean: ## 清理临时文件
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.orig" -delete
	find . -type f -name "*.rej" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name "*.egg-info" -exec rm -rf {} +

check: ## 检查项目状态
	@echo "🔍 项目状态检查"
	@echo "================"
	@echo "Python 版本:"
	@uv run python --version
	@echo ""
	@echo "依赖包:"
	@uv pip list
	@echo ""
	@echo "项目文件:"
	@find src/ -name "*.py" | wc -l | xargs echo "Python 文件:"
	@find tests/ -name "*.py" | wc -l | xargs echo "测试文件:"
	@echo ""
	@echo "环境配置:"
	@if [ -f .env ]; then echo "✅ .env 文件存在"; else echo "⚠️  .env 文件不存在"; fi