#!/bin/bash


docker exec ruteo_r3_1 ip -6 route delete default
docker exec ruteo_r5_1 ip -6 route delete default
docker exec ruteo_r7_1 ip -6 route delete default

docker exec ruteo_b1_1 ip -6 route delete default
docker exec ruteo_b1_1 ip -6 route add default via 2001::b

docker exec ruteo_h11_1 ip -6 route delete default
docker exec ruteo_h13_1 ip -6 route delete default

docker exec ruteo_h11_1 ip -6 route add default via 2001:aaaa:4444::15
docker exec ruteo_h13_1 ip -6 route add default via 2001:aaaa:5555::17

docker exec ruteo_r3_1 ip -6 route add default via 2001:aaaa:1111::11
docker exec ruteo_r5_1 ip -6 route add default via 2001:aaaa:2222::11
docker exec ruteo_r7_1 ip -6 route add default via 2001:aaaa:3333::11