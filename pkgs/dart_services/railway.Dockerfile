ARG GCP_PROJECT_ID

FROM gcr.io/$GCP_PROJECT_ID/api-stable:867c7552
ENTRYPOINT ["/pkgs/dart_services/bin/server"]
CMD ["--storage-bucket=fwfh-nnbd_artifacts"]
