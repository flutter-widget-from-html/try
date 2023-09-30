FROM ghcr.io/cirruslabs/flutter:stable as builder

# See pkgs/dart_services/cloud_run.Dockerfile
WORKDIR /app
RUN groupadd --system dart && \
  useradd --no-log-init --system --home /home/dart --create-home -g dart dart

# See https://github.com/cirruslabs/docker-images-flutter/blob/master/sdk/Dockerfile
RUN chown -R dart:dart ${FLUTTER_HOME}
RUN chown dart:dart /app

USER dart
COPY --chown=dart:dart pubspec.* /app/
COPY --chown=dart:dart third_party/ /app/third_party/
RUN dart pub get
COPY --chown=dart:dart . /app
RUN dart pub get --offline

# Patch SERVER_URL to use relative path, it will be proxied via nginx
RUN sed -i'' 's#https://stable.api.fwfh.dev/#/#' build.yaml &&  cat build.yaml

# See .cloud_build/dart_pad.yaml
RUN dart run tool/grind.dart build

FROM nginx:alpine

COPY --from=builder /app/build /etc/nginx/html
COPY railway.nginx.conf /etc/nginx/conf.d/default.conf

RUN sed -i'' 's/worker_processes  auto;/worker_processes 2;/' /etc/nginx/nginx.conf && cat /etc/nginx/nginx.conf
