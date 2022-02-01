#!/bin/bash

# create sn OVS bridge call kong
sudo ovs-vsctl add-br kong


# create network namespace
sudo ip netns add yoshi &> /dev/null

# create bridge internal interface
sudo ovs-vsctl add-port toad toad2yoshi

# create VETH link 
sudo ip link add yoshi2toad type veth peer name toad2yoshi

# plug the VETH into yoshi namespace
sudo ip link set yoshi2toad netns yoshi &> /dev/null
sudo ip link set toad2yoshi netns toad &> /dev/null

# plug the VETH to bridge
sudo ip link set dev toad2yoshi master br0 &> /dev/null

# bring interface up in yoshi
sudo ip netns exec yoshi ip link set dev yoshi up


# add IP address to interface
sudo ip netns exec yoshi ip a add 10.64.0.11/24 dev yoshi2toad

# bring up interface on yoshi and bridge
sudo ip netns exec yoshi ip link set dev yoshi2toad up
sudo ip netns exec yoshi ip link set dev lo up
sudo ip netns exec toad ip link set dev toad2yoshi up
sudo ip netns exec toad ip link set dev lo up


