function init_kubeadm() {
  kubeadm init --apiserver-advertise-address $MASTER_IP --pod-network-cidr=$NETWORK_CIDR --node-name $NODENAME --apiserver-cert-extra-sans=$MASTER_IP
}
