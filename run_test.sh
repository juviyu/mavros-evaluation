#!/bin/bash

read -p "Make sitl is running (press enter) "

# Run the MAVROS node
ros2 run mavros mavros_node --ros-args --params-file mavros_config.yaml
