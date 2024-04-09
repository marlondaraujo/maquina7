SHARED_FOLDER="/shared/scripts/"

function import_funcs() {
  . ${SHARED_FOLDER}functions.sh
}

function common() {
  update_and_upgrade
  import_funcs
  add_repos
  update_and_upgrade
  download_k8s_binaries
  enable_kubelet
  load_modules
  disable_swap
  setup_cni
}

common
