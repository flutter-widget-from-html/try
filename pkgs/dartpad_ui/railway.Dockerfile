ARG GCP_PROJECT_ID
FROM gcr.io/$GCP_PROJECT_ID/flutter as builder

WORKDIR /pkgs/dartpad_shared
COPY pkgs/dartpad_shared .

WORKDIR /pkgs/dartpad_ui
COPY pkgs/dartpad_ui .

RUN flutter build web

FROM caddy:alpine

COPY --from=builder /pkgs/dartpad_ui/build/web /usr/share/caddy
COPY --from=builder /pkgs/dartpad_ui/railway.Caddyfile /etc/caddy/Caddyfile
