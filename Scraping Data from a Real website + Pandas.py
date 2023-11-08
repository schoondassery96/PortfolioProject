#!/usr/bin/env python
# coding: utf-8

# In[3]:


from bs4 import BeautifulSoup
import requests


# In[6]:


url = 'https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue'
page = requests.get(url)
soup = BeautifulSoup(page.text, 'html')


# In[7]:


print(soup)


# In[10]:


soup.find_all('table')[1]


# In[11]:


table= soup.find_all('table')[1]


# In[12]:


print(table)


# In[18]:


world_titles = table.find_all('th')


# In[19]:


world_titles


# In[20]:


world_table_titles = [title.text.strip() for title in world_titles]
print(world_table_titles)


# In[21]:


import pandas as pd


# In[22]:


df = pd.DataFrame(columns=world_table_titles)
df


# In[25]:


column_data = table.find_all('tr')


# In[37]:


for row in column_data[1:]:
    row_data = row.find_all('td')
    indiv_rowData = [value.text.strip() for value in row_data]
    #print( indiv_rowData )
    
    length = len(df)
    df.loc[length] = indiv_rowData
    


# In[38]:


df


# In[40]:


df.to_csv(r'C:\Users\schoondassery\Documents\Python Scripts\output.csv')


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:


<table class="wikitable sortable jquery-tablesorter">
<caption>


# In[ ]:




