#!/bin/bash

docker exec bgp_r1_1 ip -6 route delete default
docker exec bgp_r2_1 ip -6 route delete default
docker exec bgp_r3_1 ip -6 route delete default
docker exec bgp_r4_1 ip -6 route delete default
docker exec bgp_r5_1 ip -6 route delete default
docker exec bgp_r6_1 ip -6 route delete default
docker exec bgp_r7_1 ip -6 route delete default
docker exec bgp_r8_1 ip -6 route delete default
docker exec bgp_r9_1 ip -6 route delete default
docker exec bgp_r10_1 ip -6 route delete default

docker exec bgp_b1_1 ip -6 route delete default
docker exec bgp_b2_1 ip -6 route delete default
docker exec bgp_b3_1 ip -6 route delete default

docker exec bgp_h11_1 ip -6 route delete default
docker exec bgp_h12_1 ip -6 route delete default
docker exec bgp_h13_1 ip -6 route delete default
docker exec bgp_h14_1 ip -6 route delete default


docker exec bgp_h11_1 ip -6 route add default via 2001:aaaa:4444::15
docker exec bgp_h12_1 ip -6 route add default via 2001:bbbb:4444::16
docker exec bgp_h13_1 ip -6 route add default via 2001:aaaa:5555::17
docker exec bgp_h14_1 ip -6 route add default via 2001:bbbb:5555::18



docker exec bgp_r1_1 ip -6 route add default via 2001:aaaa:aaaa::b
docker exec bgp_r2_1 ip -6 route add default via 2001:bbbb:bbbb::b
docker exec bgp_r3_1 ip -6 route add default via 2001:aaaa:1111::11
docker exec bgp_r4_1 ip -6 route add default via 2001:bbbb:1111::12
docker exec bgp_r5_1 ip -6 route add default via 2001:aaaa:2222::11
docker exec bgp_r6_1 ip -6 route add default via 2001:bbbb:2222::12
docker exec bgp_r7_1 ip -6 route add default via 2001:aaaa:3333::11
docker exec bgp_r8_1 ip -6 route add default via 2001:bbbb:3333::12
docker exec bgp_r9_1 ip -6 route add default via 2001:cccc:cccc::b
docker exec bgp_r10_1 ip -6 route add default via 2001:cccc:1111::19