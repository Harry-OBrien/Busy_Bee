#!/bin/bash

# Check if an image path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <image_path>"
    exit 1
fi

# Get the input image path and extract the directory and filename
IMAGE_PATH="$1"
DIR_NAME=$(dirname "$IMAGE_PATH")
BASE_NAME=$(basename "$IMAGE_PATH")
NAME="${BASE_NAME%.*}"  # Get the filename without the extension

# Define the sizes and output filenames
sizes=("16" "32" "64")  # in pixels
scales=("1x" "2x" "3x") # scale identifiers

# Create resized images
for i in "${!sizes[@]}"; do
    SIZE="${sizes[$i]}"
    SCALE="${scales[$i]}"
    OUTPUT_PATH="$DIR_NAME/${NAME}_${SCALE}.png"
    echo "Creating $OUTPUT_PATH with size ${SIZE}x${SIZE}"
    sips -z "$SIZE" "$SIZE" "$IMAGE_PATH" --out "$OUTPUT_PATH"
done

echo "Resizing complete."

