function generate_joincommand() {
  kubeadm token create --print-join-command > $SHARED_DIR/join_command
}
