#!/usr/bin/env bash

set -e

cd "$(cd "$(dirname "$0")" && git rev-parse --show-toplevel)"

dockerfile="$1"
if [ -z "$dockerfile" ]; then
    dockerfile="./docker/polkadot-parachain_builder.Containerfile"
else
    shift 1
fi
image_name="$(basename "$dockerfile" | rev | cut -d. -f2- | rev)"

echo "building $dockerfile as $image_name..."

time docker build \
    -f "$dockerfile" \
    -t cumulus:v0.9.24 \
    "$@" \
    .
