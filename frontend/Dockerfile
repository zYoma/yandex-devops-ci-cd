FROM node:16 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build && ls -la /usr/src/app

FROM jwilder/docker-gen
WORKDIR /app
COPY --from=builder /usr/src/app/dist/* /usr/share/nginx/html/
RUN apt update && apt install curl
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/docker-gen", "-notify-sighup", "nginx", "-watch", "-only-exposed", "-wait", "5s:30s", "/etc/docker-gen/templates/nginx.tmpl", "/etc/nginx/conf.d/default.conf"]