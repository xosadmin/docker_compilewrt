#!/bin/bash

if [ -f "/config/precompile.sh" ]; then
    echo "Running precompile script...." >&2
    chmod a+x /config/precompile.sh
    /config/precompile.sh
else
    echo "precompile.sh not found. Skipping..." >&2
fi

COMPILE_DIR="/compile"
OUTPUT_DIR="/output"
NPROC=${NPROC:-1}

cd $COMPILE_DIR
if [ ! -f ".config" ]; then
    echo "Error: No configuration file. Exiting...." >&2
    exit 1
fi

./scripts/feeds update -a
./scripts/feeds install -a

make -j$NPROC V=s

echo "=================================="

if [ -d "$OUTPUT_DIR" ]; then
    current_time=$(date +"%d/%m/%Y_%H:%M:%S")
    mkdir -p $OUTPUT_DIR/$current_time
    echo "Copying outcome to $OUTPUT_DIR..." >&2
    cp -r $COMPILE_DIR/bin/* $OUTPUT_DIR/$current_time || echo "Failed to copy files to $OUTPUT_DIR" >&2
else
    echo "Cannot find the $OUTPUT_DIR. Skip outcome copy..." >&2
fi

if [ -f "/config/postcompile.sh" ]; then
    echo "Running post-compile script...." >&2
    chmod a+x /config/postcompile.sh
    /config/postcompile.sh
else
    echo "postcompile.sh not found. Skipping...." >&2
fi
