# 🚀 Project 3: Billing alerts with CloudWatch & SNS 

## 📘 Project Overview

This project creates an automated billing-alerting pipeline using AWS CloudWatch and Amazon SNS. When AWS estimated charges cross a configured threshold, CloudWatch emits an alarm which forwards a notification to an SNS topic. Subscribers (email, Slack webhook, Lambda, etc.) receive the alert so ops or finance teams can act quickly to control costs.

<img src="Image/AWSCLOUDWATCH.png" alt="AWS Architecture" width="550" height="500">

## ⚙️ Technologies Used
<pre>
1️⃣ AWS CloudWatch (Billing Metrics & Alarms) 
2️⃣ Amazon SNS (Topics & Subscriptions)
 
</pre>

## 🏗️ Architecture Diagram
<Pre>
+----------------+ (billing metric)      +-----------------+ (alarm)    +-----------+
| AWS Billing    | --------------------> | CloudWatch      | ---------> | SNS Topic |
| (EstimatedCost)|                       | Alarm           |            +-----+-----+
+----------------+                                           (publish)     |      |
                                                                          Email |   | 
                                                                                v   v
                                                                           nigamkhushi731@gmail.com
</pre>

## 🪜 Step-by-Step Implementation

## ✅ 1. Create a Target Group
<pre>
Go to EC2 → Target Groups → Create Target Group
⬜ STEP 1: 
  ▪ Target type: Instance
  ▪ Target group: Ec2-TG 
  ▪ Protocol: HTTP
  ▪ Ip address type: IPv4 
  ▪ VPC: default 
  ▪ Protocol version: HTPP1 

▪ Register targets (EC2 instances will be automatically attached later by Auto Scaling).
</pre>

## ✅ 2. Create an Application Load Balancer (ALB)
<pre>
Go to Load Balancers → Create Load Balancer → Application Load Balancer
⬜ Choose:
  ▪ Load balancer name: ALB 
  ▪ Scheme: Internet-facing
  ▪ IP type: IPv4

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


## ✅ 5. Verify Setup
<pre>
▪ Wait until your targets show Healthy under the Target Group.
▪ Access the ALB DNS Name in your browser:
http://your-load-balancer-name.us-east-1.elb.amazonaws.com/
</pre>


## 👩‍💻 Author
Khushi Nigam
AWS EC2 & Load Balancer Project | Cloud & DevOps Learner