# BGP+OSPF with IPv6
To create routers with OSPFv3 and BGP configuration it is necessary to execute docker-compose:

## Infrastructure creation 

```
$ sudo docker-compose up
```

This will build 2 Quagga images. One with OSPFv3, and other image with OSPFv3 and BGP
* ospf:20180419
* bgp:20180426

Then, it will create 5 networks:
* oam
* nr1b1
* nr1
* nr2b2
* nr2

Finally, it will create 4 containers:
* b1
* b2
* r1
* r2

## Topology

Network topology will look like the following diagram:

```
    +--------------------[b1]----------------------[b2]---------------------+
    | 2001:aaaa:aaaa::5/64  2001::5/64    2001::6/64  2001:bbbb:bbbb::6/64  |
    |                                                                       |
    | 2001:aaaa:aaaa::10/64                           2001:bbbb:bbbb::10/64 |
  [r1]-+                                                                 +-[r2]
    |  |                                                                 |  |
    +--+                                                                 +--+
      2001:aaaa:1111::10/64                           2001:bbbb:2222::10/64
```

## Notes

Current implementation does not disable default gateway added by docker on each container. To ensure full protocol test, is necessary to delete default routes on each container.
