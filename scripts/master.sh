#. /shared/scripts/env
#. ${SCRIPTS_DIR}/utils/loader.sh

#CATEGORY=master

#load_scripts ${SCRIPTS_DIR}/${CATEGORY}

#start_${CATEGORY}

CATEGORY=master

export SCRIPTS_DIR=/shared/scripts
source ${SCRIPTS_DIR}/init.sh

init ${CATEGORY}




