#!/bin/sh

basedir=`dirname ${0}`

/etc/init.d/oracle-xe start

for f in catnoqm.sql initdb.sql
do
  su oracle -c "source ${basedir}/oracle_env.sh && echo exit | sqlplus / as sysdba @${basedir}/${f}"
done
