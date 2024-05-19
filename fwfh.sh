#!/bin/sh

export GCP_PROJECT=fwfh-dev

# Optional: build for new Flutter stable release
gcloud builds submit . \
  --config=.cloud_build/flutter/cloudbuild.yaml \
  --project=$GCP_PROJECT

# Optional: build for new Firebase CLI
gcloud builds submit . \
  --config=.cloud_build/firebase/cloudbuild.yaml \
  --project=$GCP_PROJECT

# Optional: update sample or FWFH packages
( cd pkgs/dart_services && dart run grinder update-pub-dependencies )
( cd pkgs/samples && dart tool/samples.dart )
