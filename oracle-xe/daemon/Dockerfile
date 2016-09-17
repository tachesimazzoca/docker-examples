FROM local/oracle-xe-configured:latest

COPY files /tmp/oracle-xe

RUN yum clean all && \
  yum update -y && \
  yum install -y openssh-server && \
  yum clean all

# Start sshd to initialize itself
RUN service sshd start

RUN sed -i 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

RUN echo 'root:docker' | chpasswd

EXPOSE 22 1521

# Running sshd as a daemon makes oracle-xe keep on running
CMD /tmp/oracle-xe/startup.sh && /usr/sbin/sshd -D
