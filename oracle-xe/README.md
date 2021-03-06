# docker-examples/oracle-xe

## Requirements

This example requires the "Oracle Database Express Edition 11g Release 2".

* http://www.oracle.com/technetwork/products/express-edition/downloads/index-083047.html

Make sure that the Linux version `oracle-xe-11.2.0-1.0.x86_64.rpm` is located at the following path.

    $ md5sum configure/files/oracle-xe-11.2.0-1.0.x86_64.rpm
    3371612d47e1a0a4cc8f53470b1f4fe3  configure/files/oracle-xe-11.2.0-1.0.x86_64.rpm

Oracle XE requires more than 2GB swap space. If you use boot2docker (Docker Toolbox), you might need to create a new swap space manually in your docker machine.

Make sure that any changes outside of the `/var/lib/docker` and `/var/lib/boot2docker` will be lost after rebooting boot2docker VM. In other words, there is no point in adding swap files into `tmpfs` or modifying `/etc/fstab` for automount.

You can define `/var/lib/boot2docker/bootlocal.sh` as a startup script.

    $ docker-machine ssh
    $ sudo su -

    $ dd if=/dev/zero of=/var/lib/boot2docker/swap bs=1M count=2048
    $ mkswap /var/lib/boot2docker/swap
    $ swapon /var/lib/boot2docker/swap

    $ cat /var/lib/boot2docker/bootlocal.sh
    #!/bin/sh

    swapon /var/lib/boot2docker/swap

    $ chmod 755 /var/lib/boot2docker/bootlocal.sh

 See [boot2docker FAQ](https://github.com/boot2docker/boot2docker/blob/master/doc/FAQ.md#local-customisation-with-persistent-partition) to get more details.

## Build an image

The setup command `/etc/init.d/oracle-xe configure` will access `/proc` files. To accomplish this, the `--privileged` option is required on runtime.

* https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities

Unfortunately, the command `docker build` doesn't support such an option, so you need to prepare a configured image by running a container. This example `daemon/Dockerfile` expects the configured image should be tagged as `local/oraxle-xe-configred:latest`.

    # Prepare local/oracle-xe-configured by running a container with --privileged option
    $ docker build -t local/oracle-xe-configured configure
    $ docker run --privileged -it --name <oracle-xe-configured> local/oracle-xe-configured
    $ docker commit <oracle-xe-configured> local/oracle-xe-configured

    # And then build an image from "local/oracle-xe-configured:latest"
    $ cat daemon/Dockerfile
    FROM local/oracle-xe-configured:latest
    ...

    $ docker build -t <your-image-id> daemon
    $ docker run -d -p 1521:1521 -p 22 <your-image-id>

    # Please wait until the service "oracle-xe" has been launched
    $ docker logs <your-container-id>
    Starting Oracle Net Listener.
    Starting Oracle Database 11g Express Edition instance.
    ...
    SQL> Disconnected from Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

    $ sqlplus test/test@${DOCKER_HOST}:1521/XE

    # SSH login with the password "root:docker"
    $ ssh -p <port> root@${DOCKER_HOST}

