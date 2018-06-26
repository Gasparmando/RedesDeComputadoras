#!/bin/bash


docker exec ruteo_r4_1 ip -6 route delete default
docker exec ruteo_r6_1 ip -6 route delete default
docker exec ruteo_r8_1 ip -6 route delete default

docker exec ruteo_b2_1 ip -6 route delete default
docker exec ruteo_b2_1 ip -6 route add default via 2001::a

docker exec ruteo_h12_1 ip -6 route delete default
docker exec ruteo_h14_1 ip -6 route delete default

docker exec ruteo_h12_1 ip -6 route add default via 2001:bbbb:4444::16
docker exec ruteo_h14_1 ip -6 route add default via 2001:bbbb:5555::18

docker exec ruteo_r4_1 ip -6 route add default via 2001:bbbb:1111::12
docker exec ruteo_r6_1 ip -6 route add default via 2001:bbbb:2222::12
docker exec ruteo_r8_1 ip -6 route add default via 2001:bbbb:3333::12

