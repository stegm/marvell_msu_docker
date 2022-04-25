FROM alpine:3 AS download_package

# Online download of package
RUN apk add --no-cache wget && \
	wget --quiet https://download.lenovo.com/servers/mig/2019/04/11/19912/mrvl_utl_msu_4.1.10.2046_linux_x86-64.tgz 

# Offline install of marvel package - download https://download.lenovo.com/servers/mig/2019/04/11/19912/mrvl_utl_msu_4.1.10.2046_linux_x86-64.tgz 
# and place it in the Dockerfile directory
#COPY mrvl_utl_msu_4.1.10.2046_linux_x86-64.tgz ./

RUN tar xzf mrvl_utl_msu_4.1.10.2046_linux_x86-64.tgz

	
FROM fedora:35 AS final

# libxcrypt-compat, libnsl: apache webserver for MSU
# procps: install script
RUN yum install -y \
	libxcrypt-compat \
	libnsl \
	procps \
	dash

COPY --from=download_package mrvl_utl_msu_4.1.10.2046_linux_x86-64/MSU-4.1.10.2046-1.x86_64.rpm ./

RUN yum install -y MSU-4.1.10.2046-1.x86_64.rpm

# redirect config db.xml
RUN mv /opt/marvell/storage/db/db.xml /opt/marvell/storage/db/db.xml.orig && \
	ln -s /etc/marvell/db.xml /opt/marvell/storage/db/db.xml

# redirect logs from raid controller
RUN rm /opt/marvell/storage/db/mvraidsvc.log && \
	ln -s /dev/stdout /opt/marvell/storage/db/mvraidsvc.log

# redirect apache logs
RUN sed -ie 's:CustomLog "logs/access_log":CustomLog "/proc/self/fd/1":' /opt/marvell/storage/apache2/conf/httpd.conf && \
	sed -ie 's:ErrorLog "logs/error_log":ErrorLog "/proc/self/fd/2":' /opt/marvell/storage/apache2/conf/httpd.conf

COPY scripts/startup.sh /startup.sh

EXPOSE 8845/tcp
VOLUME ["/dev", "/etc/marvell"]

ENTRYPOINT ["/startup.sh"]

