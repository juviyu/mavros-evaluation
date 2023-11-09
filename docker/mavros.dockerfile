FROM ros:galactic as base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update && apt-get install -y \
    python3-vcstool \
    python3-rosinstall-generator \
    python3-osrf-pycommon \
    ; rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

################################

FROM base as mavros_depends

WORKDIR /user/ros2_ws
COPY src /user/ros2_ws/src

RUN rosdep install --from-paths src --ignore-src -y

RUN wget -O - https://raw.githubusercontent.com/mavlink/mavros/ros2/mavros/scripts/install_geographiclib_datasets.sh | bash

RUN colcon build

# launch ros package
CMD [ "ros2", "run", "mavros", "mavros_node", "--ros-args", "--params-file", "mavros/mavros/launch/apm_config.yaml" ]