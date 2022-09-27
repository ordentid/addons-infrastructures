sudo su -
echo 'proxy = proxy4.bri.co.id:1707' >> ~/.curlrc
sudo apt update
sudo apt install curl
curl -V
curl -o container.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.6.4-1_amd64.deb 
curl -o docker-ce-cli.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.9~3-0~ubuntu-focal_amd64.deb
curl -o docker-ce.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.9~3-0~ubuntu-focal_amd64.deb
sudo dpkg -i container.deb
sudo dpkg -i docker-ce-cli.deb
sudo dpkg -i docker-ce.deb
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo mkdir -p /etc/systemd/system/docker.service.d
touch /etc/systemd/system/docker.service.d/proxy.conf
echo '[Service]
Environment="HTTP_PROXY=http://proxy4.bri.co.id:1707/"
Environment="HTTPS_PROXY=http://proxy4.bri.co.id:1707/"
Environment="NO_PROXY="localhost,127.0.0.1,::1,10.35.65.0/24"
' >> /etc/systemd/system/docker.service.d/proxy.conf
sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo docker run hello-world