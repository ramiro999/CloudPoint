FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt -y install curl 
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt -y update && apt-get install dpkg
RUN apt -y install ros-indigo-desktop-full python-catkin-tools python-wstool cmake3 dh-autoreconf
RUN chmod +rx /opt/ros/indigo/setup.bash
SHELL ["/bin/bash", "-c"]
RUN bash -c /opt/ros/indigo/setup.bash && rosdep init
RUN bash -c /opt/ros/indigo/setup.bash && rosdep update
RUN mkdir -p /catkin_ws_robust_pcl/src
WORKDIR /catkin_ws_robust_pcl
RUN bash -c /opt/ros/indigo/setup.bash && catkin init
RUN bash -c /opt/ros/indigo/setup.bash && catkin config --merge-devel # Necessary for catkin_tools >= 0.4.
RUN bash -c /opt/ros/indigo/setup.bash && catkin config --extend /opt/ros/indigo
RUN bash -c /opt/ros/indigo/setup.bash && catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
WORKDIR /catkin_ws_robust_pcl/src
RUN bash -c /opt/ros/indigo/setup.bash && wstool init
RUN git clone https://github.com/ramiro999/robust_point_cloud_registration.git
RUN rm -rf robust_point_cloud_registration/.git
#RUN git clone https://github.com/ethz-asl/pcl_catkin && cd pcl_catkin && git branch feature/cmake-v2 && git submodule update --init --recursive 
RUN git clone https://github.com/ethz-asl/pcl_catkin && cd pcl_catkin && git checkout 196272e8d5c807c81d0b002d1edfa107ece1586c
RUN rm -rf pcl_catkin/.git
RUN bash -c /opt/ros/indigo/setup.bash &&  wstool merge robust_point_cloud_registration/install/dependencies.rosinstall
RUN bash -c /opt/ros/indigo/setup.bash &&  wstool update -j8
RUN bash -c /opt/ros/indigo/setup.bash &&  catkin build point_cloud_registration
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]