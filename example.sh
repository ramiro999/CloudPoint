#!/bin/bash
podman run -it --rm -v $XAUTHORITY:$XAUTHORITY:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro -e "DISPLAY" --security-opt label=type:container_runtime_t cloud