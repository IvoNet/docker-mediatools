#!/usr/bin/env bash

if [ "$(uname -m)" == "aarch64" ]; then
    wget -O https://www.deb-multimedia.org/pool/main/m/mp4v2-dmo/libmp4v2-2_2.0.0-dmo6_arm64.deb
    wget -O https://www.deb-multimedia.org/pool/main/m/mp4v2-dmo/mp4v2-utils_2.0.0-dmo6_arm64.deb
else
    wget -O http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb
    wget -O http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb
fi
