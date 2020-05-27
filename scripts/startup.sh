#!/bin/dash

# set root password if given 
if [ -n "$MSU_ROOT_PASSWD" ]
then
	echo "root:$MSU_ROOT_PASSWD" | chpasswd
fi

if [ "$1" = "cli" ]
then
	shift
	/opt/marvell/storage/cli/mvcli "$@"
	exit
fi

# redirect logs
rm /opt/marvell/storage/db/mvraidsvc.log  1>/dev/null 2>&1
ln -s /dev/stdout /opt/marvell/storage/db/mvraidsvc.log 

sed -ie 's:CustomLog "logs/access_log":CustomLog "/proc/self/fd/1":' /opt/marvell/storage/apache2/conf/httpd.conf
sed -ie 's:ErrorLog "logs/error_log":ErrorLog "/proc/self/fd/2":' /opt/marvell/storage/apache2/conf/httpd.conf
grep 'CustomLog' /opt/marvell/storage/apache2/conf/httpd.conf


# start storage agent in background
/opt/marvell/storage/svc/MarvellStorageAgent start


# start web server in foreground
export LD_LIBRARY_PATH=/opt/marvell/storage/apache2/lib64:/opt/marvell/storage/expat/lib64:/opt/marvell/storage/libxml2/lib64:/opt/marvell/storage/openssl/lib64:/opt/marvell/storage/php/lib64
exec /opt/marvell/storage/apache2/bin/apachectl -D FOREGROUND

