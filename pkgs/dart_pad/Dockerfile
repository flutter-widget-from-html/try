FROM ghcr.io/cirruslabs/flutter:stable as builder

# See pkgs/dart_services/cloud_run.Dockerfile
WORKDIR /app
RUN groupadd --system dart && \
  useradd --no-log-init --system --home /home/dart --create-home -g dart dart
RUN chown dart:dart /app
USER dart
COPY --chown=dart:dart pubspec.* /app/
RUN dart pub get
COPY --chown=dart:dart . /app
RUN dart pub get --offline

# See .cloud_build/dart_pad.yaml
RUN dart run tool/grind.dart build

FROM nginx:alpine

# See https://hub.docker.com/_/nginx
COPY --from=builder /app/build /usr/share/nginx/html
