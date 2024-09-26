# Dockerfile for the datalab pURL resolver
#
# Uses the latest datalab-federation docker image to construct
# nginx config files that redirect from e.g., `https://purl.datalab-org.io/test:1234`
# to the relevant datalab instance URL, e.g., `https://datalab.test.org/items/1234`.

FROM ghcr.io/datalab-org/datalab-federation:latest AS federation

FROM python:3.12-alpine AS builder
RUN apk add --no-cache make
ARG COMBINED_FILENAME="/app/combined.yaml"
WORKDIR /app
RUN pip install uv

COPY Makefile .
COPY src /app/src
COPY --from=federation $COMBINED_FILENAME $COMBINED_FILENAME
RUN make build-nginx-config

FROM nginx:1.27-alpine AS nginx
RUN mkdir -p /etc/nginx/include && mkdir -p /var/www
COPY --from=builder /app/nginx/include/providers-nginx.conf /etc/nginx/include/
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/include/ssl-nginx.conf /etc/nginx/include/ssl-nginx.conf
COPY ./static/index.html /var/www/index.html
RUN rm -f /etc/nginx/conf.d/default.conf
EXPOSE 80
EXPOSE 443
