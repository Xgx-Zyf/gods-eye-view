FROM node:24-alpine

WORKDIR /app

# 先复制依赖描述文件以利用 Docker 缓存
COPY package.json package-lock.json* ./

# 安装依赖，跳过 puppeteer 的 Chromium 下载
ENV PUPPETEER_SKIP_DOWNLOAD=true
RUN npm ci

# 复制项目源码
COPY . .

# 构建生产版本
RUN npm run build

# 暴露端口
EXPOSE 4173

# 环境变量
ENV HOST=0.0.0.0
ENV PORT=4173
ENV NODE_ENV=production

# 启动生产服务器
CMD ["npm", "start"]
