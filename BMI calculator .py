#!/usr/bin/env python
# coding: utf-8

# In[37]:


weight = int(input("Enter your weight in pounds "))
height= int(input("Enter your height in inches "))
name = input("Enter your name: ")

BMI=(weight * 703)/(height * height )
print("Your weight is "+ str(weight))
print("Your Height is "+str(height))
print(name+ ', your BMI is '+ str(BMI))
if BMI>0:
   if(BMI < 18.5):
       print("You are underweight")
   elif (BMI<=24.9):
        print("you are normal weight")
   elif (BMI<=29.9):
        print("you are overweight")
   else:
        print("You are obesity")
else:
    print('Enter valid input')


# In[31]:





# In[33]:





# In[ ]:





# In[ ]:


Underweight = <18.5
Normal weight = 18.5–24.9
Overweight = 25–29.9
Obesity = BMI of 30 or greater


# In[ ]:





# In[14]:





# In[ ]:


#BMI=(weight in pounds * 703)/(height in inches * height in inches)

