FROM ros:galactic

ENV DEBIAN_FRONTEND=noninteractive

# install ros package
RUN apt-get clean && apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-mavros

RUN rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

RUN wget -O - https://raw.githubusercontent.com/mavlink/mavros/ros2/mavros/scripts/install_geographiclib_datasets.sh | bash

WORKDIR /user/mavros_test
# launch ros package
CMD [ "ros2", "run", "mavros", "mavros_node", "--ros-args", "--params-file", "mavros/mavros/launch/apm_config.yaml" ]
