# 🚀 Solution: Auto Scaling in AWS EC2 using Launch Templates with Load Balancer Integration

## ✅ 1. Create a Target Group🎯
![](Image/TargetGRP.png)
## ✅ 2. Create an Application Load Balancer (ALB)⚖️
![](Image/Loadbalancer.png)
## ✅ 3. Create launch template🧩
![](Image/Template.png)
## ✅ 4. Create an Auto Scaling Group (ASG)📈
![](Image/AUTO-SCALING2.png) 
![](Image/AUT.png)
## ✅ 4. Launch an EC2 instance with the help of a launch template.💻
![](Image/EC2-1.png)
## ✅ 5. What happens if I delete an existing EC2 instance?🗑️➡️⚙️
![](Image/EC2-2.png)

## 📝 Note: 💡
When I manually terminated (deleted) the EC2 instance, a new instance was automatically launched.</br>
This happened because of the Auto Scaling Group and Load Balancer configuration, which ensure high availability by maintaining the desired number of running instances.