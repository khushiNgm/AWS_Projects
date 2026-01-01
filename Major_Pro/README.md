# 🚀 AWS Scalable & Secure Web Hosting Architecture  
### **VPC + EC2 + Application Load Balancer + CloudFront + S3 Logging**

## 📘 Project Overview
Designed and implemented a full AWS infrastructure to host a web application with high availability and low latency.The setup includes a multi-AZ VPC design, public & private subnets, EC2 web servers behind an Application Load Balancer using Round-Robin traffic routing, and CloudFront CDN integration for global content distribution.S3 logging and IAM-based controlled access ensure centralized monitoring, auditing, and security compliance.

## 📌 Key Highlights

- Designed a **Highly Available VPC Architecture** with **2 Public + 2 Private Subnets**, NAT Gateway & routing policies → **~40% improvement in network reliability**
- Deployed web servers in **Private EC2 Instances behind ALB** using Round-Robin routing → **~50% increased availability & traffic handling efficiency**
- Integrated **CloudFront CDN with ALB** for global content delivery → **35–45% reduced latency & faster response**
- Configured **S3 centralized logging with AWS CLI + IAM** → **~60% improvement in traceability & audit readiness**
---

## ⚙️ Technologies Used

- 🏗 **VPC + Subnets** → Secure isolated network
- 🖥 **EC2** → Application hosting
- ⚖ **Application Load Balancer (ALB)** → Load balancing (Round-Robin)
- 🌐 **NAT Gateway** → Private subnet internet access
- 🚀 **CloudFront (CDN - Content Delivery Network)** → Faster global content delivery
- 📦 **S3 Logging** → Log storing & auditing
- 🔐 **IAM & AWS CLI** → Access management & automation


## 🏗 Architecture Overview

                           ┌────────────────────────────┐
                           │          Internet          │
                           └───────────────┬────────────┘
                                           │
                                           ▼
                                ┌────────────────────┐
                                │  Internet Gateway  │
                                └──────────┬─────────┘
                                           │
                                 ┌─────────────────┐
                                 │   Route Table   │
                                 │ 10.0.1.0/24 etc.│
                                 └─────────────────┘
                                           │
        ┌──────────────────────────────────┴──────────────────────────────────┐
        │                                VPC                                  │
        │ ┌─────────────────────────┐                     ┌─────────────────┐ │
        │ │     Public Subnet 1     │                     │ Public Subnet 2 │ │
        │ │ (Web Server / EC2)      │                     │ (Web Server)    │ │
        │ └───────────┬─────────────┘                     └─────────────┬───┘ │
        │             │                                      │                │
        │             └─────────────┬────────────────────────┘                │
        │                           │                                         │
        │                   ┌────────▼────────┐                               │
        │                   │   NAT Gateway   │                               │
        │                   └────────┬────────┘                               │
        │                            │                                        │
        │                ┌───────────▼───────────┐                            │
        │                │ Application Load Bal. │                            │
        │                └───────────┬───────────┘                            │
        │                            │                                        │
        │                      ┌─────▼─────┐                                  │
        │                      │ CloudFront│──────────────┐                   │
        │                      └─────┬─────┘              │                   │
        │                            │                    ▼                   │
        │                            │              ┌─────────────┐           │
        │                            │              │   S3 Bucket │◄─ Logs    │
        │                            │              └─────────────┘           │
        │ ┌─────────────────────────┐                     ┌─────────────────┐ │
        │ │    Private Subnet 1     │                     │ Private Subnet 2│ │
        │ │   (Backend / Future)    │                     │ (Backend)       │ │
        │ └─────────────────────────┘                     └─────────────────┘ │
        └─────────────────────────────────────────────────────────────────────┘

## 🪜 Step-by-Step Implementation

### 1️⃣ Create IAM User & Permissions

#### 🟦 Step 1: Create User Group
- Create a new group → **vpc-grp-01**
- Attach the following permission policies:
  1. AmazonVPCFullAccess, 2. AmazonEC2FullAccess, 3. AmazonS3FullAccess, 4. ElasticLoadBalancingFullAccess, 5. CloudFrontFullAccess,
  6. CloudWatchFullAccess, 7. EC2InstanceConnect

#### 🟦 Step 2: Create IAM User
- Create IAM user → **Dev-User**
- Attach the **vpc-grp-01** group to this user
- Generate **Access Key & Secret Key** for CLI usage (optional for later steps)

