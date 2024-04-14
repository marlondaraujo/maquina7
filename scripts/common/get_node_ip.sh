function get_node_ip() {
  echo $(hostname -I | cut -d' ' -f2)
}
