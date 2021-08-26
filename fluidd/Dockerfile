FROM node:14.7 as node
COPY fluidd /usr/src/app
COPY files/vue.config.js /usr/src/app/
COPY files/package.json /usr/src/app/
WORKDIR /usr/src/app
RUN npm install
RUN npm run build

FROM nginx:alpine as image
COPY --from=node --chown=101:101 /usr/src/app/dist /usr/share/nginx/html
COPY --chown=101:101 files/nginx-site.conf /etc/nginx/conf.d/default.conf
COPY --chown=101:101 files/config.json /usr/share/nginx/html/config.json

ENV JPEG_STREAM_HOST localhost
ENV JPEG_STREAM_PORT 8080

EXPOSE 80