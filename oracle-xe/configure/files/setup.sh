#!/bin/sh

ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

cd `dirname ${0}`

rpm -ivh oracle-xe-11.2.0-1.0.x86_64.rpm

# Prepare {listener,tnsnames}.ora for any hosts
for f in listener.ora tnsnames.ora
do
  cp ${ORACLE_HOME}/network/admin/${f} config/${f}
  sed -i "s/%hostname%/0.0.0.0/g" config/${f}
  sed -i "s/%port%/1521/g" config/${f}
done

for f in init.ora initXETemp.ora
do
  sed -i "s/^memory_target=/#memory_target=/g" ${ORACLE_HOME}/config/scripts/${f}
done

/etc/init.d/oracle-xe configure responseFile=config/xe.rsp

# Replace {listener,tnsnames}.ora with prepared ones
for f in listener.ora tnsnames.ora
do
  cp config/${f} ${ORACLE_HOME}/network/admin/${f}
  chown oracle:dba ${ORACLE_HOME}/network/admin/${f}
done
