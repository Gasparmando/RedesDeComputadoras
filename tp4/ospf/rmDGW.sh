#!/bin/bash

docker exec ospf_r1_1 ip -6 route delete default
docker exec ospf_r2_1 ip -6 route delete default
docker exec ospf_r3_1 ip -6 route delete default
docker exec ospf_r4_1 ip -6 route delete default
docker exec ospf_r5_1 ip -6 route delete default
docker exec ospf_r6_1 ip -6 route delete default
docker exec ospf_r7_1 ip -6 route delete default
docker exec ospf_r8_1 ip -6 route delete default

docker exec ospf_h11_1 ip -6 route delete default

docker exec ospf_h12_1 ip -6 route delete default

docker exec ospf_h13_1 ip -6 route delete default

docker exec ospf_h14_1 ip -6 route delete default

docker exec ospf_h11_1 ip -6 route add default via 2001:aabb:aaaa::15
docker exec ospf_h12_1 ip -6 route add default via 2001:aabb:bbbb::16
docker exec ospf_h13_1 ip -6 route add default via 2001:aabb:cccc::17
docker exec ospf_h14_1 ip -6 route add default via 2001:aabb:dddd::18
