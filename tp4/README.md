# docker_quagga
Docker files for Quagga services

## Usage
Clone repository
```
$ git clone https://github.com/maticue/docker_quagga.git
```

### OSPF
Change directory
```
$ cd docker_quagga/ospf
```
Create environment
```
$ sudo docker-compose up
```

## IPv6 support
Enable IPv6 support on docker
```
# vi /etc/docker/daemon.json
# cat /etc/docker/daemon.json
{
  "ipv6": true,
  "fixed-cidr-v6": "2001:db8:1::/64"
}
# systemctl restart docker
```

