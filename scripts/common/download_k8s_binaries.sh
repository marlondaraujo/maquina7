function download_k8s_binaries() {
  sudo apt-get install -y kubelet=$K8S_PACKAGES_VERSION kubeadm=$K8S_PACKAGES_VERSION kubectl=$K8S_PACKAGES_VERSION
}
