
function install_flannel() {
  kubectl apply -f /shared/kube-flannel.yml
}

