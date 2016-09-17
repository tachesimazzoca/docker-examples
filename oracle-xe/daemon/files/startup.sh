#!/bin/sh

ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

basedir=`dirname ${0}`

/etc/init.d/oracle-xe start

for f in "${ORACLE_HOME}/rdbms/admin/catnoqm.sql" "${basedir}/initdb.sql"
do
  su oracle -c "source ${basedir}/oracle_env.sh && echo exit | sqlplus / as sysdba @${f}"
done
