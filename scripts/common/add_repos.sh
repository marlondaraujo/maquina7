function add_repos() {
  SHORT_VERSION=${K8S_VERSION%.*$}
  sudo apt-get install -y apt-transport-https ca-certificates curl gpg
  sudo mkdir -p -m 755 /etc/apt/keyrings
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v$SHORT_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v'$SHORT_VERSION'/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
}


