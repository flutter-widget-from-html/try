FROM ghcr.io/cirruslabs/flutter:stable as builder

WORKDIR /app
COPY pubspec.* /app/
RUN dart pub get
COPY . /app
RUN dart pub get --offline

# See .cloud_build/dart_pad.yaml
RUN dart run tool/grind.dart build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html
