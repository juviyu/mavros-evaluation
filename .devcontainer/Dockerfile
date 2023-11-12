FROM althack/ros2:humble-full AS base

# ** [Optional] Uncomment this section to install additional packages. **
#

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get clean && apt-get update && apt-get install -y \
    python3-osrf-pycommon \
    python3-pip \
    # libgeographic-* \
    # ros-galactic-geographic-msgs \
    # ros-galactic-eigen-stl-containers \
    # ros-galactic-diagnostic-updater \
    # libasio-dev \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=


################################
#    now, add mavros stuff     #
################################
FROM base AS mavros_depends

RUN wget -O - https://raw.githubusercontent.com/mavlink/mavros/ros2/mavros/scripts/install_geographiclib_datasets.sh | bash


################################
#    setup for dev env         #
################################
FROM mavros_depends AS final
# Set up auto-source of workspace for ros user
ARG WORKSPACE
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc
