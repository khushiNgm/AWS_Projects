# 🚀 Project 9: AWS EFS Mount on EC2 Instances (Step-by-Step Implementation)
## 📘 Project Overview

This project demonstrates how to configure Amazon EFS (Elastic File System) and mount it on two EC2 instances to create a shared file system. Any file created on one EC2 instance is automatically visible on the other, enabling real-time file synchronization. This setup showcases how EFS can be used as a highly available, scalable, and shared network storage solution for multiple servers within the same VPC.

<img src="Images/AmazonEFS.png" alt="AWS Architecture" width="550" height="500">

## ⚙️ Technologies Used
<pre>
1️⃣ Amazon EC2 – Virtual servers used to mount and access the shared file system
2️⃣ Amazon EFS (Elastic File System) – Fully managed shared storage service
3️⃣ VPC & Subnets – Network configuration for EFS and EC2 communication
4️⃣ Security Groups – Firewall rules allowing NFS (2049) traffic
5️⃣ Linux (Amazon Linux/Ubuntu) – Used for installing EFS utilities and mounting the file system
6️⃣ NFS Protocol – Protocol used by EFS for network-based file sharing
7️⃣ AWS Management Console – Used to create and configure AWS resources
8️⃣ SSH – For accessing EC2 instances and executing commands
 
</pre>

## 🏗️ Architecture Diagram
<Pre>
               +--------------------------+
               |       Amazon EFS        |
               |  Shared File System     |
               +-----------+--------------+
                           |
          -----------------------------------------
          |                                       |
+-------------------+                 +--------------------+
|     EC2-Instance1 |                 |    EC2-Instance2   |
|  /efs mount point |                 |  /efs mount point  |
+-------------------+                 +--------------------+

  → If you create a file on EC2-1, it automatically appears on EC2-2.
  → EFS acts as a shared storage that is accessible from both EC2 instances.

</pre>

## 🪜 Step-by-Step Implementation

## ✅ 1.Create an Amazon EFS file system
<pre>
 ▪ AWS Console → Services → EFS → Create file system. 
 ▪ Select the same VPC where your EC2 instances will run. 
 ▪ Keep default options for performance/throughput unless you need custom settings.
 ▪ Note the File system ID (e.g., fs-0123456789abcdef0)

</pre>

## ✅ 2. Launch two EC2 instances (EC2-1 and EC2-2)
<pre>
  ▪ AWS Console → EC2 → Launch instances.
  ▪ Choose Amazon Linux 2023 or Ubuntu LTS.
  ▪ Place both instances in the same VPC (can be different subnets/AZs).
  ▪ Attach a key pair for SSH access.
</pre>

## ✅ 3. Create / configure Security Groups
<pre>
▪ Create a security group for EFS (or reuse): allow Inbound TCP 2049 (NFS) from the EC2 security group.
▪ EC2 security group should allow SSH (port 22) from your IP and allow inbound from the other EC2 if needed.
▪ Ensure outbound rules allow traffic to the EFS mount targets.

</pre>

## ✅4. Install EFS utilities on each EC2
<pre>
▪ Amazon Linux / RHEL:
sudo yum update -y
sudo yum install -y amazon-efs-utils
</pre>

## ✅ 5. Create a mount point and mount EFS (temporary)
<pre>
▪ Replace fs-012345... with your File system ID and region if needed.
sudo mkdir -p /efs
sudo mount -t efs fs-0123456789abcdef0:/ /efs
# or using DNS (recommended): sudo mount -t efs fs-0123456789abcdef0:/ /efs
▪ Verify:
df -h | grep efs
ls -la /efs
</pre>

## ✅ 6. Make the mount persistent (optional but recommended)
<pre>
  ▪ Edit /etc/fstab and add:
  fs-0123456789abcdef0:/ /efs efs defaults,_netdev 0 0
  ▪ Then test:
   sudo umount /efs
   sudo mount -a
</pre>

## ✅ 7. Test file sharing across EC2 instances
<p>
 ▪ On EC2-1:
cd /efs
sudo sh -c 'echo "Hello from EC2-1" > ec21.txt'
ls -l /efs
 ▪ On EC2-2:
cd /efs
ls -l
cat ec21.txt   # should display "Hello from EC2-1"
</br>
Create a file on EC2-2 and verify on EC2-1 similarly.
</p>

## ✅ 8. Set correct file permissions (if required)
<p>
 ▪ Example to allow a specific user:
 sudo chown ec2-user:ec2-user /efs
 sudo chmod 775 /efs

 If using web servers, ensure the web server user (e.g., www-data or apache) has needed access.

## ✅ 9. Cleanup (if you want to remove resources)
<p>
 ▪ Unmount EFS: sudo umount /efs
 ▪ Delete EFS from console and terminate EC2 instances to avoid billing.
</p>

# 👩‍💻 Author
## Khushi Nigam

AWS EFS Distributed File System with EC2  Project | Cloud & DevOps Learner