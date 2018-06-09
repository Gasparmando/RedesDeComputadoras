#!/bin/bash


docker exec pc1_r3_1 ip -6 route delete default
docker exec pc1_r5_1 ip -6 route delete default
docker exec pc1_r7_1 ip -6 route delete default

docker exec pc1_b1_1 ip -6 route delete default

docker exec pc1_h11_1 ip -6 route delete default
docker exec pc1_h13_1 ip -6 route delete default

docker exec pc1_h11_1 ip -6 route add default via 2001:aaaa:4444::15
docker exec pc1_h13_1 ip -6 route add default via 2001:aaaa:5555::17

docker exec pc1_r3_1 ip -6 route add default via 2001:aaaa:1111::11
docker exec pc1_r5_1 ip -6 route add default via 2001:aaaa:2222::11
docker exec pc1_r7_1 ip -6 route add default via 2001:aaaa:3333::11