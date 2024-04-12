. /shared/scripts/env
. ${SCRIPTS_DIR}/utils/loader.sh

CATEGORY=worker

load_scripts ${SCRIPTS_DIR}/${CATEGORY}

start_${CATEGORY}
