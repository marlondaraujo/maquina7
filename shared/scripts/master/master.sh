# kubeadm init --apiserver-cert-extra-sans=controlplane --apiserver-advertise-address 192.83.79.10 --pod-network-cidr=10.244.0.0/16
# IP_ADDR=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
# local_ip="$(ip --json addr show eth0 | jq -r '.[0].addr_info[] | select(.family == "inet") | .local')"

MASTER_IP=$(hostname -I | cut -d' ' -f2)
NETWORK_CIDR=10.244.0.0/16
NODENAME=$(hostname -s)
SHARED_FOLDER=/shared
CLUSTER_NAME=$(hostname | cut -d- -f1) # k8smd1000-master-0

function init_kubeadm() {
  kubeadm init --apiserver-advertise-address $MASTER_IP --pod-network-cidr=$NETWORK_CIDR --node-name $NODENAME --apiserver-cert-extra-sans=$MASTER_IP
}

function copy_kubeconfig() {
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  cat /etc/kubernetes/admin.conf > $SHARED_FOLDER/${CLUSTER_NAME}_vagrant.config
}

function generate_joincommand() {
  kubeadm token create --print-join-command > $SHARED_FOLDER/join_command
}

function install_flannel() {
  kubectl apply -f /shared/kube-flannel.yml
}

function install_network_plugin() {
  install_flannel
}

function master() {
  init_kubeadm
  copy_kubeconfig
  generate_joincommand
  install_network_plugin
}

master










