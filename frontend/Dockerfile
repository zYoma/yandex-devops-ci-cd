FROM node:16 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build && ls -la /usr/src/app

FROM nginx:1.21.6-alpine
WORKDIR /app
COPY --from=builder /usr/src/app/dist/* /usr/share/nginx/html/
EXPOSE 8080