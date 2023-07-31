#!/bin/bash 

# ndnc.sh 
# install ndn-dpdk

echo "Installing packages..."

# install packages 

echo "deb [arch=amd64 trusted=yes] https://nfd-nightly-apt.ndn.today/ubuntu jammy main" | tee /etc/apt/sources.list.d/nfd-nightly.list

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends jq libibverbs-dev linux-image-generic ndnsec ndnpeek nfd

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker logout
jq -n '{{
  "data-root": "/home/docker",
  "log-driver": "local",
  "log-opts": {{
    "max-size": "10m",
    "max-file": "3"
  }},
  "mtu": 1420,
  "dns": ["1.1.1.1"]
}}' | tee /etc/docker/daemon.json

sudo systemctl restart docker
wget https://raw.githubusercontent.com/DPDK/dpdk/main/usertools/dpdk-hugepages.py
chmod +x dpdk-hugepages.py
sudo mv dpdk-hugepages.py /usr/bin/

echo "Pulling docker images for ndn-dpdk and ndnc..."

docker pull sankalpatimilsina/ndnc:nov-11
docker pull sankalpatimilsina/ndn-dpdk-apr-27:latest
docker tag sankalpatimilsina/ndn-dpdk-apr-27 ndn-dpdk

echo "Setting forwarder args..."
FW_ACTIVATE = {
    'mempool': {
        'DIRECT': {'capacity': 2**20-1, 'dataroom': 9200},
        'INDIRECT': {'capacity': 2**21-1},
    },
}

echo "Running forwarder..."
sudo dpdk-hugepages.py --clear
sudo dpdk-hugepages.py --pagesize 1G --setup 30G
echo "Launching forwarder container...."
sudo docker ps -q --filter "name=fw" | grep -q . && docker stop fw
sudo docker ps -q -a --filter "name=fw" | grep -q . && docker rm fw
sudo docker run -d --name fw \
      --network host \
      --privileged \
      --mount type=bind,source=/dev/hugepages,target=/dev/hugepages \
      --mount type=volume,source=run-ndn,target=/run/ndn \
      ndn-dpdk
sleep 5
echo "Activating forwarder...."
echo {shlex.quote(json.dumps(FW_ACTIVATE))} | sudo docker run -i --rm \
--privileged \
--network host \
--mount type=bind,source=/dev/hugepages,target=/dev/hugepages \
--mount type=volume,source=run-ndn,target=/run/ndn \
ndn-dpdk ndndpdk-ctrl activate-forwarder
