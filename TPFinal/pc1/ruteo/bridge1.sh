#!/bin/bash

BRIDGE1="br-dfe3b0f42634"

ip addr flush dev enp0s3
ip link set enp0s3 down
brctl addif $BRIDGE1 enp0s3
ip link set enp0s3 up