# kubeadm init --apiserver-cert-extra-sans=controlplane --apiserver-advertise-address 192.83.79.10 --pod-network-cidr=10.244.0.0/16
# IP_ADDR=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
# local_ip="$(ip --json addr show eth0 | jq -r '.[0].addr_info[] | select(.family == "inet") | .local')"

MASTER_IP=$(hostname -I | cut -d' ' -f2)
NETWORK_CIDR=10.244.0.0/16
NODENAME=$(hostname -s)

kubeadm init --apiserver-advertise-address $MASTER_IP --pod-network-cidr=$NETWORK_CIDR --node-name $NODENAME --apiserver-cert-extra-sans=$MASTER_IP

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm token create --print-join-command > /shared/join_command

kubectl apply -f /shared/kube-flannel.yml






