FROM ros:galactic as base
SHELL [ "/bin/bash", "-c"]

RUN useradd -m non-root-user

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get clean && apt-get update && apt-get install -y \
    python3-osrf-pycommon \
    python3-pip \
    rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

USER non-root-user
RUN rosdep update

USER root


################################
#    now, add mavros stuff     #
################################
FROM base as mavros_depends

WORKDIR /user/ros2_ws
RUN mkdir src

RUN rosdep install --from-paths src --ignore-src -y
RUN bash src/mavros/mavros/scripts/install_geographiclib_datasets.sh
RUN source /opt/ros/galactic/setup.bash


################################
#       run shit               #
################################
FROM mavros_depends as running
# launch ros package
CMD [ "ros2", "run", "mavros", "mavros_node", "--ros-args", "--params-file", "mavros/mavros/launch/apm_config.yaml" ]