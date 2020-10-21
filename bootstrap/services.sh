#!/usr/bin/env bash

set -euf -o pipefail

printf "\033[1;33mgrundstein\033[0m service setup.\n"


############################################################


printf "\033[1;33mtouch\033[0m /grundstein.lock"

if test -f "/grundstein.lock"; then
  printf "/grundstein.lock exists.\n"
  printf "there is an installation running or a past installation failed.\n"
  printf "to force reinstallation, add the --force flag to the grundstein command.\n"
  exit 1
fi

touch /grundstein.lock

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33mcreate services directory\033[0m"

mkdir -p /home/grundstein/services

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33m@grundstein/gps\033[0m install"

if [ ! -d "/home/grundstein/services/gps" ] ; then
  git clone git://github.com/grundstein/gps /home/grundstein/services/gps >> /var/log/grundstein/install.log 2>&1
else
  cd "/home/grundstein/services/gps"
  git pull origin master >> /var/log/grundstein/install.log 2>&1
fi


cd /home/grundstein/services/gps

rm -rf node_modules package-lock.json >> /var/log/grundstein/install.log 2>&1

npm install >> /var/log/grundstein/install.log 2>&1

npm test >> /var/log/grundstein/install.log 2>&1

npm link >> /var/log/grundstein/install.log 2>&1

cd /

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33m@grundstein/grs\033[0m install"


if [ ! -d "/home/grundstein/services/grs" ] ; then
  git clone git://github.com/grundstein/grs /home/grundstein/services/grs >> /var/log/grundstein/install.log 2>&1
else
  cd "/home/grundstein/services/grs"
  git pull origin master >> /var/log/grundstein/install.log 2>&1
fi


cd /home/grundstein/services/grs

rm -rf node_modules package-lock.json >> /var/log/grundstein/install.log 2>&1

npm install >> /var/log/grundstein/install.log 2>&1

npm test >> /var/log/grundstein/install.log 2>&1

npm link >> /var/log/grundstein/install.log 2>&1

cd /

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33m@grundstein/gss\033[0m install"


if [ ! -d "/home/grundstein/services/gss" ] ; then
  git clone git://github.com/grundstein/gss /home/grundstein/services/gss >> /var/log/grundstein/install.log 2>&1
else
  cd "/home/grundstein/services/gss"
  git pull origin master >> /var/log/grundstein/install.log 2>&1
fi


cd /home/grundstein/services/gss

rm -rf node_modules package-lock.json >> /var/log/grundstein/install.log 2>&1

npm install >> /var/log/grundstein/install.log 2>&1

npm test >> /var/log/grundstein/install.log 2>&1

npm link >> /var/log/grundstein/install.log 2>&1

cd /

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33m@grundstein/gps\033[0m setup"

cp /grundsteinlegung/src/systemd/gps.service /etc/systemd/system/

systemctl enable gps

systemctl restart gps

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33m@grundstein/grs\033[0m setup"

cp /grundsteinlegung/src/systemd/grs.service /etc/systemd/system/

systemctl enable grs

systemctl restart grs

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33m@grundstein/gss\033[0m setup"

cp /grundsteinlegung/src/systemd/gss.service /etc/systemd/system/

systemctl enable gss

systemctl restart gss

printf " - \033[0;32mdone\033[0m\n\n"


############################################################


printf "\033[1;33mremoving /grundstein.lock\033[0m"

rm -f /grundstein.lock

printf " - \033[0;32mdone\033[0m\n\n"

echo "\033[1;33mGRUNDSTEIN\033[0m - install finished." >> /var/log/grundstein/install.log

printf "INSTALL FINISHED.\n"

############################################################