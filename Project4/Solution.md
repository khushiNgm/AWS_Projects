# 🚀 Solution : Automated EC2 Instance Scheduler using AWS Lambda & EventBridge (For Cost Optimization)

## 🪜 Step-by-Step Implementation

## ✅ 1. Launch EC2 instance 
![](Images/EC2Launch.png)

## ✅ 2. Create IAM Role and Attach Permissions
## Create Policies
![](Images/IAMP.png)

## Create Role
![](Images/IAMROLE.png)

## ✅ 3. Create a Lambda function for stop EC2 instace 
![](Images/LambdaFun.png)
![](Images/LamF.png)

## ✅ 4. Create EventBridge Rule (Scheduler Trigger)
![](Images/AWSEVNEB-1.png)

## ✅ 5.Verify the Automation
![](Images/STOPEC2.png)

As you can see, the EC2 instance was successfully stopped by the Lambda function, confirming that the automation works as expected.