#!/bin/bash

# Define the repository name (hardcoded)
REPO="ctng-image"

# Define the tag name (set Crosstool-NG version)
TAG="1.27.0"

# Define the full name (e.g. "ctng-image:1.27.0")
FULL_IMAGE_NAME="${REPO}:${TAG}"

# Build the Docker image
docker build --build-arg VERSION=$TAG -t $FULL_IMAGE_NAME .

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Image $FULL_IMAGE_NAME built successfully!"
else
    echo "Failed to build $FULL_IMAGE_NAME."
    exit 1
fi

# Execute the build of the selected toolchain
docker run --rm -it --user "$(id -u):$(id -g)" -v ${PWD}:/workspace $FULL_IMAGE_NAME /bin/bash -c "cd /workspace && GCC=12 ./build.sh"
