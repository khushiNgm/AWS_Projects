# 🚀 Solution : Elastic Beanstalk Environment Migration Project (Java to Python)

## 🪜 Step-by-Step Implementation

# ✅ 1: Create an Elastic Beanstalk Application
![](Images/CreatEBS.png)

## ✅ 2: Create a Java (Blue) Environment

## ⬜ 1: Configure environment
![](Images/CES-1.png)

## ⬜ 2: Configure service access
![](Images/CES2.png)

## ⬜ 3: Set up networking, database, and tags (Select default value)
![](Images/CES3.png)

## ⬜ 4: Configure instance traffic and scaling
![](Images/CES4.png)

## ⬜ 5: Configure updates, monitoring, and logging
![](Images/CES5.png)

## ⬜ 6: Review Everything and Click on Create
![](Images/CES-6.png)

## ✅ STEP 3: Test the Blue Environment
![](Images/JAE.png)
![](Images/JAEIMG.png)

## ✅ STEP 4: Create a Python (Green) Environment for aaplication 
Repeat the same steps as in the Blue environment deployment.

## ✅ STEP 5: Test the Green Environment
![](Images/PAEIMG.png)

## ✅ STEP 6: Verify Both Environments
You can now see that both environments have been created successfully.
![](Images/ENVT-2.png)
![](Images/ENVIROMENT-2.png)

## ✅ STEP 6: Perform Blue-Green Deployment (CNAME Swap)
![](Images/SWAPENV.png)
![](Images/SEAPENV2.png)

## 🎉 Result:
Successfully completed the environment migration!
After performing the CNAME swap, if you refresh your page, the application will now run using Python (Flask) instead of Java (Tomcat) — with zero downtime.