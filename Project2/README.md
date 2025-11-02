# 🚀 Project 2: Auto Scaling in AWS EC2 using Launch Templates with Load Balancer Integration

## 📘 Project Overview

This project demonstrates **Auto Scaling and Load Balancing** of EC2 instances in AWS using **Launch Templates**.  
The goal is to automatically maintain application availability and distribute incoming traffic evenly across multiple instances using a 

**Load Balancer**.  
When demand increases, **Auto Scaling** launches new EC2 instances automatically, and when demand decreases, it terminates the unnecessary ones — optimizing both **performance** and **cost**.

<img src="Image/architecture.png" alt="AWS Architecture" width="550" height="500">

## ⚙️ Technologies Used
<pre>
1️⃣ **Amazon EC2** – to host scalable web servers  
2️⃣ **Launch Template** – to define instance configurations  
3️⃣ **Auto Scaling Group** – to automatically scale EC2 instances  
4️⃣ **Application Load Balancer (ALB)** – to distribute traffic  
5️⃣ **Target Group** – to route requests to healthy instances  
6️⃣ **Amazon SNS** – for Auto Scaling notifications  
7️⃣ **VPC & Subnets** – for networking and multi-AZ architecture  
</pre>

## 🏗️ Architecture Diagram
<Pre>
            ┌─────────────────────────────┐
            │         Users / Clients     │
            └──────────────┬──────────────┘
                           │
                           ▼
            ┌─────────────────────────────┐
            │ Application Load Balancer   │
            └──────────────┬──────────────┘
                           │
                           ▼
            ┌─────────────────────────────┐
            │     Auto Scaling Group      │
            │ (Uses Launch Template)      │
            └──────────────┬──────────────┘
                           │
          ┌────────────────┴────────────────┐
          ▼                                 ▼
┌────────────────────┐           ┌────────────────────┐
│   EC2 Instance #1  │           │   EC2 Instance #2  │
│ (From Launch Temp) │           │ (From Launch Temp) │
└────────────────────┘           └────────────────────┘
</pre>

## 🪜 Step-by-Step Implementation

## ✅ 1. Create a Target Group
<pre>
Go to EC2 → Target Groups → Create Target Group
⬜ Step 1: 
  ▪ Target type: Instance
  ▪ Target group: Ec2-TG 
  ▪ Protocol: HTTP
  ▪ Ip address type: IPv4 
  ▪ VPC: default 
  ▪ Protocol version: HTPP1 

⬜ Health Check
  ▪ Health check protocol: HTTP 
  ▪ Health check Path: /index.html 

⬜ Advanced health check settings : default 

⬜ Step 2 : Register targets
  ▪ Available instances: 0 
  ▪ select: next 

▪ Register targets (EC2 instances will be automatically attached later by Auto Scaling).
</pre>

## ✅ 2. Create an Application Load Balancer (ALB)
<pre>
Go to Load Balancers → Create Load Balancer → Application Load Balancer
⬜ Choose:
  ▪ Load balancer name: ALB 
  ▪ Scheme: Internet-facing
  ▪ IP type: IPv4

⬜ Network mapping 
  ▪ VPC: default 
  ▪ Availability Zones and subnets: select at least two subnets (from different AZs)
  i)  us-east-1a (use1-az1)
  ii) us-east-1b (use1-az2)

⬜ Security groups 
  ▪ Security groups: default 

⬜ Listeners and routing
  ▪ Protocol: HTTP 
  ▪ Port: 80 
  ▪ Routing action: forward to target group 
  ▪ Target group: Ec2-tg 
</pre>

## ✅ 3. Create launch template
<pre>
⬜ Launch template name: Launch-Tem
  ▪ Application and OS Images (Amazon Machine Image) 
  ▪ Select AMI: Ubuntu 
  ▪ Instance type: t2.micro 
  ▪ Key pair(login): default  
</pre>

## ✅ 4. Create an Auto Scaling Group (ASG)
<pre>
Go to EC2 → Auto Scaling Groups → Create
⬜ STEP 1: 
 ▪ Auto Scaling group name: Auto-grp
 ▪ Choose launch template: Launch-Tem 
 ▪ Auto Scaling group name: Auto-grp
 ▪ Launch Template: Template-For-Pro1

⬜ STEP 2: Choose instance launch options
 ▪  VPC: Default 
 ▪ Availability Zones and subnets: 
   i) use1-az1 (us-east-1a)
  ii) use1-az2 (us-east-1b)
 ▪ Availability Zone distribution: Balanced best effort 

⬜ Step 3: Integrate with other services
▪ Integrate with Load Balancer:
i) Select Load balancing options: Attach to an existing load balancer 
ii) Select the load balancers to attach: Chose from your balancer target group 
iii) Existing load balancer target groups: Ec2-tg | HTTP
iv) Select VPC Lattice service to attach: No VPC Lattice service 
v) Additional health check types: Turn on Elastic Load Balancing health checks

Step 4: Configure group size and scaling policies
i) Desired capacity: 3
ii) Scaling
▪ Group size:
Desired: 3
Minimum: 2
Maximum: 12
iii) Choose whether to use a target tracking policy: Target tracking scaling policy
iv) Scaling policy name: Target Tracking Policy
v) Metric type
   Average CPU utilization 
   Target value: 30 
   Instance warmup: 300 secound 
vi) Instance maintenance policy I
  i) Choose a replacement behavior depending on your availability requirements:No policy  
  ii) Additional capacity settings: Default 

Step 5: Add notifications
 i) Send a notification to:
 ii) With these recipients:
 iii) Event types:


## ✅ 5. Verify Setup
<pre>
▪ Wait until your targets show Healthy under the Target Group.
▪ Access the ALB DNS Name in your browser:
<pre>
http://your-load-balancer-name.us-east-1.elb.amazonaws.com/
</pre>
</pre>

## ✅ 6. OutPut 
<pre>
Every refresh will show responses from different EC2 instances:
Welcome to Auto Scaled Instance - ip-172-31-8-45
Welcome to Auto Scaled Instance - ip-172-31-12-33
</pre>

## 👩‍💻 Author
Khushi Nigam
AWS EC2 & Load Balancer Project | Cloud & DevOps Learner