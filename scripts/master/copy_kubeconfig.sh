function copy_kubeconfig() {
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  cat /etc/kubernetes/admin.conf > $SHARED_DIR/${CLUSTER_NAME}_vagrant.config
}
