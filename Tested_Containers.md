
## Other Tested Containers


### Openspeedtest

Create a speedtest server using this container:

https://hub.docker.com/r/taoyou/iperf3-alpine

```
sudo docker run --restart=unless-stopped --name=openspeedtest -d -p 80:8080 openspeedtest/latest
```

### iperf3

iperf3 test server container:

iperf3: https://hub.docker.com/r/taoyou/iperf3-alpine

```
sudo docker run --restart=unless-stopped -t -p 5201:5201 -p 5201:5201/udp --name iperf3 taoyou/iperf3-alpine:latest
```