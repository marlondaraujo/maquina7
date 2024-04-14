echo "scripts/common/common.sh"
env

function start_common() {
  update_and_upgrade
  import_funcs
  add_repos
  update_and_upgrade
  download_k8s_binaries
  enable_kubelet
  load_modules
  disable_swap
  setup_cni
  fix_network_duplicate_ip
}
