FROM nginx:alpine
WORKDIR /app
COPY ../src/frontend/build /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 