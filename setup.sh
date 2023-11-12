#!/bin/bash
set -e

# vcs import src < src/ros2.repos
pip install future

sudo apt-get update
rosdep update
rosdep install --from-paths src --ignore-src -y
