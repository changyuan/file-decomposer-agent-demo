"""
大文件分解和理解 Agent

基于 LangChain v1.0 和 deepagents 框架的智能文件分析系统
"""

__version__ = "1.0.0"
__author__ = "AI Assistant"
__email__ = "assistant@example.com"
__description__ = "基于 LangChain v1.0 和 deepagents 框架的大文件分解和理解系统"

from .file_decomposer_agent import FileDecomposerAgent
from .config import AgentConfig, config, load_config

__all__ = [
    "FileDecomposerAgent",
    "AgentConfig",
    "config",
    "load_config"
]