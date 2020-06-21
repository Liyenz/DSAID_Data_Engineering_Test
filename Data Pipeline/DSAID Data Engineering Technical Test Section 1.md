This is the document for the DSAID Data Engineering Technical Test - Section 1.
The objective of this section is to design and implement a solution to process a data file on a regular interval (e.g. 1am  daily). Given the test data file dataset.csv,  the expected output of the processing task is a CSV file including a header containing the field names. 

Processing tasks:

Split the name field into first_name, and last_name
Remove any zeros prepended to the price field
Delete any rows which do not have a name
Create a new field named above_100, which is true if the price is strictly greater than 100

The code is written in Python.

Read dataset.csv file into Pandas Dataframe


```python
#import pandas
import pandas as pd

#declare a variable to hold URL
filename = 'dataset.csv'

#read dataset.csv file into a dataframe
df = pd.read_csv(filename, sep=',')

#print top 5 records
print(df.head())
print(df.info())
```

                 name       price
    0   William Dixon  109.037280
    1    Kristen Horn  262.524652
    2  Kimberly Chang  187.007258
    3       Mary Ball  283.174648
    4  Benjamin Craig  143.871582
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 10000 entries, 0 to 9999
    Data columns (total 2 columns):
     #   Column  Non-Null Count  Dtype  
    ---  ------  --------------  -----  
     0   name    10000 non-null  object 
     1   price   10000 non-null  float64
    dtypes: float64(1), object(1)
    memory usage: 156.4+ KB
    None


Based on above information, there should not be any rows that do not have name because of non-null columns.


```python
#Check if any null to confirm
df.isnull().sum()

#remove rows based on the missing values
#df.dropna(subset=['name'], inplace=True)
```




    name     0
    price    0
    dtype: int64



The name column contains salutation. It needs to be removed before splitting the name column into first_name and last_name.
It is using the regular expression to perform the search and replace of the string in the name column.
Assumed that the salutation includes 'Mr.', 'Mrs.', 'Dr.' and 'Miss' in the name column.


```python
#replace the salutation using regular expression. Value is replaced by empty string 
#create a new column "new_name" to hold the value
df['new_name']=df['name'].str.replace(r'^(\s+)?(Mr(\.)?|Mrs(\.)?|Dr(\.)?|Miss?) ', '')

#print top 20 records
print(df.head(20))
```

                      name       price            new_name
    0        William Dixon  109.037280       William Dixon
    1         Kristen Horn  262.524652        Kristen Horn
    2       Kimberly Chang  187.007258      Kimberly Chang
    3            Mary Ball  283.174648           Mary Ball
    4       Benjamin Craig  143.871582      Benjamin Craig
    5         Cathy Werner   61.508991        Cathy Werner
    6         Brandon Bell   48.637309        Brandon Bell
    7          Paul Farley   12.389465         Paul Farley
    8       Sarah Mcdaniel  151.595447      Sarah Mcdaniel
    9    Caroline Anderson   75.621521   Caroline Anderson
    10          Carl Jones  147.029405          Carl Jones
    11           Scott Lee  244.185653           Scott Lee
    12      Kaylee Coleman   17.864270      Kaylee Coleman
    13      Charles Parker  215.537283      Charles Parker
    14          Susan Hess   38.359971          Susan Hess
    15       Kiara Collier  204.182549       Kiara Collier
    16  Mr. Scott Martinez  165.851429      Scott Martinez
    17  Christopher Ortega   30.301445  Christopher Ortega
    18     Michael Russell  243.172491     Michael Russell
    19      Dwayne Johnson  287.493286      Dwayne Johnson


Next, perform the splitting of first name and last name from the new column called new_name.
It uses the split function and assign to new columns called First_Name and Last_Name.


```python
#perform the splitting of first name and last name
df_split_name = df["new_name"].str.split(" ", n= -1, expand = True)

#first name column from new data frame 
df["First_Name"] = df_split_name[0]
#last name column from new data frame
df["Last_Name"] = df_split_name[1]

print(df.head(20))
```

                      name       price            new_name   First_Name Last_Name
    0        William Dixon  109.037280       William Dixon      William     Dixon
    1         Kristen Horn  262.524652        Kristen Horn      Kristen      Horn
    2       Kimberly Chang  187.007258      Kimberly Chang     Kimberly     Chang
    3            Mary Ball  283.174648           Mary Ball         Mary      Ball
    4       Benjamin Craig  143.871582      Benjamin Craig     Benjamin     Craig
    5         Cathy Werner   61.508991        Cathy Werner        Cathy    Werner
    6         Brandon Bell   48.637309        Brandon Bell      Brandon      Bell
    7          Paul Farley   12.389465         Paul Farley         Paul    Farley
    8       Sarah Mcdaniel  151.595447      Sarah Mcdaniel        Sarah  Mcdaniel
    9    Caroline Anderson   75.621521   Caroline Anderson     Caroline  Anderson
    10          Carl Jones  147.029405          Carl Jones         Carl     Jones
    11           Scott Lee  244.185653           Scott Lee        Scott       Lee
    12      Kaylee Coleman   17.864270      Kaylee Coleman       Kaylee   Coleman
    13      Charles Parker  215.537283      Charles Parker      Charles    Parker
    14          Susan Hess   38.359971          Susan Hess        Susan      Hess
    15       Kiara Collier  204.182549       Kiara Collier        Kiara   Collier
    16  Mr. Scott Martinez  165.851429      Scott Martinez        Scott  Martinez
    17  Christopher Ortega   30.301445  Christopher Ortega  Christopher    Ortega
    18     Michael Russell  243.172491     Michael Russell      Michael   Russell
    19      Dwayne Johnson  287.493286      Dwayne Johnson       Dwayne   Johnson


