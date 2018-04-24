# VARIABLES

#Namespaces
NS1=ns1.1
NS2=ns1.2
NS3=ns1.3
NS4=ns1.4
NS5=ns1.5
NS6=ns1.6

#Virtual Ethernets
NS1VETH=veth1-1
NS2VETH=veth1-2
NS3VETH=veth1-3
NS4VETH=veth1-4
NS5VETH=veth1-5
NS6VETH=veth1-6
NS34VETH=veth1-3-4 #NS3-NS4

#Peers
NS1PEER=vpeer1-1
NS2PEER=vpeer1-2
NS3PEER=vpeer1-3
NS4PEER=vpeer1-4
NS5PEER=vpeer1-5
NS6PEER=vpeer1-6
NS34PEER=vpeer1-3-4 #NS3-NS4

#IP de los VETHS
#NS1VETHIP=2001:aaaa:aaaa:1111::1 #Esta conectado al bridge, no hace falta
NS2VETHIP=2001:aaaa:aaaa:2222::1
NS3VETHIP=2001:aaaa:aaaa:3333::1
NS4VETHIP=2001:aaaa:aaaa:4444::1
NS5VETHIP=2001:aaaa:aaaa:5555::1
NS6VETHIP=2001:aaaa:aaaa:6666::1
NS34VETHIP=2001:aaaa:aaaa:7777::1

#IP de los PEERS
NS1PEERIP=2001:1111:1111:1111::1
NS2PEERIP=2001:aaaa:aaaa:2222::10
NS3PEERIP=2001:aaaa:aaaa:3333::10
NS4PEERIP=2001:aaaa:aaaa:4444::10
NS5PEERIP=2001:aaaa:aaaa:5555::10
NS6PEERIP=2001:aaaa:aaaa:6666::10
NS34PEERIP=2001:aaaa:aaaa:7777::10

#Redes 5 y 6
NS5NET=2001:aaaa:aaaa:5555::0
NS6NET=2001:aaaa:aaaa:6666::0

#DEV fisico
IFFISICA="enp9s0"
IPSALIDA=2001:1111:1111:1111::2

#Nombre del bridge
BRNAME="br-externo"

######################
#INICIO DEL SCRIPT
######################


#Eliminar NS si ya existen
echo "Borrando namespaces existentes"
ip netns del &$NS1&>/dev/null
ip netns del &$NS2&>/dev/null
ip netns del &$NS3&>/dev/null
ip netns del &$NS4&>/dev/null
ip netns del &$NS5&>/dev/null
ip netns del &$NS6&>/dev/null

# creamos los namespaces
echo "Creando namespaces"
ip netns add $NS1
ip netns add $NS2
ip netns add $NS3
ip netns add $NS4
ip netns add $NS5
ip netns add $NS6

#----
#Crear interfaces de los NS
echo "Creando interfaces de los namespaces"

ip link add $NS1VETH type veth peer name $NS1PEER
ip link add $NS2VETH type veth peer name $NS2PEER
ip link add $NS3VETH type veth peer name $NS3PEER
ip link add $NS4VETH type veth peer name $NS4PEER
ip link add $NS5VETH type veth peer name $NS5PEER
ip link add $NS6VETH type veth peer name $NS6PEER
#Conexion entre NS3 y NS4
ip link add $NS34VETH type veth peer name $NS34PEER

#----
#Asignar las interfaces a los NS
echo "Asignando interfaces a los NS"

#Interfaces de NS1
ip link set $NS1PEER netns $NS1
ip link set $NS2VETH netns $NS1
ip link set $NS3VETH netns $NS1
ip link set $NS4VETH netns $NS1

#Interfaces de NS2
ip link set $NS2PEER netns $NS2

#Interfaces de NS3
ip link set $NS3PEER netns $NS3
ip link set $NS5VETH netns $NS3
ip link set $NS34VETH netns $NS3

#Interfaces de NS4
ip link set $NS4PEER netns $NS4
ip link set $NS6VETH netns $NS4
ip link set $NS34PEER netns $NS4

#Interfaces de NS5
ip link set $NS5PEER netns $NS5

#Interfaces de NS6
ip link set $NS6PEER netns $NS6


