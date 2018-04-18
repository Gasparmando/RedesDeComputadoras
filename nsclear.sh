#!/bin/bash

ip netns del ns1.1
ip netns del ns1.2
ip netns del ns1.3
ip netns del ns1.4
ip netns del ns1.5
ip netns del ns1.6

ip netns del ns2.1
ip netns del ns2.2
ip netns del ns2.3
ip netns del ns2.4
ip netns del ns2.5
ip netns del ns2.6

ip link del tap1B
ip link del tap12
ip link del tap13
ip link del tap14
ip link del tap21
ip link del tap31
ip link del tap34
ip link del tap35
ip link del tap41
ip link del tap43
ip link del tap46
ip link del tap53
ip link del tap64
ip link del br-externo
ip link del br-tapExt
ip link del br-tap1B
ip link del tapExt
