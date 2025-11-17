#!/usr/bin/env python3
"""
配置文件 - 大文件分解和理解 Agent
"""

import os
from dataclasses import dataclass
from typing import Optional

@dataclass
class AgentConfig:
    """Agent 配置类"""

    # 模型配置
    MODEL_NAME: str = "claude-sonnet-4-5-20250929"
    OPENAI_API_KEY: Optional[str] = None
    ANTHROPIC_API_KEY: Optional[str] = None

    # 文本分割配置
    DEFAULT_CHUNK_SIZE: int = 1000
    DEFAULT_CHUNK_OVERLAP: int = 200

    # 向量存储配置
    VECTOR_STORE_TYPE: str = "FAISS"
    EMBEDDING_MODEL: str = "openai:text-embedding-3-small"

    # 文件处理配置
    MAX_FILE_SIZE: int = 100 * 1024 * 1024  # 100MB
    SUPPORTED_FORMATS: list = None

    # 日志配置
    LOG_LEVEL: str = "INFO"
    LOG_FORMAT: str = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"

    def __post_init__(self):
        if self.SUPPORTED_FORMATS is None:
            self.SUPPORTED_FORMATS = [
                '.pdf', '.txt', '.csv', '.html', '.htm',
                '.json', '.md', '.markdown', '.rtf'
            ]

        # 从环境变量加载API密钥
        self.OPENAI_API_KEY = os.getenv('OPENAI_API_KEY', self.OPENAI_API_KEY)
        self.ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY', self.ANTHROPIC_API_KEY)

        # 验证API密钥
        if not self.OPENAI_API_KEY and not self.ANTHROPIC_API_KEY:
            print("⚠️  警告: 未设置 API 密钥，某些功能可能无法使用")

    def validate(self) -> bool:
        """验证配置"""
        errors = []

        if not self.MODEL_NAME:
            errors.append("模型名称不能为空")

        if self.DEFAULT_CHUNK_SIZE <= 0:
            errors.append("块大小必须大于0")

        if self.DEFAULT_CHUNK_OVERLAP < 0:
            errors.append("重叠大小不能为负数")

        if self.MAX_FILE_SIZE <= 0:
            errors.append("最大文件大小必须大于0")

        if errors:
            for error in errors:
                print(f"❌ 配置错误: {error}")
            return False

        return True

# 全局配置实例
config = AgentConfig()

# 预定义的配置模板
CONFIG_TEMPLATES = {
    "development": AgentConfig(
        MODEL_NAME="claude-sonnet-4-5-20250929",
        DEFAULT_CHUNK_SIZE=500,
        DEFAULT_CHUNK_OVERLAP=100,
        LOG_LEVEL="DEBUG"
    ),
    "production": AgentConfig(
        MODEL_NAME="claude-sonnet-4-5-20250929",
        DEFAULT_CHUNK_SIZE=1000,
        DEFAULT_CHUNK_OVERLAP=200,
        LOG_LEVEL="INFO"
    ),
    "research": AgentConfig(
        MODEL_NAME="claude-sonnet-4-5-20250929",
        DEFAULT_CHUNK_SIZE=2000,
        DEFAULT_CHUNK_OVERLAP=400,
        LOG_LEVEL="DEBUG"
    )
}

def load_config(environment: str = "development") -> AgentConfig:
    """加载指定环境的配置"""
    template = CONFIG_TEMPLATES.get(environment)
    if template:
        return template
    else:
        print(f"⚠️  未知环境: {environment}, 使用默认配置")
        return AgentConfig()

def save_config_to_env(config: AgentConfig):
    """将配置保存到环境变量"""
    os.environ['MODEL_NAME'] = config.MODEL_NAME
    if config.OPENAI_API_KEY:
        os.environ['OPENAI_API_KEY'] = config.OPENAI_API_KEY
    if config.ANTHROPIC_API_KEY:
        os.environ['ANTHROPIC_API_KEY'] = config.ANTHROPIC_API_KEY

if __name__ == "__main__":
    print("🔧 Agent 配置信息")
    print(f"模型: {config.MODEL_NAME}")
    print(f"默认块大小: {config.DEFAULT_CHUNK_SIZE}")
    print(f"默认重叠: {config.DEFAULT_CHUNK_OVERLAP}")
    print(f"支持格式: {', '.join(config.SUPPORTED_FORMATS)}")
    print(f"最大文件大小: {config.MAX_FILE_SIZE / (1024*1024):.1f}MB")

    # 验证配置
    if config.validate():
        print("✅ 配置验证通过")
    else:
        print("❌ 配置验证失败")