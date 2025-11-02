## ✅ 1. Create a Target Group
![](Image/TargetGRP.png)
## ✅ 2. Create an Application Load Balancer (ALB)
![](Image/Loadbalancer.png)
## ✅ 3. Create launch template
![](Image/Template.png)
## ✅ 4. Create an Auto Scaling Group (ASG)
![](Image/AUTO-SCALING2.png) 
![](Image/AUT.png)
## ✅ 4. With template launch ec2 instance 
![](Image/EC2-1.png)
## ✅ 5. If i delete EC2 instance : 
![](Image/EC2-2.png)

## 📝 Note:
When I manually terminated (deleted) the EC2 instance, a new instance was automatically launched.
This happened because of the Auto Scaling Group and Load Balancer configuration, which ensure high availability by maintaining the desired number of running instances.