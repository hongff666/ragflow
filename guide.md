# RAGFlow 项目结构指南

> 为新开发人员提供的 RAGFlow 项目全面指南

## 项目概述

RAGFlow 是一个基于深度文档理解的开源 RAG（检索增强生成）引擎。它为各种规模的企业提供简化的 RAG 工作流程，结合大语言模型（LLM）提供真实的问答能力，支持各种复杂格式数据的引用。

**当前版本**: v0.19.1  
**主要技术栈**: Python (后端) + React/TypeScript (前端) + Docker  
**架构模式**: 微服务架构，支持多种文档引擎和存储后端

## 项目核心目录结构

```
ragflow/
├── api/                    # 后端 API 服务
├── web/                    # 前端 React 应用
├── rag/                    # RAG 核心引擎
├── agent/                  # AI 智能体系统
├── deepdoc/               # 深度文档解析
├── docker/                # Docker 部署配置
├── conf/                  # 配置文件
├── graphrag/              # 知识图谱 RAG
├── plugin/                # 插件系统
├── sdk/                   # Python SDK
├── sandbox/               # 代码沙盒执行环境
├── mcp/                   # MCP 服务器
└── test/                  # 测试代码
```

## 1. 后端服务架构 (`api/`)

### 1.1 目录结构
```
api/
├── apps/                  # 应用层 - REST API 接口
│   ├── auth/             # 认证模块 (OAuth, OIDC, GitHub)
│   ├── kb_app.py         # 知识库管理 API
│   ├── document_app.py   # 文档管理 API
│   ├── chunk_app.py      # 文档块管理 API
│   ├── conversation_app.py # 对话管理 API
│   ├── llm_app.py        # LLM 模型管理 API
│   └── sdk/              # SDK API 接口
├── db/                   # 数据层
│   ├── db_models.py      # 数据库模型定义
│   ├── services/         # 业务逻辑服务层
│   └── runtime_config.py # 运行时配置
├── utils/                # 工具类
└── ragflow_server.py     # 主服务入口
```

### 1.2 核心功能模块

**认证系统** (`auth/`):
- 支持 OAuth2、OIDC、GitHub 等多种认证方式
- 提供统一的用户身份验证和授权机制

**知识库管理** (`kb_app.py`):
- 知识库的创建、更新、删除
- 知识库配置管理（解析器、分块策略等）

**文档处理** (`document_app.py`):
- 文档上传、解析、索引
- 支持多种文档格式（PDF、DOCX、PPT、Excel等）

**对话系统** (`conversation_app.py`):
- 聊天会话管理
- 消息历史记录
- 流式响应支持

### 1.3 启动入口
主服务器启动文件: `api/ragflow_server.py`
- 初始化数据库连接
- 启动 Flask 应用
- 配置日志和中间件

## 2. 前端应用架构 (`web/`)

### 2.1 技术栈
- **框架**: React 18 + TypeScript
- **构建工具**: UmiJS 4
- **UI 库**: Ant Design + Radix UI + Tailwind CSS
- **状态管理**: Zustand + React Query
- **样式**: Less + Tailwind CSS

### 2.2 目录结构
```
web/src/
├── pages/                # 页面组件
│   ├── add-knowledge/    # 知识库管理页面
│   ├── chat/            # 聊天界面
│   ├── dataset/         # 数据集管理
│   ├── agent/           # AI 智能体
│   ├── file-manager/    # 文件管理
│   └── user-setting/    # 用户设置
├── components/          # 可复用组件
│   ├── ui/             # 基础 UI 组件
│   ├── file-icon/      # 文件图标组件
│   ├── message-item/   # 消息组件
│   └── llm-select/     # LLM 选择组件
├── hooks/              # 自定义 Hooks
├── services/           # API 服务层
├── utils/              # 工具函数
├── constants/          # 常量定义
├── interfaces/         # TypeScript 类型定义
└── locales/           # 国际化资源
```

### 2.3 核心页面功能

**知识库管理** (`pages/add-knowledge/`):
- 文档上传和管理
- 文档分块预览
- 知识图谱可视化
- 配置管理

**聊天界面** (`pages/chat/`):
- 实时对话
- 消息历史
- 引用文档显示
- 配置面板

**智能体** (`pages/agent/`):
- 可视化工作流编辑器
- 基于节点的流程设计
- 组件库和模板

## 3. RAG 核心引擎 (`rag/`)

