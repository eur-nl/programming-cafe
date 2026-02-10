# Clean your data efficiently using Python


Everyone has seen messy data before, extras spaces, symbols mixed with numbers, inconsistent spelling or data formats. All of these examples make the analysis of data more difficult.

The data in itself is not "bad" data, but just not ready for analyses yet!

In today's session, I want to help you show how you can check whether your data is "messy" and how to get it ready for your analysis.

You may now wonder "Why should I clean my data? Can't I just analyse the messy data?". There are multiple answers to this, but in general, messy data (in general) can lead to wrong results, make your analysis slower, increases your chance of mistakes and a lot harder to reproduce. If “Amsterdam”, for example, appears in three different spellings in your data, your analysis might think you have three cities instead of one.

Let's learn together, how to spot messy data, how to fix it and
how to log the changes so everything is transparent and reproducible!

Before we begin, I want to show you [an example of messy data](https://github.com/eyowhite/Messy-dataset)! Let's have a look at the data, open the file and try to spot some irregularities together. I want you to think of issues such as **unwanted characters**, **inconsistent spelling**, **mixed data types**, **extra whitespace**, **duplicate rows** and **missing values**.

You can download the data **[here](extras/messy_HR_data.csv.zip)** and find the jupyter notebook **[here](extras/DataCleaning.ipynb)**

While we did the first examination with our own eyes, we can also use pandas (the python package) to inspect the data.


```python
# First, let's import pandas (or install if you have not installed it yet)
import pandas
```


```python
# Let's read the csv file
df = pandas.read_csv("messy_HR_data.csv")
```


```python
# Look at the first five rows
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Name</th>
      <th>Age</th>
      <th>Salary</th>
      <th>Gender</th>
      <th>Department</th>
      <th>Position</th>
      <th>Joining Date</th>
      <th>Performance Score</th>
      <th>Email</th>
      <th>Phone Number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>grace</td>
      <td>25</td>
      <td>50000</td>
      <td>Male</td>
      <td>HR</td>
      <td>Manager</td>
      <td>April 5, 2018</td>
      <td>D</td>
      <td>email@example.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>david</td>
      <td>NaN</td>
      <td>65000</td>
      <td>Female</td>
      <td>Finance</td>
      <td>Director</td>
      <td>2020/02/20</td>
      <td>F</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
    <tr>
      <th>2</th>
      <td>hannah</td>
      <td>35</td>
      <td>SIXTY THOUSAND</td>
      <td>Female</td>
      <td>Sales</td>
      <td>Director</td>
      <td>01/15/2020</td>
      <td>C</td>
      <td>email@example.com</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>3</th>
      <td>eve</td>
      <td>NaN</td>
      <td>50000</td>
      <td>Female</td>
      <td>IT</td>
      <td>Manager</td>
      <td>April 5, 2018</td>
      <td>A</td>
      <td>name@company.org</td>
      <td></td>
    </tr>
    <tr>
      <th>4</th>
      <td>grace</td>
      <td>NaN</td>
      <td>NAN</td>
      <td>Female</td>
      <td>Finance</td>
      <td>Manager</td>
      <td>01/15/2020</td>
      <td>F</td>
      <td>name@company.org</td>
      <td>098-765-4321</td>
    </tr>
  </tbody>
</table>
</div>




```python
# And the general information
df.info()
```

    <class 'pandas.DataFrame'>
    RangeIndex: 1000 entries, 0 to 999
    Data columns (total 10 columns):
     #   Column             Non-Null Count  Dtype
    ---  ------             --------------  -----
     0   Name               1000 non-null   str  
     1   Age                841 non-null    str  
     2   Salary             1000 non-null   str  
     3   Gender             1000 non-null   str  
     4   Department         1000 non-null   str  
     5   Position           1000 non-null   str  
     6   Joining Date       1000 non-null   str  
     7   Performance Score  1000 non-null   str  
     8   Email              610 non-null    str  
     9   Phone Number       815 non-null    str  
    dtypes: str(10)
    memory usage: 78.3 KB


I

Do you see the first problem already? Some columns do not have 1000 rows, but 841 (Age), 610 (Email) and 815 (Phone number instead). Let's remember this and fix it later.


```python
# Let's have a look at the summary of the data
df.describe(include="all")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Name</th>
      <th>Age</th>
      <th>Salary</th>
      <th>Gender</th>
      <th>Department</th>
      <th>Position</th>
      <th>Joining Date</th>
      <th>Performance Score</th>
      <th>Email</th>
      <th>Phone Number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1000</td>
      <td>841</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>610</td>
      <td>815</td>
    </tr>
    <tr>
      <th>unique</th>
      <td>10</td>
      <td>5</td>
      <td>6</td>
      <td>3</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>3</td>
      <td>4</td>
    </tr>
    <tr>
      <th>top</th>
      <td>alice</td>
      <td>thirty</td>
      <td>65000</td>
      <td>Male</td>
      <td>Finance</td>
      <td>Assistant</td>
      <td>2020/02/20</td>
      <td>B</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
    <tr>
      <th>freq</th>
      <td>118</td>
      <td>176</td>
      <td>184</td>
      <td>355</td>
      <td>218</td>
      <td>214</td>
      <td>232</td>
      <td>225</td>
      <td>213</td>
      <td>236</td>
    </tr>
  </tbody>
</table>
</div>



This overview gives us another hint. Now, of course our file only is an example, but you may wonder (in real data) why a phone number is used 236 times.


```python
# Let's have a look at the unique values of each column and check whether we find something there
df.Name.unique()
```




    <StringArray>
    [  ' grace ',   ' david ',  ' hannah ',     ' eve ',    ' jack ', ' charlie ',
       ' frank ',     ' bob ',   ' alice ',     ' ivy ']
    Length: 10, dtype: str



The names look normal to me, but if we look closer, we can see that there are whitespaces around the names. Is that needed? I do not think so! Let's delete them.

# WAIT! Logging?

We just wanted to start deleting, however, we want to keep track of everthing. For that I want to write a small function that we can reuse.



```python
import datetime

def log_change(description):
    with open("log_file.txt", mode = 'a', encoding = 'utf-8') as log_file:
        print(description, datetime.datetime.now(), sep = '\t', file = log_file)

log_change("Started process!")
```

Back to deleting whitespace!

## Deleting Whitespace


```python
# We can do that using strip()
df.Name = df.Name.str.strip()
log_change("Deleted whitespace in column Name")
```


```python
df.Name.unique()
```




    <StringArray>
    [  'grace',   'david',  'hannah',     'eve',    'jack', 'charlie',   'frank',
         'bob',   'alice',     'ivy']
    Length: 10, dtype: str



df.Name.str.strip() removes extra whitespace from the beginning and end of each string. We use `str` to say that this method should be used to every value in the column.

Since we looked at names, we may also want to have then capitalized, right?

## Manipulate cases

We can do that using str.capitalize().
In a similar manner, we can use lowercase, uppercase or different settings:
- str.lower(): Converts all characters to lowercase.
- str.upper(): Converts all characters to uppercase.
- str.title(): Converts first character of each word to uppercase and remaining to lowercase.
- str.capitalize(): Converts first character to uppercase and remaining to lowercase.
- str.swapcase(): Converts uppercase to lowercase and lowercase to uppercase.


```python
df.Name = df.Name.str.capitalize()
log_change("Capitalized strings in column Name")
```

Let's have a look at the age next...


```python
df.Age.unique()
```




    <StringArray>
    ['25', nan, '35', '40', 'thirty', '50']
    Length: 6, dtype: str



It seems that age is sometimes written out as a string "thirty" and sometimes saved as a number.

## Replacing values

If there are only some instances, it may be handy to just replace the string with a number.


```python
df.Age = df.Age.replace("thirty", "30")
log_change("Replacing thirty with 30 in column Age")
```


```python
df.Age.unique()
```




    <StringArray>
    ['25', nan, '35', '40', '30', '50']
    Length: 6, dtype: str




```python
# We can also ask pandas to convert all values to numbers and everything that is not a number, to NA
# ‘coerce’ means that invalid parsing will be set as NaN.
df.Age = pandas.to_numeric(df.Age, downcast="integer", errors="coerce")
log_change("Converting Age to numeric")

```


```python
df.Age.unique()
```




    array([25., nan, 35., 40., 30., 50.])



Let's check whether we find a similar problem in the Salary.


```python
df.Salary.unique()
```




    <StringArray>
    ['50000', '65000', 'SIXTY THOUSAND', ' NAN ', '70000', '55000']
    Length: 6, dtype: str




```python
# Let's replace SIXTY THOUSAND by the number
df.Salary = df.Salary.replace("SIXTY THOUSAND", "60000")
log_change("Replace SIXTY THOUSAND with 60000 in column Salary")

# And tell pandas that we have numerics here
df.Salary = pandas.to_numeric(df.Salary, downcast="integer",errors="coerce")
log_change("Converting Salary to numeric")

df.Salary.unique()
```




    array([50000., 65000., 60000.,    nan, 70000., 55000.])



Let's have a short look at Gender...


```python
df.Gender.unique()
```




    <StringArray>
    ['Male', 'Female', 'Other']
    Length: 3, dtype: str



Ok! Looks good to me! But we may want to change it to "m", "f" and "d"?
For that, we could create a so-called mapping. We create a dictionary that contains the words that are currently in the dataset as keys and the words that we want to use as values. With this, we can also standardize the spelling!


```python
gender_mapping = {'Male': 'm', 'Female': 'f', 'Other':'d'}
# Important: To use this function, you need the newest version of pandas (3.0) which may require to update your Python instance
df.Gender = df.Gender.str.replace(gender_mapping)
log_change("Replace Male, Female and Other with f,m and d in column Gender")

```


```python
df.Gender
```




    0      m
    1      f
    2      f
    3      f
    4      f
          ..
    995    f
    996    m
    997    m
    998    d
    999    m
    Name: Gender, Length: 1000, dtype: str



I did not find any problems in the Department and Position column, however, I do not like that the columns "Joining Date", "Performance Score" and "Phone Number" use two words! That may make the work with them more difficult as we have to use a different approach (`df['Joining Date']` instead of `df.joining_date`).

## Renaming columns

Let's rename them!


```python
df = df.rename(columns={"Joining Date": "Joining_Date", "Performance Score": "Performance_Score", "Phone Number": "Phone_Number"})
log_change("Renaming Column Joining Date, Performance Score and Phone Number to Joining_Date, Performance_Score and Phone_Number")

```

# Missing values and using na

While having a first look at our data, we have seen that Age, Salary, Email and Phone Number, were not fully filled and contained empty cells. We also saw that "NaN" has not been used for non-existing values all the time. Let's unify that!


```python
# First we want to replace empty cells with a NA value
df = df.replace("", pandas.NA)
log_change("Filling all empty cells with NA")

```


```python
# We can also decide to name our "NA" different, but NaN works best with pandas. Let's unify it for every column
df = df.fillna(pandas.NA)
log_change("Unify NAs to pandas NA")
```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Name</th>
      <th>Age</th>
      <th>Salary</th>
      <th>Gender</th>
      <th>Department</th>
      <th>Position</th>
      <th>Joining_Date</th>
      <th>Performance_Score</th>
      <th>Email</th>
      <th>Phone_Number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Grace</td>
      <td>25.0</td>
      <td>50000.0</td>
      <td>m</td>
      <td>HR</td>
      <td>Manager</td>
      <td>April 5, 2018</td>
      <td>D</td>
      <td>email@example.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>David</td>
      <td>NaN</td>
      <td>65000.0</td>
      <td>f</td>
      <td>Finance</td>
      <td>Director</td>
      <td>2020/02/20</td>
      <td>F</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Hannah</td>
      <td>35.0</td>
      <td>60000.0</td>
      <td>f</td>
      <td>Sales</td>
      <td>Director</td>
      <td>01/15/2020</td>
      <td>C</td>
      <td>email@example.com</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Eve</td>
      <td>NaN</td>
      <td>50000.0</td>
      <td>f</td>
      <td>IT</td>
      <td>Manager</td>
      <td>April 5, 2018</td>
      <td>A</td>
      <td>name@company.org</td>
      <td></td>
    </tr>
    <tr>
      <th>4</th>
      <td>Grace</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>f</td>
      <td>Finance</td>
      <td>Manager</td>
      <td>01/15/2020</td>
      <td>F</td>
      <td>name@company.org</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>Jack</td>
      <td>50.0</td>
      <td>65000.0</td>
      <td>f</td>
      <td>HR</td>
      <td>Manager</td>
      <td>2020/02/20</td>
      <td>F</td>
      <td>NaN</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>996</th>
      <td>Jack</td>
      <td>30.0</td>
      <td>50000.0</td>
      <td>m</td>
      <td>Finance</td>
      <td>Analyst</td>
      <td>April 5, 2018</td>
      <td>C</td>
      <td>NaN</td>
      <td>555-555-5555</td>
    </tr>
    <tr>
      <th>997</th>
      <td>Hannah</td>
      <td>30.0</td>
      <td>70000.0</td>
      <td>m</td>
      <td>IT</td>
      <td>Assistant</td>
      <td>01/15/2020</td>
      <td>D</td>
      <td>user@domain.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>998</th>
      <td>Bob</td>
      <td>25.0</td>
      <td>65000.0</td>
      <td>d</td>
      <td>Marketing</td>
      <td>Manager</td>
      <td>April 5, 2018</td>
      <td>D</td>
      <td>email@example.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>999</th>
      <td>Ivy</td>
      <td>30.0</td>
      <td>60000.0</td>
      <td>m</td>
      <td>Finance</td>
      <td>Manager</td>
      <td>2020/02/20</td>
      <td>C</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 10 columns</p>
</div>



# Unifying time stamps

You may have guessed it already, but the last aspect that we want to clean are the different time stamps. The dataset contains formats such as month, day year and year/month/day as well as month/day/year.

Let's unify that using pandas. A possible approach would be `df.Joining_Date = pandas.to_datetime(df.Joining_Date, errors="coerce")`. However, since our data is a bit more complex, we may have to adapt to different formats.


```python
def parse_date(date):
    """Function that takes the date and time and tries out to parse it using every possible format"""
    for format in ["%B %d, %Y", "%Y/%m/%d","%m/%d/%Y", "%m-%d-%Y", "%Y.%m.%d"]:
        try:
            return pandas.to_datetime(date, format=format)
        except:
            pass
    return pandas.NaT

# Call the function
df.Joining_Date = df.Joining_Date.apply(parse_date)
log_change("Unifying time stamps in column Joining_Date")


```


```python
# Unify it to a human-readable version
df.Joining_Date = df.Joining_Date.dt.strftime("%Y-%m-%d")
log_change("Converting time stamps to %Y-%m-%d in column Joining_Date")
```


```python
# Let's have a final look at our data set! It looks so much cleaner!
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Name</th>
      <th>Age</th>
      <th>Salary</th>
      <th>Gender</th>
      <th>Department</th>
      <th>Position</th>
      <th>Joining_Date</th>
      <th>Performance_Score</th>
      <th>Email</th>
      <th>Phone_Number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Grace</td>
      <td>25.0</td>
      <td>50000.0</td>
      <td>m</td>
      <td>HR</td>
      <td>Manager</td>
      <td>2018-04-05</td>
      <td>D</td>
      <td>email@example.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>David</td>
      <td>NaN</td>
      <td>65000.0</td>
      <td>f</td>
      <td>Finance</td>
      <td>Director</td>
      <td>2020-02-20</td>
      <td>F</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Hannah</td>
      <td>35.0</td>
      <td>60000.0</td>
      <td>f</td>
      <td>Sales</td>
      <td>Director</td>
      <td>2020-01-15</td>
      <td>C</td>
      <td>email@example.com</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Eve</td>
      <td>NaN</td>
      <td>50000.0</td>
      <td>f</td>
      <td>IT</td>
      <td>Manager</td>
      <td>2018-04-05</td>
      <td>A</td>
      <td>name@company.org</td>
      <td></td>
    </tr>
    <tr>
      <th>4</th>
      <td>Grace</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>f</td>
      <td>Finance</td>
      <td>Manager</td>
      <td>2020-01-15</td>
      <td>F</td>
      <td>name@company.org</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>Jack</td>
      <td>50.0</td>
      <td>65000.0</td>
      <td>f</td>
      <td>HR</td>
      <td>Manager</td>
      <td>2020-02-20</td>
      <td>F</td>
      <td>NaN</td>
      <td>098-765-4321</td>
    </tr>
    <tr>
      <th>996</th>
      <td>Jack</td>
      <td>30.0</td>
      <td>50000.0</td>
      <td>m</td>
      <td>Finance</td>
      <td>Analyst</td>
      <td>2018-04-05</td>
      <td>C</td>
      <td>NaN</td>
      <td>555-555-5555</td>
    </tr>
    <tr>
      <th>997</th>
      <td>Hannah</td>
      <td>30.0</td>
      <td>70000.0</td>
      <td>m</td>
      <td>IT</td>
      <td>Assistant</td>
      <td>2020-01-15</td>
      <td>D</td>
      <td>user@domain.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>998</th>
      <td>Bob</td>
      <td>25.0</td>
      <td>65000.0</td>
      <td>d</td>
      <td>Marketing</td>
      <td>Manager</td>
      <td>2018-04-05</td>
      <td>D</td>
      <td>email@example.com</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>999</th>
      <td>Ivy</td>
      <td>30.0</td>
      <td>60000.0</td>
      <td>m</td>
      <td>Finance</td>
      <td>Manager</td>
      <td>2020-02-20</td>
      <td>C</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 10 columns</p>
</div>




```python
# Now we can start doing some statistics!
df.describe(include="all")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Name</th>
      <th>Age</th>
      <th>Salary</th>
      <th>Gender</th>
      <th>Department</th>
      <th>Position</th>
      <th>Joining_Date</th>
      <th>Performance_Score</th>
      <th>Email</th>
      <th>Phone_Number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1000</td>
      <td>841.000000</td>
      <td>833.000000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>610</td>
      <td>815</td>
    </tr>
    <tr>
      <th>unique</th>
      <td>10</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>3</td>
      <td>4</td>
    </tr>
    <tr>
      <th>top</th>
      <td>Alice</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>m</td>
      <td>Finance</td>
      <td>Assistant</td>
      <td>2020-02-20</td>
      <td>B</td>
      <td>user@domain.com</td>
      <td>123-456-7890</td>
    </tr>
    <tr>
      <th>freq</th>
      <td>118</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>355</td>
      <td>218</td>
      <td>214</td>
      <td>232</td>
      <td>225</td>
      <td>213</td>
      <td>236</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>NaN</td>
      <td>35.802616</td>
      <td>60216.086435</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>std</th>
      <td>NaN</td>
      <td>8.551889</td>
      <td>7127.032811</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>min</th>
      <td>NaN</td>
      <td>25.000000</td>
      <td>50000.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>NaN</td>
      <td>30.000000</td>
      <td>55000.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>NaN</td>
      <td>35.000000</td>
      <td>60000.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>NaN</td>
      <td>40.000000</td>
      <td>65000.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>max</th>
      <td>NaN</td>
      <td>50.000000</td>
      <td>70000.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
# And we can save the results in a file
df.to_csv("new_file.csv", index = False, na_rep = "NaN")
```
