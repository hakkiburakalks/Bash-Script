#!/usr/bin/bash

# Author: Burak Alkis
# Date Created: 30.12.2024
# Last Modified: 30.12.2024
# Description:
# ./service_restart.sh

# Bu script, MySQL veritabanı bağlantılarındaki kopmalar nedeniyle oluşabilecek sorunları tespit etmek ve önlemek amacıyla yazılmıştır. Özellikle radiusd loglarında görülebilen veritabanı bağlantısı kopmalarını izler. Script, her 5 dakikada bir çalışarak MySQL server bağlantısının durumunu kontrol eder ve kopmalar durumunda  gerekli müdahaleleri başlatır.


serviceName=radiusd
status=$(systemctl show -p SubState $serviceName | cut -d'=' -f2)


echo "If the ${serviceName} service is in a failed state, the ${serviceName} will restart service will be restarted"
if [ "${status}" = "dead" ]; then
echo "${serviceName} service is ${status} , service will be restarting"
systemctl restart $serviceName
echo "${serviceName} service restarted on $(date +"%Y-%m-%d %H:%M:%S")" >> /var/log/service-restart.log
else
echo "${serviceName} service is ${status}"
fi
exit 1
