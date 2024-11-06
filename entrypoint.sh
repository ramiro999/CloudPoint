#!/bin/sh

. /catkin_ws_robust_pcl/devel/setup.sh 

cd /catkin_ws_robust_pcl/src/robust_point_cloud_registration/launch 

rosrun point_cloud_registration $1 $2