### 3.1 核心模块
```
rag/
├── app/                # 应用层解析器
│   ├── naive.py        # 通用解析器
│   ├── manual.py       # 手册解析器
│   ├── paper.py        # 论文解析器
│   ├── book.py         # 书籍解析器
│   └── qa.py           # 问答解析器
├── llm/                # LLM 集成
│   ├── chat_model.py   # 聊天模型接口
│   ├── embedding_model.py # 嵌入模型
│   └── rerank_model.py # 重排序模型
├── nlp/                # 自然语言处理
│   ├── search.py       # 搜索算法
│   ├── query.py        # 查询处理
│   └── rag_tokenizer.py # 分词器
├── utils/              # 连接器
│   ├── es_conn.py      # Elasticsearch 连接
│   ├── infinity_conn.py # Infinity 数据库连接
│   └── redis_conn.py   # Redis 连接
└── svr/                # 服务器组件
    └── task_executor.py # 任务执行器
```

### 3.2 文档解析策略
RAGFlow 提供多种针对性的解析策略:

- **Naive**: 通用文档解析
- **Manual**: 手册类文档优化
- **Paper**: 学术论文专用解析
- **Book**: 书籍章节结构解析
- **Q&A**: 问答对格式解析
- **Resume**: 简历结构化解析
- **Laws**: 法律文档解析
- **Presentation**: 演示文稿解析

### 3.3 支持的存储后端
- **Elasticsearch**: 默认全文检索引擎
- **Infinity**: 高性能向量数据库
- **OpenSearch**: Elasticsearch 的开源替代
- **Redis**: 缓存和会话存储
- **MySQL**: 关系型数据存储
- **MinIO**: 对象存储

## 4. 智能体系统 (`agent/`)

### 4.1 组件化架构
```
agent/component/
├── base.py             # 基础组件类
├── begin.py            # 开始组件
├── generate.py         # 生成组件
├── retrieval.py        # 检索组件
├── categorize.py       # 分类组件
├── switch.py           # 条件分支
├── iteration.py        # 循环组件
├── code.py             # 代码执行
└── exesql.py          # SQL 执行
```

### 4.2 智能体模板
`agent/templates/` 目录包含预定义的智能体模板:
- **customer_service.json**: 客服助手
- **investment_advisor.json**: 投资顾问
- **medical_consultation.json**: 医疗咨询
- **text2sql.json**: 文本转SQL
- **research_report.json**: 研究报告生成

### 4.3 组件类型说明

**基础组件**:
- `Begin`: 工作流起始点
- `Generate`: LLM 文本生成
- `Answer`: 最终答案输出

**检索组件**:
- `Retrieval`: 从知识库检索
- `Relevant`: 相关性判断
- `Rewrite`: 查询重写

**逻辑控制**:
- `Switch`: 条件分支
- `Categorize`: 分类路由
- `Iteration`: 循环执行

**工具组件**:
- `Code`: Python/JavaScript 代码执行
- `ExeSQL`: 数据库查询
- `Email`: 邮件发送

## 5. 文档解析引擎 (`deepdoc/`)

### 5.1 解析能力
```
deepdoc/
├── parser/             # 文档解析器
│   ├── pdf_parser.py   # PDF 解析
│   ├── docx_parser.py  # Word 文档解析
│   ├── excel_parser.py # Excel 解析
│   ├── ppt_parser.py   # PowerPoint 解析
│   └── html_parser.py  # HTML 解析
└── vision/             # 视觉识别
    ├── ocr.py          # OCR 文字识别
    ├── layout_recognizer.py # 版面识别
    └── table_structure_recognizer.py # 表格结构识别
```

### 5.2 深度文档理解特性
- **版面分析**: 自动识别文档结构（标题、段落、表格、图片）
- **OCR 识别**: 支持扫描文档的文字提取
- **表格解析**: 智能识别表格结构和内容
- **图像理解**: 提取图片中的文本和语义信息
- **多语言支持**: 支持中英文等多种语言

## 6. 部署配置 (`docker/`)

### 6.1 部署方式
```
docker/
├── docker-compose.yml          # 主部署文件
├── docker-compose-base.yml     # 基础服务
├── docker-compose-gpu.yml      # GPU 支持
├── .env                        # 环境变量配置
├── service_conf.yaml.template  # 服务配置模板
└── nginx/                      # Nginx 配置
```

### 6.2 核心配置文件

**.env 配置项**:
```bash
# 文档引擎选择
DOC_ENGINE=opensearch  # elasticsearch/infinity/opensearch

# 数据库配置
MYSQL_PASSWORD=infini_rag_flow
MYSQL_HOST=mysql
MYSQL_PORT=5455

# 对象存储配置
MINIO_USER=rag_flow
MINIO_PASSWORD=infini_rag_flow

# 服务端口
SVR_HTTP_PORT=9380

# Docker 镜像版本
RAGFLOW_IMAGE=infiniflow/ragflow:v0.19.1-slim
```

**service_conf.yaml 主要配置**:
- 数据库连接参数
- LLM 服务配置
- 存储后端设置
- 认证服务配置

