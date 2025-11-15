sudo -s
sudo yum install -y amazon-efs-utils
mkdir EFSTest
mount -t nfs4 DNS_NAME:/ EFSTest/
cd EFSTest
touch file{1..5}
ls