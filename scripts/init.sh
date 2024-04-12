#export ENV_FILE=/shared/scripts/env
export ENV_FILE=${SCRIPTS_DIR}/env

function init() {
  category=$1
  
  source ${ENV_FILE}
  source ${SCRIPTS_DIR}/utils/loader.sh

  load_scripts ${SCRIPTS_DIR}/${CATEGORY}
  start_${CATEGORY}
}

