#1/bin/bash
# TEARDOWN

# delete bridges
sudo ovs-vsctl del-br donut-plains &> /dev/null
sudo ovs-vsctl del-br castle-koopa &> /dev/null

# delete network namespaces
sduo ip netns del peach &> /dev/null
sudo ip netns del bowser &> /dev/null


