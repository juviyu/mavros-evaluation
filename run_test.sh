docker run -d --network=host -v `pwd`/mavros:/user/mavros_test/mavros mavros_test_sitl
docker run -d --network=host -v `pwd`/mavros:/user/mavros_test/mavros mavros_test_mavros_node