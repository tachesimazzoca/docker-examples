FROM centos:6

RUN yum clean all && \
  yum update -y && \
  yum install -y initscripts net-tools libaio unzip bc && \
  yum clean all

COPY files /tmp/oracle-xe-configure

CMD /tmp/oracle-xe-configure/setup.sh