It follows by formatting the price to remove trailing zero, and I set it to 2 decimal point.


```python
#Price column formatting
df["New_Price"] = df["price"].round(decimals=2).astype(object)

#print records of last 10
print(df.tail(10))
```

                       name       price           new_name First_Name  Last_Name  \
    9990    Diane Harvey MD   27.640146    Diane Harvey MD      Diane     Harvey   
    9991          Tara Hall  255.052560          Tara Hall       Tara       Hall   
    9992        Margaret Li  206.228958        Margaret Li   Margaret         Li   
    9993        Anne Robles  145.488260        Anne Robles       Anne     Robles   
    9994  Elizabeth Carlson  280.256686  Elizabeth Carlson  Elizabeth    Carlson   
    9995       Rachel Davis   95.253955       Rachel Davis     Rachel      Davis   
    9996    Connie Hamilton  205.396685    Connie Hamilton     Connie   Hamilton   
    9997        Sean Kaiser   80.547371        Sean Kaiser       Sean     Kaiser   
    9998    Ebony Rodriguez   93.205616    Ebony Rodriguez      Ebony  Rodriguez   
    9999    Gregg Alexander  297.046886    Gregg Alexander      Gregg  Alexander   
    
         New_Price  
    9990     27.64  
    9991    255.05  
    9992    206.23  
    9993    145.49  
    9994    280.26  
    9995     95.25  
    9996     205.4  
    9997     80.55  
    9998     93.21  
    9999    297.05  


Then, create a new column called above_100 and set true if the price is strictly greater than 100.


```python
#true if the price is strictly greater than 100
df.loc[df['price'] > 100, 'above_100'] = 'True' 

#print top 20 records
print(df.head(20))

```

                      name       price            new_name   First_Name Last_Name  \
    0        William Dixon  109.037280       William Dixon      William     Dixon   
    1         Kristen Horn  262.524652        Kristen Horn      Kristen      Horn   
    2       Kimberly Chang  187.007258      Kimberly Chang     Kimberly     Chang   
    3            Mary Ball  283.174648           Mary Ball         Mary      Ball   
    4       Benjamin Craig  143.871582      Benjamin Craig     Benjamin     Craig   
    5         Cathy Werner   61.508991        Cathy Werner        Cathy    Werner   
    6         Brandon Bell   48.637309        Brandon Bell      Brandon      Bell   
    7          Paul Farley   12.389465         Paul Farley         Paul    Farley   
    8       Sarah Mcdaniel  151.595447      Sarah Mcdaniel        Sarah  Mcdaniel   
    9    Caroline Anderson   75.621521   Caroline Anderson     Caroline  Anderson   
    10          Carl Jones  147.029405          Carl Jones         Carl     Jones   
    11           Scott Lee  244.185653           Scott Lee        Scott       Lee   
    12      Kaylee Coleman   17.864270      Kaylee Coleman       Kaylee   Coleman   
    13      Charles Parker  215.537283      Charles Parker      Charles    Parker   
    14          Susan Hess   38.359971          Susan Hess        Susan      Hess   
    15       Kiara Collier  204.182549       Kiara Collier        Kiara   Collier   
    16  Mr. Scott Martinez  165.851429      Scott Martinez        Scott  Martinez   
    17  Christopher Ortega   30.301445  Christopher Ortega  Christopher    Ortega   
    18     Michael Russell  243.172491     Michael Russell      Michael   Russell   
    19      Dwayne Johnson  287.493286      Dwayne Johnson       Dwayne   Johnson   
    
       New_Price above_100  
    0     109.04      True  
    1     262.52      True  
    2     187.01      True  
    3     283.17      True  
    4     143.87      True  
    5      61.51       NaN  
    6      48.64       NaN  
    7      12.39       NaN  
    8      151.6      True  
    9      75.62       NaN  
    10    147.03      True  
    11    244.19      True  
    12     17.86       NaN  
    13    215.54      True  
    14     38.36       NaN  
    15    204.18      True  
    16    165.85      True  
    17      30.3       NaN  
    18    243.17      True  
    19    287.49      True  


Finally, write the results into csv file that named as dataset_updated.csv without index numbers.


```python
#write into csv file without the index number
df.to_csv('dataset_updated.csv', index = False)
```

Creating and setting up a cron job. 

Convert the notebook (ipynb file) into a .py file using the following script in the command line window,
jupyter nbconvert --to script DSAID_Data_Engineering_Technical_Test_Section_1.ipynb

It generates a .py file in the same directory.
Set up the cron job to run the new .py from the root account at 1.00 AM daily. 


```python
#import package
from crontab import CronTab

#access cron is by using the root account
cron = CronTab(user='root')

#set the python file to run
job = cron.new(command='DSAID_Data_Engineering_Technical_Test_Section_1.py')

#at 0 minute
job.minute.every(0)
#at 1.00AM
job.hour.also.on(1)
cron.write()
```
