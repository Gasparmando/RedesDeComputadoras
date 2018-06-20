#!/bin/bash

BRIDGE2 = ""

ip addr flush dev enp0s3
ip link set enp0s3 down
ip addr flush dev $BRIDGE2
ip addr add 2001::9/64 dev $BRIDGE2
brctl addif $BRIDGE2 enp0s3
ip link set enp0s3 up
