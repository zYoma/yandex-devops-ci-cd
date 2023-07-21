FROM node:16 AS builder
COPY . .


FROM nginxproxy/nginx-proxy
COPY --from=builder /usr/src/appdist/frontend/ /usr/src/appdist/frontend/
