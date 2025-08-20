# iOS Build için Docker (Deneysel - Apple lisans gerektirir)
FROM ubuntu:22.04

# Gerekli paketleri yükle
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    python3 \
    python3-pip

# Swift toolchain (Linux için)
RUN curl -s https://download.swift.org/swift-5.9-release/ubuntu2204/swift-5.9-RELEASE/swift-5.9-RELEASE-ubuntu22.04.tar.gz | tar xzf - -C /opt

ENV PATH="/opt/swift-5.9-RELEASE-ubuntu22.04/usr/bin:${PATH}"

WORKDIR /app
COPY . .

# Not: Bu sadece syntax check için, gerçek iOS build Apple donanımı gerektirir
RUN swift -version
