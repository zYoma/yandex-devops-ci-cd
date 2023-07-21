FROM node:16 AS builder
COPY . .
RUN npm install \
    && npm install -g http-server \
    && npm run build \


FROM nginxproxy/nginx-proxy
COPY --from=builder /usr/src/appdist/frontend/ /usr/src/appdist/frontend/
