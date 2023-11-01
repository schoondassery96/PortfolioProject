#!/usr/bin/env python
# coding: utf-8

# In[2]:


import os, shutil


# In[46]:


path=r"C:/Users/schoondassery/Downloads/PY/live/"


# In[47]:


file_name=os.listdir(path)


# In[48]:


folder_name= ['csv files','pdf files','py files']
for loop in range(0,3):
     if not os.path.exists(path + folder_name[loop]):
        print(path + folder_name[loop])
        os.makedirs((path + folder_name[loop]))


# In[55]:


for file in file_name:
    if ".csv" in file and not os.path.exists(path+"csv files/"+file):
        shutil.move(path+file,path+"csv files/"+file)    
    elif ".jpg" in file and not os.path.exists(path+"pdf files/"+file):
        shutil.move(path+file,path+"pdf files/"+file)   
    elif ".py" in file and not os.path.exists(path+"py files/"+file):
        shutil.move(path+file,path+"py files/"+file)   


# In[ ]:





# In[ ]:




