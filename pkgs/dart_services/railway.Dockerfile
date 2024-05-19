ARG GCP_PROJECT_ID

FROM gcr.io/$GCP_PROJECT_ID/api-stable:2024051902

# Patch `package_info_plus` registration, it was looking for some asset manager which is not available
# TODO: revisit this at some point, otherwise AUDIO tag won't work
RUN sed -i'' 's#PackageInfoPlusWebPlugin#// \0#' ./project_templates/flutter_project/lib/generated_plugin_registrant.dart && cat ./project_templates/flutter_project/lib/generated_plugin_registrant.dart

ENTRYPOINT ["/pkgs/dart_services/bin/server"]
CMD ["--storage-bucket=fwfh-nnbd_artifacts"]
