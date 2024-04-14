#function add_repos() {
#  sudo apt-get install -y apt-transport-https ca-certificates curl gpg
#  sudo mkdir -p -m 755 /etc/apt/keyrings
#  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
#}
#
#function disable_swap() {
#  sudo swapoff -a
#  sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
#}
#
#function load_modules() {
#cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
#overlay
#br_netfilter
#EOF
#
#sudo modprobe overlay
#sudo modprobe br_netfilter
#
## sysctl params required by setup, params persist across reboots
#cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
#net.bridge.bridge-nf-call-iptables  = 1
#net.bridge.bridge-nf-call-ip6tables = 1
#net.ipv4.ip_forward                 = 1
#EOF
#
## Apply sysctl params without reboot
#sudo sysctl --system
#}
#
#function setup_cni() {
#  load_modules
#
#  wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
#
#  sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz
#
#  wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
#
#  sudo install -m 755 runc.amd64 /usr/local/sbin/runc
#
#  wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
#
#  sudo mkdir -p /opt/cni/bin
#
#  sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
#
#  sudo mkdir /etc/containerd
#
#  containerd config default | sudo tee /etc/containerd/config.toml
#
#  sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
#
#  sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
#
#  sudo systemctl daemon-reload
#
#  sudo systemctl enable --now containerd
#}
#
#function download_k8s_binaries() {
#  sudo apt-get install -y kubelet kubeadm kubectl
#}
#
#function enable_kubelet() {
#  sudo systemctl enable --now kubelet
#}
#
#function update_and_upgrade() {
#  apt-get update -q
#  apt-get upgrade -y
#}
#
#function install_flannel() {
#  . kube-flannel.yml
#}
#
#function get_node_ip() {
#  echo $(hostname -I | cut -d' ' -f2)
#}
#
#function fix_network_duplicate_ip {
#  node_ip=$(get_node_ip)
#  echo KUBELET_EXTRA_ARGS=\"--node-ip=$node_ip\" >> /etc/default/kubelet
#  systemctl daemon-reload
#  systemctl restart kubelet
#}










 
