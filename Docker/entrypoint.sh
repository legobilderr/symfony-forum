#!/usr/bin/env sh

APACHE_RUN_USER="${APACHE_RUN_USER:-www-data}";
APACHE_RUN_GROUP="${APACHE_RUN_GROUP:-www-data}";

if id "${CURRENT_USER}"  >/dev/null 2>&1; then
  echo "User exist"
else
  groupadd -g ${CURRENT_USER_GROUP_ID} ${CURRENT_USER_GROUP}
  useradd -u ${CURRENT_USER_ID} -m -g ${CURRENT_USER_GROUP} -s /bin/bash ${CURRENT_USER}
fi

if [ ! -d /home/${CURRENT_USER} ]; then
	mkdir /home/${CURRENT_USER}
	chown ${CURRENT_USER}:${CURRENT_USER} /home/${CURRENT_USER}
fi

exec "$@";