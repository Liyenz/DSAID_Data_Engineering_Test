#!/usr/bin/env python
# coding: utf-8

# This is the document for the DSAID Data Engineering Technical Test - Section 1.
# The objective of this section is to design and implement a solution to process a data file on a regular interval (e.g. 1am  daily). Given the test data file dataset.csv,  the expected output of the processing task is a CSV file including a header containing the field names. 
# 
# Processing tasks:
# 
# Split the name field into first_name, and last_name
# Remove any zeros prepended to the price field
# Delete any rows which do not have a name
# Create a new field named above_100, which is true if the price is strictly greater than 100
# 
# The code is written in Python.

# Read dataset.csv file into Pandas Dataframe

# In[1]:


#import pandas
import pandas as pd

#declare a variable to hold URL
filename = 'dataset.csv'

#read dataset.csv file into a dataframe
df = pd.read_csv(filename, sep=',')

#print top 5 records
print(df.head())
print(df.info())


# Based on above information, there should not be any rows that do not have name because of non-null columns.

# In[2]:


#Check if any null to confirm
df.isnull().sum()

#remove rows based on the missing values
#df.dropna(subset=['name'], inplace=True)


# The name column contains salutation. It needs to be removed before splitting the name column into first_name and last_name.
# It is using the regular expression to perform the search and replace of the string in the name column.
# Assumed that the salutation includes 'Mr.', 'Mrs.', 'Dr.' and 'Miss' in the name column.

# In[3]:


#replace the salutation using regular expression. Value is replaced by empty string 
#create a new column "new_name" to hold the value
df['new_name']=df['name'].str.replace(r'^(\s+)?(Mr(\.)?|Mrs(\.)?|Dr(\.)?|Miss?) ', '')

#print top 20 records
print(df.head(20))


# Next, perform the splitting of first name and last name from the new column called new_name.
# It uses the split function and assign to new columns called First_Name and Last_Name.

# In[4]:


#perform the splitting of first name and last name
df_split_name = df["new_name"].str.split(" ", n= -1, expand = True)

#first name column from new data frame 
df["First_Name"] = df_split_name[0]
#last name column from new data frame
df["Last_Name"] = df_split_name[1]

print(df.head(20))


# It follows by formatting the price to remove trailing zero, and I set it to 2 decimal point.

# In[5]:


#Price column formatting
df["New_Price"] = df["price"].round(decimals=2).astype(object)

#print records of last 10
print(df.tail(10))


# Then, create a new column called above_100 and set true if the price is strictly greater than 100.

# In[6]:


#true if the price is strictly greater than 100
df.loc[df['price'] > 100, 'above_100'] = 'True' 

#print top 20 records
print(df.head(20))


# Finally, write the results into csv file that named as dataset_updated.csv without index numbers.

# In[7]:


#write into csv file without the index number
df.to_csv('dataset_updated.csv', index = False)

