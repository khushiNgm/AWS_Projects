# 🚀 Project 4: Automated EC2 Instance Scheduler using AWS Lambda & EventBridge (For Cost Optimization)

## 🧠 Project Overview

This project automates the start and stop of EC2 instances based on a predefined schedule using AWS Lambda and EventBridge (CloudWatch Events).
It helps in reducing AWS costs by automatically stopping instances when not in use.

<img src="Images/Picture.png" alt="AWS Architecture" width="550" height="500">

## ⚙️ Technologies Used
<pre>
1️⃣ AWS EC2 – Virtual servers to run workloads
2️⃣ AWS IAM – Role and policy for Lambda permissions
3️⃣ AWS Lambda – Function to start/stop EC2 instances
4️⃣ Amazon EventBridge (CloudWatch Events) – Schedule Lambda invocations
</pre>

## 🏗️ Architecture Diagram
               +----------------------+
                |       AWS Cloud      |
                +----------+-----------+
                           |
          +----------------+-----------------+
          |                                  |
     +----v----+                      +------v-------+
     | EventBridge |   (Scheduler)    | AWS Lambda   |
     | (Triggers)  | ---------------> | (Start/Stop) |
     +-------------+                  +--------------+
                                              |
                           +------------------+----------------+
                           |    IAM Role (Access Permission)   |
                           +------------------+----------------+
                                              |
                                              v
                                      +---------------+
                                      |   EC2 Instance |
                                      | (Start / Stop) |
                                      +---------------+

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
⬜ Go to IAM Console → Roles → Create role. 
▪ Choose trusted entity type: AWS Service → Lambda. 
▪ Attach policy: AmazonEC2FullAccess (for testing) or custom policy to Start/Stop instances. 
▪ Name the role: LambdaEC2Role 
▪ Create the role.
📘 This role allows Lambda to perform EC2 start/stop actions.
</pre>

## ✅ 3. Create a Lambda function for stop EC2 instace 
<pre>
⬜ Go to Lambda Console → Create function → Author from scratch. 
   ▪ Name: EC2StopStartFunction 
   ▪ Runtime: Python 3.x (or Node.js) 
   ▪ Execution role: Choose existing role → LambdaEC2Role 
   ▪ In the Code section, paste your EC2 stop/start code. 
</pre>

## ✅ 4. Create EventBridge Rule (Scheduler Trigger)
<pre> 
⬜ Go to Amazon EventBridge → Rules → Create rule. 
   ▪ Name: EC2StopRule 
   ▪ Rule type: Schedule. 
   ▪ Define pattern: Fixed rate or Cron expression (e.g., cron(30 17 * * ? *) for 5:30 PM daily). 
   ▪ Target: Lambda function → select EC2StopStartFunction. 
   ▪ Create rule. 
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