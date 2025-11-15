sudo -s
yum install -y nfs-utils
mkdir khushi
mount -t nfs4 DNS_NAME:/ khushi/
ls
cd khushi
ls