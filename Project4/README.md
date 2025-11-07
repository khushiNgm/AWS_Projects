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
Go to IAM Console → Roles → Create role. 
⬜ STEP 1: 
**** Specify permissions ****
▪ Policy editor: write JSON code 

**** Review and create **** 
▪ Policy name:530pm-ec2-policy

⬜ STEP 2: Create a role
**** Select trusted entity ****
▪ Trusted entity type: AWS service
▪ Use case: Lambda

**** Add permissions ****
▪ Added: 530pm-ec2-policy

**** Name, review, and create ****

▪ Choose trusted entity type: AWS Service → Lambda. 
▪ Attach policy: AmazonEC2FullAccess (for testing) or custom policy to Start/Stop instances. 
▪ Name the role: LambdaEC2Role 
▪ Create the role.
📘 This role allows Lambda to perform EC2 start/stop actions.
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

Automated EC2 Instance Scheduler using AWS Lambda & EventBridge Project | Cloud & DevOps Learner