function fix_network_duplicate_ip {
  node_ip=$(get_node_ip)
  echo KUBELET_EXTRA_ARGS=\"--node-ip=$node_ip\" >> /etc/default/kubelet
  systemctl daemon-reload
  systemctl restart kubelet
}