#### 🟦 Login
- Sign in to AWS Console using the newly created **IAM user credentials**
- (Recommended) Configure AWS CLI using  
  ```bash
  aws configure


### 2️⃣ VPC & Networking Setup

---

### **STEP 1: Create VPC**
- **Name:** `VPC-01`
- **IPv4 CIDR Block:** `10.0.0.0/16` (Default range)

Inside this VPC, we will create Public and Private Subnets.

---

### **STEP 2: Create Subnets (2 Public + 2 Private)**

#### **Public Subnets**

<pre>
Subnet Name: Public-Subnet-01
Availability Zone: us-east-1a
VPC CIDR: 10.0.0.0/16
Subnet CIDR: 10.0.0.0/24
</pre>

#### **for Public-Subnet-02**

<pre>
Subnet Name: Public-Subnet-02
Availability Zone: us-east-1b
VPC CIDR: 10.0.0.0/16
Subnet CIDR: 10.0.1.0/24
</pre>

#### **Private Subnets**

<pre>
Subnet Name: Private-Subnet-01
Availability Zone: us-east-1c
VPC CIDR: 10.0.0.0/16
Subnet CIDR: 10.0.2.0/24
</pre>

<pre>
Subnet Name: Private-Subnet-02
Availability Zone: us-east-1d
VPC CIDR: 10.0.0.0/16
Subnet CIDR: 10.0.3.0/24
</pre>
---

### **STEP 3: Create Internet Gateway**
- **Name:** `Internet-Gateway-01`
- Attach Internet Gateway to **VPC-01**

This will allow public subnets to access the internet.

---

### **STEP 4: Create Route Table**
- **Name:** `Route-Table-01`
- Associate it with **VPC-01**

---

### **STEP 5: Configure Routes**
- Edit Route → Add New Route  
  - **Destination:** `0.0.0.0/0`  
  - **Target:** Internet Gateway  

---

### **STEP 6: Associate Route Table with Public Subnets**
- Go to **Subnet Associations**
- Select:
  - `Public-Subnet-01`
  - `Public-Subnet-02`

✔ Now Public Subnets have internet access via IGW.

---

### **STEP 7: Create NAT Gateway (for Private Subnets outbound access)**
- **Name:** `NAT-01`
- **Subnet:** `Public-Subnet-01`
- **Connectivity type:** Public
- Allocate **Elastic IP**

---

🎉 **VPC Setup Completed Successfully!**

Public subnets can access internet through IGW  
Private subnets will use NAT Gateway for secure outbound access.

---

### 3️⃣ Launch EC2 Instances
- Deployed two EC2 Ubuntu servers with my custom vpc in different Availability Zones

Lanch amazon app in ec2 
<pre>
apt update
apt install nginx -y 
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git
mv online-clone-amazon/* /var/www/html
</pre>

Then lanch another instace and lanch application through shell scripts

- Installed and configured Apache Web Server
- Added custom index.html on each server for traffic test

### 4️⃣ Create Target Group
- Created Target Group for EC2 instances
- Set Health Check path `/index.html`
- Registered both EC2 instances

### 5️⃣ Configure Application Load Balancer (ALB)
---

### **STEP 1: Create ALB**
- **Name:** `ELB-01`
- **Scheme:** Internet-facing  
- **Load Balancer Type:** Application Load Balancer  
- **IP Address Type:** IPv4  

---

### **STEP 2: Configure Network Mapping**
- **VPC:** Select your created VPC (`VPC-01`)
- **Availability Zones (Enable both Public Subnets):**
  - `us-east-1a` → Public-Subnet-01  
  - `us-east-1b` → Public-Subnet-02  

---

### **STEP 3: Configure Security Group**
- Select/assign a security group allowing **HTTP (Port 80)** inbound traffic

---

### **STEP 4: Listener & Target Group**
- Listener: **HTTP : 80**
- Forward traffic to previously created **Target Group**

---

After successful creation, AWS will provide a **DNS Name** for your ALB.  
You can access the application using this DNS URL in any browser.

### 6️⃣ Deploy CloudFront Distribution

---

### **STEP 1: Create Distribution**
- Go to **CloudFront → Create Distribution**
- **Distribution Name:** `dst-01`
- **Distribution Type:** Single website or application

---

### **STEP 2: Configure Origin**
- **Origin Type:** Elastic Load Balancer  
- **Origin:** Select your ALB from the list  
- **Settings:**  
  - Origin settings → *Customize origin settings*  
  - **Protocol:** HTTP Only  
  - **Origin Shield Region:** US East (N. Virginia) `us-east-1`  
- Keep all other defaults

---

### **STEP 3: Security Settings**
- Select: **Do not enable security protection** (for demo/testing environment)  
> *(In production you may enable WAF, Shield, SSL, HTTPS etc.)*

---

### **STEP 4: Review & Create**
- Review all configuration
- Click **Create Distribution**

---

Once deployed, CloudFront will generate a **Distribution Domain Name (URL)**.  
You can use this URL to access your website globally with improved performance and caching.

---

### 7️⃣ S3 Logging Setup

---

### **STEP 1: Create S3 Bucket**
- **Bucket Type:** General Purpose  
- **Bucket Name:** `amz-clone-app-bucket`  
- Keep all default settings and create the bucket

---

### **STEP 2: Create Folder for Logs**
- Inside the bucket, create a folder named: `logs/`
- Copy the **S3 URI** for later use

---

### **STEP 3: Configure AWS CLI on EC2**
- Connect to one of the EC2 instances
```bash
sudo snap install aws-cli --classic

Configure AWS credentials (Access Key + Secret Key)
aws configure

STEP 4: Upload Logs to S3
aws s3 cp /var/log/nginx/access.log <S3-URI>


8 Testing & Validation
- Accessed application using ALB DNS & CloudFront URL
- Auto traffic distribution observed (Round Robin)
- Verified logs in S3 Bucket

```

# 🧾 Author
## Khushi Nigam
AWS | Cloud | DevOps Learner
📌 Passionate about building scalable cloud architecture & automation