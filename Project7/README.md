# 🚀 Project 7: Elastic Beanstalk Environment Migration Project (Java to Python)

## 🎯 Project Overview
The Elastic Beanstalk Environment Migration Project (Java to Python) demonstrates how to deploy, manage, and migrate applications across different environments in AWS Elastic Beanstalk.</br>
In this project, a Java-based web application (running on the Tomcat platform) is initially deployed to an Elastic Beanstalk environment. Later, the environment configuration is modified to migrate the application to a Python-based environment (Flask) within the same Elastic Beanstalk application.

## 🧠 Summary in One Line:

Blue-Green Deployment = Two environments + One URL swap = Zero downtime + Safe release 🚀

<img src="Images/Blue-Green.png" alt="AWS Architecture" width="550" height="500">

## ⚙️ Technologies Used
<pre>
1️⃣ IAM Roles and Policies – To grant Elastic Beanstalk environments necessary permissions for S3, EC2, and CloudWatch.
2️⃣ Elastic Load Balancer (ELB) – To manage traffic between blue and green environments during migration.
3️⃣ Auto Scaling Groups (ASG) – To automatically adjust capacity based on load.

</pre>

## 🏗️ Architecture Diagram
                 
                 
                                 ┌────────────────────────┐
                                 │        Developer       │
                                 │  (Java & Python App)   │
                                 └──────────┬─────────────┘
                                            │
                                            │   (Deploy AWS Console)
                                            ▼
         ┌────────────────────────────────────────────────────────────────────┐
         │                       AWS Elastic Beanstalk                        │
         ├────────────────────────────────────────────────────────────────────┤
         │                                                                    │
         │   ┌──────────────────────┐       ┌──────────────────────┐          │
         │   │  Blue Environment    │       │  Green Environment   │          │
         │   │ (Java - Tomcat App)  │       │ (Python - Flask App) │          │
         │   └──────────────────────┘       └──────────────────────┘          │
         │             │                               │                      │
         │             ▼                               ▼                      │
         │     ┌──────────────┐                  ┌──────────────┐             │
         │     │ EC2 Instances│                  │ EC2 Instances│             │
         │     └──────────────┘                  └──────────────┘             │
         │             │                              │                       │
         │             ▼                              ▼                       │
         │     ┌──────────────┐                  ┌──────────────┐             │
         │     │   Auto Scaling│                 │   Auto Scaling│            │
         │     └──────────────┘                  └──────────────┘             │        
         │             │                              │                       │
         │             ▼                              ▼                       │
         │     ┌──────────────┐                 ┌──────────────┐              │
         │     │Load Balancer │──────▶         │ Load Balancer │              │
         │     └──────────────┘                 └──────────────┘              │
         │                                                                    │
         └────────────────────────────────────────────────────────────────────┘
                                                                              
                                               ▼
                                     ┌────────────────────┐
                                     │   Route 53 (DNS)   │
                                     │Switch Traffic Blue │
                                     │     → Green        │
                                     └────────────────────┘
                                               │
                                               ▼
                                    ┌────────────────────────┐
                                    │        End User        │
                                    │Access Application via  │
                                    │    DNS (domain name)   │
                                    └────────────────────────┘

# 🪜 Step-by-Step Implementation

## ✅ 1. Launch EC2 instance 
<pre> 
⬜ Sign in to the AWS Management Console. Navigate to EC2 → Launch Instance. 
▪ Choose Amazon Linux 2 AMI (Free tier eligible). 
▪ Select t2.micro instance type. 
▪ Configure instance details → keep defaults. 
▪ Add key pair → create/download one if not available. 
▪ Launch the instance. 
</pre>

## ✅ 2. Create IAM Role and Attach Permissions
<pre> 
Go to IAM Console → Roles → Create role. 
⬜ STEP 1: Select trusted entity 
▪ Trusted entity type: AWS Server 
▪ Use case: EC2

⬜ STEP 2: Add permissions 
▪ Policy name: CloudWatchFullAccess


⬜ STEP 3: Name, review, and create 

▪ Role name: CloudWatch-logs
▪ Trust policy: default
</pre>

## ✅ 3.Attach created role to EC2 instace 
<pre>
⬜ Go EC2 > Instance 
   ▪ Go to action > Security > Modify IAM role 
   ▪ IAM role: CloudWatch-logs  
</pre>

## ✅ 4.Login to the EC2 instace with terminal and .pem file 
<pre>
⬜ Write a cammands in terminal  
   ▪ sudo -s 
   ▪ sudo yum update -y
   ▪ sudo yum install -y amazon-cloudwatch-agent 
   ▪ sudo find /opt/aws/amazon-cloudwatch-agent/ -name "*.json"
   ▪ sudo cd /opt/aws/amazon-cloudwatch-agent/etc/
   ▪ ls
   then i got 
   ▪ amazon-cloudwatch-agent.json
   ▪ log-config.json
   ▪ env-config.jsonsudo 
   ▪ cat amazon-cloudwatch-agent.json
   ▪ sudo less amazon-cloudwatch-agent.json





   ▪ sudo -s 
   ▪ sudo yum update -y

</pre>

## ✅ 3. Create a Lambda function for stop EC2 instace 
<pre>
⬜ Go to Lambda Console → Create function → Author from scratch. 
   ▪ Function name: Stop-Function 
   ▪ Runtime: Python 3.13
   ▪ Architecture: x86_64
    
 Change default execution role  
   ▪ Execution role: Use an existing role
   ▪ Existing role: 530pm-lambda-role
</pre>

## ✅ 4. Create EventBridge Rule (Scheduler Trigger)
<pre> 
⬜ Go to Amazon EventBridge → Rules → Create rule. 

**** Specify schedule detail ****
Name: Stop-Rule 
Event bus: default 
Rule type: Schedule
Schedule type: Cron-based schedule
Cron expression: 52 13 * ? * 

**** Select target(s) ****
Target API: Templated targets
Select: AWS Lambda (Invoke) 
Lambda function: StopEC2Instance 
Payload:
{
  "instances": ["i-0241ae33d2aef69c5"],
  "action": "stop"
}

📘 This rule automatically invokes your Lambda function on the defined schedule.
</pre>

## ✅ 5.Verify the Automation
<pre> 
⬜ Check Lambda logs in CloudWatch → verify it ran successfully. 
▪ Confirm EC2 instance state → it should stop automatically. 
▪ Modify Lambda code to start the instance if needed (using ec2.start_instances). 
</pre>

# 👩‍💻 Author
## Khushi Nigam
AWS EC2 & Load Balancer Project | Cloud & DevOps Learner