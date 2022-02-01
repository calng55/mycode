#!/bin/bash

# create anOVS bridge called gorilla
sudo ovs-vsctl add-br gorilla

# create network namespace
sudo ip netns add mario &> /dev/null

# create bridge internal interface
sudo ovs-vsctl add-port gorilla mario -- set interface mario type=internal

# plug the OvS bridge internals into the mario namespace
sudo ip link set mario netns mario

# bring interface up in bowser and peach
sudo ip netns exec mario ip link set dev mario up
sudo ip netns exec mario ip link set dev lo up

# add IP address to interface 
sudo ip netns exec mario ip addr add 10.64.2.2/24 dev mario


