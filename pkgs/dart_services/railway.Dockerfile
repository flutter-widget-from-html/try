ARG GCP_PROJECT_ID

FROM gcr.io/$GCP_PROJECT_ID/api-stable:2024051902
ENTRYPOINT ["/pkgs/dart_services/bin/server"]
CMD ["--storage-bucket=fwfh-nnbd_artifacts"]
