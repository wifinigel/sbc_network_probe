
## Tested Containers


### Openspeedtest

```
sudo docker pull openspeedtest/latest
sudo docker run --restart=unless-stopped --name=openspeedtest -d -p 80:8080 openspeedtest/latest
```

### iperf3

```
sudo docker run --rm -t -p 5201:5201 -p 5201:5201/udp --name iperf3 taoyou/iperf3-alpine:latest
```