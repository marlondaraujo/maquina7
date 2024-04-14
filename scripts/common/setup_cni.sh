function setup_cni() {
  load_modules

  wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz

  sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz

  wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64

  sudo install -m 755 runc.amd64 /usr/local/sbin/runc

  wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz

  sudo mkdir -p /opt/cni/bin

  sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

  sudo mkdir /etc/containerd

  containerd config default | sudo tee /etc/containerd/config.toml

  sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

  sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service

  sudo systemctl daemon-reload

  sudo systemctl enable --now containerd
}

