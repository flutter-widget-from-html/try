# Source:
# https://github.com/GoogleCloudPlatform/cloud-builders-community/blob/master/flutter/Dockerfile
#
# Flutter (https://flutter.io) Developement Environment for Linux
# ===============================================================
#
# This environment passes all Linux Flutter Doctor checks and is sufficient
# for building Android applications and running Flutter tests.
#
# To build iOS applications, a Mac development environment is necessary.
#

FROM debian:bookworm
MAINTAINER Chinmay Garde <chinmaygarde@google.com>

# Install Dependencies.
RUN apt update -y
RUN apt install -y \
  git \
  wget \
  curl \
  unzip

# Install Flutter.
ENV FLUTTER_ROOT="/opt/flutter"
RUN git clone https://github.com/flutter/flutter "${FLUTTER_ROOT}"
ENV PATH="${FLUTTER_ROOT}/bin:${PATH}"

# Disable analytics and crash reporting on the builder.
RUN flutter config  --no-analytics

# Accept licenses.
RUN yes "y" | flutter doctor --android-licenses

# Perform a doctor run.
RUN flutter doctor -v

# Switch to the correct channel
ARG channel=stable
RUN flutter channel $channel

# Perform a flutter upgrade
RUN flutter upgrade

# Perform an artifact precache so that no extra assets need to be downloaded on demand.
RUN flutter precache --web

ENTRYPOINT [ "flutter" ]
