#!/bin/bash

echo "Hola Mundo"
./nsclear.sh

NS1="ns1.1"
NS2="ns1.2"
NS3="ns1.3"
NS4="ns1.4"
NS5="ns1.5"
NS6="ns1.6"




# Crea un nuevo namespace
ip netns add $NS1
ip netns add $NS2
ip netns add $NS3
ip netns add $NS4
ip netns add $NS5
ip netns add $NS6	

					
# Levanta la interfaz de loopback (UP). "exec" para ejecutar dentro del namespace
ip netns exec $NS1 ip link set up dev lo 
ip netns exec $NS2 ip link set up dev lo 
ip netns exec $NS3 ip link set up dev lo 
ip netns exec $NS4 ip link set up dev lo 
ip netns exec $NS5 ip link set up dev lo 
ip netns exec $NS6 ip link set up dev lo 			

# Crea el cable virtual
ip link add tap1B type veth peer name br-tap1B 			
#ip link add tapExt type veth peer name br-tapExt

ip link add tap21 type veth peer name tap12
ip link add tap31 type veth peer name tap13
ip link add tap41 type veth peer name tap14
ip link add tap34 type veth peer name tap43
ip link add tap53 type veth peer name tap35
ip link add tap64 type veth peer name tap46

# Conecta cable al namespace
ip link set tap1B netns $NS1					
ip link set tap12 netns $NS1
ip link set tap13 netns $NS1
ip link set tap14 netns $NS1

ip link set tap21 netns $NS2

ip link set tap31 netns $NS3
ip link set tap34 netns $NS3
ip link set tap35 netns $NS3

ip link set tap41 netns $NS4
ip link set tap43 netns $NS4
ip link set tap46 netns $NS4

ip link set tap53 netns $NS5

ip link set tap64 netns $NS6


# Crea el Bridge
brctl addbr br-externo						


# Conecta el cable al Bridge
brctl addif br-externo br-tap1B					
#brctl addif br-externo br-tapExt
brctl addif br-externo enp0s3

# Configura ip Forwarding en el router, dentro del NS (1 a 4 son routers) ( 5 y 6 son hosts)
ip netns exec $NS1 sysctl -w net.ipv6.conf.all.forwarding=1
ip netns exec $NS2 sysctl -w net.ipv6.conf.all.forwarding=1	
ip netns exec $NS3 sysctl -w net.ipv6.conf.all.forwarding=1	
ip netns exec $NS4 sysctl -w net.ipv6.conf.all.forwarding=1	
	
# Levanta las interfaces de los cables
ip netns exec $NS1 ip link set up dev tap1B	
ip netns exec $NS1 ip link set dev tap1B mtu 1300 		
ip netns exec $NS1 ip link set up dev tap12
ip netns exec $NS1 ip link set up dev tap13
ip netns exec $NS1 ip link set up dev tap14

ip netns exec $NS2 ip link set up dev tap21

ip netns exec $NS3 ip link set up dev tap31
ip netns exec $NS3 ip link set up dev tap34
ip netns exec $NS3 ip link set up dev tap35

ip netns exec $NS4 ip link set up dev tap41
ip netns exec $NS4 ip link set up dev tap43
ip netns exec $NS4 ip link set up dev tap46

ip netns exec $NS5 ip link set up dev tap53

ip netns exec $NS6 ip link set up dev tap64

ip link set up dev br-tap1B
#ip link set up dev br-tapExt
#ip link set up dev tapExt



ip link set up dev br-externo





# FORMATO : 2001:{maquina}:{enlace}:1::{interfaz tap}    maquina: (aaaa, bbbb)  enlace: ( 1,2,3,4,5  - A,B,C)
#Asignacion de direcciones IPv6

tap1B="2001:aaaa:aaaa:1::1B"
br="2001:aaaa:aaaa:1::B1"



tap12="2001:aaaa:1111:1::12"
tap21="2001:aaaa:1111:1::21"

tap13="2001:aaaa:2222:1::13"
tap31="2001:aaaa:2222:1::31"

tap14="2001:aaaa:3333:1::14"
tap41="2001:aaaa:3333:1::41"

tap34="2001:aaaa:6666:1::34"
tap43="2001:aaaa:6666:1::43"

tap35="2001:aaaa:4444:1::35"
tap53="2001:aaaa:4444:1::53"

tap64="2001:aaaa:5555:1::64"
tap46="2001:aaaa:5555:1::46"

ip -6 addr add ${br}/64 dev br-externo

ip netns exec $NS1 ip -6 addr add ${tap1B}/64 dev tap1B 
ip netns exec $NS1 ip -6 addr add ${tap12}/64 dev tap12
ip netns exec $NS1 ip -6 addr add ${tap13}/64 dev tap13 
ip netns exec $NS1 ip -6 addr add ${tap14}/64 dev tap14


ip netns exec $NS2 ip -6 addr add ${tap21}/64 dev tap21
ip netns exec $NS3 ip -6 addr add ${tap31}/64 dev tap31
ip netns exec $NS3 ip -6 addr add ${tap34}/64 dev tap34 
ip netns exec $NS3 ip -6 addr add ${tap35}/64 dev tap35

ip netns exec $NS4 ip -6 addr add ${tap41}/64 dev tap41
ip netns exec $NS4 ip -6 addr add ${tap43}/64 dev tap43 
ip netns exec $NS4 ip -6 addr add ${tap46}/64 dev tap46 

ip netns exec $NS5 ip -6 addr add ${tap53}/64 dev tap53

ip netns exec $NS6 ip -6 addr add ${tap64}/64 dev tap64



##Ruteo estático

#para ver las tablas de ruteo:
# ip netns exec ns1.1 ip -6 route



ip netns exec $NS1 ip -6 route add default via $br
#ip netns exec $NS1 ip -6 route add 2001:aaaa:4444:1::/64 dev tap13
#ip netns exec $NS1 ip -6 route add 2001:aaaa:5555:1::/64 dev tap14
#ip netns exec $NS1 ip -6 route add 2001:aaaa:6666:1::/64 dev tap13
ip netns exec $NS1 ip -6 route add 2001:aaaa:4444:1::/64 dev tap13 via 2001:aaaa:2222:1::31
ip netns exec $NS1 ip -6 route add 2001:aaaa:5555:1::/64 dev tap14 via 2001:aaaa:3333:1::41
ip netns exec $NS1 ip -6 route add 2001:aaaa:6666:1::/64 dev tap13 via 2001:aaaa:2222:1::31

ip netns exec $NS2 ip -6 route add default via $tap12

ip netns exec $NS3 ip -6 route add default via $tap13
ip netns exec $NS3 ip -6 route add 2001:aaaa:5555:1::/64 dev tap34 via 2001:aaaa:6666:1::43

ip netns exec $NS4 ip -6 route add default via $tap14
ip netns exec $NS4 ip -6 route add 2001:aaaa:4444:1::/64 dev tap43 via 2001:aaaa:6666:1::34

ip netns exec $NS5 ip -6 route add default via $tap35
ip netns exec $NS6 ip -6 route add default via $tap46







