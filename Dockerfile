FROM fedora:31

# unzip: used for unzipping downloaded packge
# libxcrypt-compat, libnsl: apache webserver for MSU
# procps: install script
RUN yum install -y \
	unzip \
	libxcrypt-compat \
	libnsl \
	procps \
	dash

COPY Marvell_MSU_Linux_v4.1.0.2032.zip Marvell_MSU_Linux_v4.1.0.2032.zip

RUN unzip Marvell_MSU_Linux_v4.1.0.2032.zip
RUN yum install -y /Marvell_MSU_Linux_v4.1.0.2032/MSU-4.1.0.2032-1.x86_64.rpm

COPY scripts/startup.sh /startup.sh

EXPOSE 8845/tcp
VOLUME ["/dev", "/etc/marvell"]

ENTRYPOINT ["/startup.sh"]

