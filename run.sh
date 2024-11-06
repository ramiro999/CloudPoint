#!/bin/bash
podman run -it --rm -v $XAUTHORITY:$XAUTHORITY:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v /home/hover/CloudPoint/launch:/catkin_ws_robust_pcl/src/robust_point_cloud_registration/launch:rw -v /home/hover/CloudPoint/cloudpoints:/catkin_ws_robust_pcl/src/robust_point_cloud_registration/cloudpoints:rw -e "DISPLAY" --security-opt label=type:container_runtime_t cloud $1 $2