#Configuracion del bridge
echo "Configurando el bridge"
ip link add $BRNAME type bridge
ip link set $BRNAME up

#Interfaces al BR
ip link set $IFFISICA up
ip link set $NS1VETH up
ip link set $IFFISICA master $BRNAME
ip link set $NS1VETH master $BRNAME

#MTU
ip netns exec $NS1 ip link set $NS1PEER mtu 1280


#Direccionamiento IP de las interfaces
echo "Asignando direcciones IP"

#NS1
ip netns exec $NS1 ip a add $NS1PEERIP/64 dev $NS1PEER
ip netns exec $NS1 ip a add $NS2VETHIP/64 dev $NS2VETH
ip netns exec $NS1 ip a add $NS3VETHIP/64 dev $NS3VETH
ip netns exec $NS1 ip a add $NS4VETHIP/64 dev $NS4VETH

#NS2
ip netns exec $NS2 ip a add $NS2PEERIP/64 dev $NS2PEER

#NS3
ip netns exec $NS3 ip a add $NS3PEERIP/64 dev $NS3PEER
ip netns exec $NS3 ip a add $NS5VETHIP/64 dev $NS5VETH
ip netns exec $NS3 ip a add $NS34VETHIP/64 dev $NS34VETH

#NS4
ip netns exec $NS4 ip a add $NS4PEERIP/64 dev $NS4PEER
ip netns exec $NS4 ip a add $NS6VETHIP/64 dev $NS6VETH
ip netns exec $NS4 ip a add $NS34PEERIP/64 dev $NS34PEER

#NS5
ip netns exec $NS5 ip a add $NS5PEERIP/65 dev $NS5PEER

#NS6
ip netns exec $NS6 ip a add $NS6PEERIP/66 dev $NS6PEER


#Levantando Interfaces
echo "Levantando Interfaces"
#NS1
ip netns exec $NS1 ip link set $NS1PEER up
ip netns exec $NS1 ip link set $NS2VETH up
ip netns exec $NS1 ip link set $NS3VETH up
ip netns exec $NS1 ip link set $NS4VETH up

#NS2
ip netns exec $NS2 ip link set $NS2PEER up
ip netns exec $NS2 ip link set lo up

#NS3
ip netns exec $NS3 ip link set $NS3PEER up
ip netns exec $NS3 ip link set $NS5VETH up
ip netns exec $NS3 ip link set $NS34VETH up

#NS4
ip netns exec $NS4 ip link set $NS4PEER up
ip netns exec $NS4 ip link set $NS6VETH up
ip netns exec $NS4 ip link set $NS34PEER up

#NS5
ip netns exec $NS5 ip link set $NS5PEER up

#NS6
ip netns exec $NS6 ip link set $NS6PEER up


#Ruteo
echo "Configurando routeo"
#Para el router en NS3
ip netns exec $NS1 ip -6 route add default via $IPSALIDA
ip netns exec $NS1 ip -6 route add $NS5NET/64 via $NS3PEERIP
ip netns exec $NS1 ip -6 route add $NS6NET/64 via $NS4PEERIP
#Para el router en NS2
ip netns exec $NS2 ip -6 route add default via $NS2VETHIP
#Para el router en NS3
ip netns exec $NS3 ip -6 route add default via $NS3VETHIP
ip netns exec $NS3 ip -6 route add $NS6NET/64 via $NS34PEERIP
#Para el router en NS4
ip netns exec $NS4 ip -6 route add default via $NS4VETHIP
ip netns exec $NS4 ip -6 route add $NS5NET/64 via $NS34VETHIP
#Para el host en NS 5
ip netns exec $NS5 ip -6 route add default via $NS5VETHIP
#Para el host en NS 6
ip netns exec $NS6 ip -6 route add default via $NS6VETHIP


#FORWARD
echo "Habilitando forwarding"
ip netns exec $NS1 sysctl -w net.ipv6.conf.all.forwarding=1
ip netns exec $NS2 sysctl -w net.ipv6.conf.all.forwarding=1
ip netns exec $NS3 sysctl -w net.ipv6.conf.all.forwarding=1
ip netns exec $NS4 sysctl -w net.ipv6.conf.all.forwarding=1