### 6.3 部署步骤
1. **环境准备**: Docker >= 24.0.0, RAM >= 16GB
2. **启动服务**: `docker compose up -d`
3. **配置检查**: `docker logs ragflow-server`
4. **访问界面**: `http://IP:9380`

## 7. 开发环境搭建

### 7.1 从源码启动
```bash
# 1. 安装依赖管理器
pipx install uv pre-commit

# 2. 克隆代码并安装依赖
git clone https://github.com/infiniflow/ragflow.git
cd ragflow/
uv sync --python 3.10 --all-extras
uv run download_deps.py
pre-commit install

# 3. 启动基础服务
docker compose -f docker/docker-compose-base.yml up -d

# 4. 配置 hosts
echo "127.0.0.1 es01 infinity mysql minio redis sandbox-executor-manager" >> /etc/hosts

# 5. 启动后端服务
source .venv/bin/activate
export PYTHONPATH=$(pwd)
bash docker/launch_backend_service.sh

# 6. 启动前端服务
cd web
npm install
npm run dev
```

### 7.2 开发工具配置
- **Python**: 3.10-3.12
- **Node.js**: >= 18.20.4
- **代码格式化**: Ruff (Python) + Prettier (TypeScript)
- **预提交检查**: pre-commit hooks

## 8. API 接口说明

### 8.1 主要 API 端点
```
# 知识库管理
POST /v1/dataset          # 创建知识库
GET /v1/dataset           # 获取知识库列表
PUT /v1/dataset/{id}      # 更新知识库
DELETE /v1/dataset/{id}   # 删除知识库

# 文档管理
POST /v1/document         # 上传文档
GET /v1/document          # 获取文档列表
POST /v1/document/run     # 开始解析文档

# 对话接口
POST /v1/chat             # 发送消息
GET /v1/chat/history      # 获取历史记录

# 智能体
POST /v1/agent            # 创建智能体
GET /v1/agent             # 获取智能体列表
POST /v1/agent/run        # 运行智能体
```

### 8.2 认证方式
- **API Key**: 通过 `Authorization: Bearer <api_key>` 头部认证
- **Session**: Web 界面使用 session 认证
- **OAuth**: 支持第三方 OAuth 登录

## 9. 核心功能流程

### 9.1 文档处理流程
```
文档上传 → 格式识别 → 深度解析 → 分块处理 → 向量化 → 索引存储
```

1. **上传**: 支持拖拽或API上传
2. **解析**: 根据文档类型选择解析器
3. **分块**: 按配置策略切分文档
4. **嵌入**: 生成向量表示
5. **存储**: 保存到向量数据库

### 9.2 问答流程
```
用户提问 → 查询理解 → 检索相关文档 → 重排序 → LLM生成 → 返回答案
```

1. **查询预处理**: 关键词提取、查询扩展
2. **向量检索**: 在知识库中搜索相关文档
3. **重排序**: 根据相关性重新排序
4. **上下文构建**: 组装提示词
5. **生成回答**: LLM 生成最终答案

### 9.3 智能体执行流程
```
触发事件 → 解析DSL → 执行节点 → 传递数据 → 输出结果
```

## 10. 性能优化建议

### 10.1 部署优化
- **GPU 加速**: 使用 `docker-compose-gpu.yml` 启动
- **缓存配置**: 合理配置 Redis 缓存
- **数据库调优**: 根据数据量调整 MySQL/ES 参数

### 10.2 开发优化
- **批处理**: 文档批量处理提高效率
- **异步处理**: 长耗时任务使用任务队列
- **缓存策略**: 向量缓存和结果缓存

## 11. 常见问题排查

### 11.1 启动问题
- 检查 Docker 版本和资源配置
- 确认端口占用情况
- 查看容器日志: `docker logs ragflow-server`

### 11.2 文档解析问题
- 检查文档格式支持
- 确认依赖模型下载完成
- 查看解析器日志

### 11.3 性能问题
- 监控内存和 CPU 使用
- 检查数据库连接数
- 分析慢查询日志

## 12. 社区与贡献

### 12.1 参与方式
- **GitHub**: https://github.com/infiniflow/ragflow
- **Discord**: 技术讨论和支持
- **文档**: https://ragflow.io/docs/

### 12.2 贡献指南
1. Fork 项目并创建分支
2. 按照代码规范编写代码
3. 添加必要的测试
4. 提交 Pull Request

### 12.3 开发规范
- 遵循 PEP 8 (Python) 和 ESLint (TypeScript)
- 编写清晰的提交信息
- 添加适当的注释和文档

---

这份指南涵盖了 RAGFlow 项目的主要组成部分和开发流程。建议新开发者先熟悉整体架构，然后根据具体需求深入相关模块。如有疑问，可参考官方文档或在社区寻求帮助。