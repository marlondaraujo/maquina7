export MASTER_IP=$(hostname -I | cut -d' ' -f2)
export NETWORK_CIDR=10.244.0.0/16
export NODENAME=$(hostname -s)
export CLUSTER_NAME=$(hostname | cut -d- -f1)

function start_master() {
  init_kubeadm
  copy_kubeconfig
  generate_joincommand
  install_network_plugin
}
