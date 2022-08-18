#!/bin/sh
if [ ! -z "${SETTINGS_FILE+x}" ]; then
  NGINX_STATIC_FILE_PATH="${STATIC_PATH:-/usr/share/nginx/html}"
  MODIFY_FILE="${NGINX_STATIC_FILE_PATH}/${SETTINGS_FILE}"
  if [ ! -f "$MODIFY_FILE" ]; then
    echo "Error: settings file not found from $MODIFY_FILE !"
    exit 1
  fi
  echo "checking env variables in ${MODIFY_FILE}"
  COMPARE=""
  for VAR in $(jq -r '.|keys|@tsv' ${MODIFY_FILE})
  do
    eval VAL=\$$VAR
    if [ ! -z $VAL ]; then 
      echo "==> ${VAR} = ${VAL}"
      COMPARE="${COMPARE}|.$VAR=env.$VAR"
    fi
  done
  if [ ! -z "${COMPARE+x}" ]; then
    jq ".${COMPARE}" ${MODIFY_FILE} > ${MODIFY_FILE}.tmp && mv ${MODIFY_FILE}.tmp ${MODIFY_FILE}
  fi
  echo "${MODIFY_FILE} variables"
  cat ${MODIFY_FILE}
fi