# -*- coding: utf-8 -*-
"""
Created on Sat May 15 13:08:09 2021

@author: Zachary Palmore
"""

# -*- coding: utf-8 -*-
"""
Created on Sun Mar 21 15:46:26 2021

@author: Zachary Palmore
"""

# Datacamp Intro to Python Practice 

import numpy as np
np.array([6, 2, 4]) + np.array([5, 1, 3])

# results in:
# array([11,  3,  7])

import numpy as np
np.array([6, 2, 4]) * np.array([5, 1, 3])
# results in:
# array([11,  3,  7])

import numpy as np
np.array([6, 2, 4]) - np.array([5, 1, 3])

# results in:
# array([1,  1,  1])

import numpy as np
np.array([6, 2, 4]) / np.array([5, 1, 3])
# results in:
# array([1.2       , 2.        , 1.33333333])

# What operator in the following equation 
# print("6" ? (2 ** 2))
#would produce the vector; 6666

print("6" * (2 ** 2))
# Results in 6666

# Complete the code 
# import numpy as np
# numbers = [[50, 3],[21, 15],[32, 80]]
# np_array = np.array(numbers)
# print(np_array. ? )
# to return the output; 
# (3, 2)

import numpy as np
numbers = [[50, 3],[21, 15],[32, 80]]
np_array = np.array(numbers)
print(np_array.size)

# AttributeError: 'numpy.ndarray' object has no attribute 'dim'
# AttributeError: 'numpy.ndarray' object has no attribute 'len'
# Attribute size = 6 (there are 6 values)

# What is the output of this code? 

p = "23"
print(type(p))

# What is the output of the following code? 

x = [11, 12, 13, 14]
y = x
y[2:4] = [15, 16]
print(x)

# Which code invokes the method x() of the object p? 

# p.x() is correct if object x was corrected
p.x()
# Results
# AttributeError: 'str' object has no attribute 'x'

x().p
# Results 
# TypeError: 'list' object is not callable

p$x()
# Results 
# SyntaxError: invalid syntax

x(p)
# Results
# TypeError: 'list' object is not callable

# You have the following data frame: 
#  Month  Count
# 0   Jan     52
# 1   Apr     29
# 2   Mar     46
# 3   Feb      3

# Select the code to return the output: 
#  Month  Count
# 0   Jan     52

print(df.loc[df['Month'] == 'Jan'])

# Complete the code to return the output: 
# get the standard devation of 'Count'
# print(df['Count'] ? )

print(df['Count'].std())

# Complete the code to return the output:
#           Country  Total
# 0   United States   1118
# 1    Soviet Union    473
# 2  United Kingdom    273
    
import pandas as pd
list_keys = ['Country', 'Total']
list_values = [['United States', 'Soviet Union', 'United Kingdom'], [1118, 473, 273]]

zipped = list(zip(list_keys, list_values))
data = dict(zipped)
df = pd.DataFrame(data)
print(df.head())

# returns;
#           Country  Total
# 0   United States   1118
# 1    Soviet Union    473
# 2  United Kingdom    273

zipped = zip(dict(list_keys, list_values))
data = list(zipped)
df = pd.DataFrame(data)
print(df.head())

# returns;
# TypeError: dict expected at most 1 argument, got 2

zipped = zip(list(list_keys, list_values))
data = dict(zipped)
df = pd.DataFrame(data)
print(df.head())

# returns;
# TypeError: list expected at most 1 argument, got 2

zipped = list(dict(list_keys, list_values))
data = zip(zipped)
df = pd.DataFrame(data)
print(df.head())

# returns; 
# TypeError: dict expected at most 1 argument, got 2

zipped = dict(list(list_keys, list_values))
data = zip(zipped)
df = pd.DataFrame(data)
print(df.head())

# returns;
# TypeError: list expected at most 1 argument, got 2

# Which of the following methods will generate summary statistics exlcuding NaN values? 
# .summary()
# .describe()
# .info()
# .stats() 

# results without NaN for summary stats
.describe()


# Complete the code to return the output
# DatetimeIndex(['2013-01-01 09:12:34', '2013-01-01 09:12:34'], dtype='datetime64[ns]', freq=None)

l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.to_datetime(l)))

# results;
# TypeError: an integer is required (got type list)

l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.datetime(l)))

# results;
# DatetimeIndex(['2013-01-01 09:12:34', '2013-01-01 09:12:34'], dtype='datetime64[ns]', freq=None)

l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.date(l)))

# results; 
# AttributeError: module 'pandas' has no attribute 'date'

l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.time(l)))

# results; 
# AttributeError: module 'pandas' has no attribute 'time'

l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.todatetime(l)))

# results; 
# AttributeError: module 'pandas' has no attribute 'todatetime'

# Return the functions found within the pandas package
import pandas as pd
dir(pd)

# Which of these will return an error?
True + "r"
# returns error;
# TypeError: unsupported operand type(s) for +: 'bool' and 'str'

bool(5) + 7
# returns 8

"python" + "data"
# returns "pythondata"

6 + 6.5 
# returns 12.5

# Select the code to return the output
# [3, 13, 11]

x = [18, 8, 3, 13, 11, 9, 7]
print(x[2:5])
# returns;
# [3, 13, 11]

x = [18, 8, 3, 13, 11, 9, 7]
print(x[0:5])
# returns;
# [18, 8, 3, 13, 11]

x = [18, 8, 3, 13, 11, 9, 7]
print(x[0:6])
# returns;
# [18, 8, 3, 13, 11, 9]

# Complete the code to return the output 
# 1.55
# import numpy as np
# np_heights = np.array([[1.60,1.75],[1.56,1.70],[1.49,1.68]])
# print(np. ? (np_heights[:,0]))

import numpy as np
np_heights = np.array([[1.60,1.75],[1.56,1.70],[1.49,1.68]]) 
print(np.mean(np_heights[:,0]))
# returns; 
# 1.55

# Complete the code to return the output
# Jan
# Jun
# Dec
# Mar
# x = ['Jan', 'Jun', 'Dec', 'Mar']
# for month in ?: 
#    print(month)

x = ['Jan', 'Jun', 'Dec', 'Mar']
for month in x:
    print(month)
# returns;
# Jan
# Jun
# Dec
# Mar

# Complete the code to return the output
# {'course': 'sql', 'level': 'intermediate', 'lesson': {'dictionaries': 'python', 'lists': 'r'}}
# datacamp[ ? ] = 'sql'
# print(datacamp)

# Here is the datacamp dictionary
# datacamp = { 'course':'python', 'level':'intermediate', 'lesson': {'dictionaries':'python', 'lists':'r' } }

datacamp = { 'course':'python', 'level':'intermediate', 'lesson': {'dictionaries':'python', 'lists':'r' } }
datacamp['course'] = 'sql'
print(datacamp)
# returns;
# {'course': 'sql', 'level': 'intermediate', 'lesson': {'dictionaries': 'python', 'lists': 'r'}}

datacamp = { 'course':'python', 'level':'intermediate', 'lesson': {'dictionaries':'python', 'lists':'r' } }
datacamp['lists'] = 'sql'
print(datacamp)
# return; 
# {'course': 'python', 'level': 'intermediate', 'lesson': {'dictionaries': 'python', 'lists': 'r'}, 'lists': 'sql'}

datacamp = { 'course':'python', 'level':'intermediate', 'lesson': {'dictionaries':'python', 'lists':'r' } }
datacamp['lesson'] = 'sql'
print(datacamp)
# return; 
# {'course': 'python', 'level': 'intermediate', 'lesson': 'sql'}

datacamp = { 'course':'python', 'level':'intermediate', 'lesson': {'dictionaries':'python', 'lists':'r' } }
datacamp['dictionaries'] = 'sql'
print(datacamp)
# returns; 
# {'course': 'python', 'level': 'intermediate', 'lesson': {'dictionaries': 'python', 'lists': 'r'}, 'dictionaries': 'sql'}

# Complete the code to return the output
# 1 
# 2
# 3
# 4
# array([[1, 2],
#        [3, 4]])
# for val in np. ? (np_array):
#  print(val)

import numpy as np
np_array = np.array([[1, 2],
                     [3, 4]])


for val in np.nditer (np_array):
    print(val)
# returns; 
# 1 
# 2
# 3
# 4

for val in np.enumerate (np_array):
    print(val)
# returns; 
# AttributeError: module 'numpy' has no attribute 'enumerate'

for val in np.items (np_array):
    print(val)
# returns; 
# AttributeError: module 'numpy' has no attribute 'items'


for val in np.diter (np_array):
    print(val)
# returns; 
# AttributeError: module 'numpy' has no attribute 'diter'

# Complete the code to return the output
# python practice has 100 items
# r practice has 30 items
# sql practice has 10 items
# practice = {'python': 100, "r": 30, "sql": 10}
# for course, number in practice.items():
#   print( ? + " practice has " + str( ? ) + " items")

practice = {'python': 100, "r": 30, "sql": 10}
for course, number in practice.items():
   print(course + " practice has " + str(number) + " items")
# returns; 
# python practice has 100 items
# r practice has 30 items
# sql practice has 10 items

# Complete the code to return the output
# DatetimeIndex(['2013-01-01 09:12:34', '2013-01-01 09:12:34'], dtype='datetime64[ns]', freq=None)
# l = ['2013-01-01 091234','2013-01-01 091234']
# print((pd.?(l)))

import pandas as pd
l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.to_datetime(l)))
# returns; 
# DatetimeIndex(['2013-01-01 09:12:34', '2013-01-01 09:12:34'], dtype='datetime64[ns]', freq=None)

# Create a data frame of two columns and four rows using np.array and pd.Dataframe
# print the results
import pandas as pd
import numpy as np  
df = pd.DataFrame(np.array([["Jan", 52], ["Feb", 24], ["Mar", 3], ["Apr", 35]]),
                   columns=['Month', 'Count'])
print(df)

# Select the code to return the output
#   Month  Count
# 0   Jan     52
# For the data frame df 
#   Month  Count
# 0   Jan     52
# 1   Feb     24
# 2   Mar     3 
# 3   Apr     35
import pandas as pd
import numpy as np  
df = pd.DataFrame(np.array([["Jan", 52], ["Feb", 24], ["Mar", 3], ["Apr", 35]]),
                   columns=['Month', 'Count'])
# 'loc' locks in on the part of the df that you want to view
# specify what you want to look in on with df[ colname ] and boolean 
print(df.loc[df['Month'] == 'Jan'])
# returns; 
#   Month  Count
# 0   Jan     52

# Select the code to return the output
#       Month  Count
# three   Feb     24
# For the data frame df 
#   Month  Count
# 0   Jan     52
# 1   Feb     24
# 2   Mar     3 
# 3   Apr     35
import pandas as pd
import numpy as np  
df = pd.DataFrame(np.array([['zero',"Jan", 52], ['one',"Feb", 24], ['two',"Mar", 3], ['three',"Apr", 35]]),
                   columns=['ID', 'Month', 'Count'])

df = del(df[0])
# returns;
# SyntaxError: invalid syntax

df = df.drop(df[0])
# returns; 
# KeyError: 0

# drop the first row
df = df.drop(0)
print(df)
# returns; 
#         Month Count
# 1    one   Feb    24
# 2    two   Mar     3
# 3  three   Apr    35

# 'loc' locks in on the part of the df that you want to view
# specify that you want to see the entire row of the data frame with ':'
print(df.loc['three':])
# returns; 
#         Month  Count
# 0 three   Apr     35

# Drop the first row of the data frame df
import pandas as pd
import numpy as np  
df = pd.DataFrame(np.array([['zero',"Jan", 52], ['one',"Feb", 24], ['two',"Mar", 3], ['three',"Apr", 35]]),
                   columns=['ID', 'Month', 'Count'])

df = del(df[0])
# returns;
# SyntaxError: invalid syntax

df = df.drop(df[0])
# returns; 
# KeyError: 0

# drop the first row
df = df.drop(0)
print(df)
# returns; 
#         Month Count
# 1    one   Feb    24
# 2    two   Mar     3
# 3  three   Apr    35

# What argument would you use to get a data frame as numpy array? 
df = pd.DataFrame(np.array([['zero',"Jan", 52], ['one',"Feb", 24], ['two',"Mar", 3], ['three',"Apr", 35]]),
                   columns=['ID', 'Month', 'Count'])
df.values
# returns; 
# array([['zero', 'Jan', '52'],
#      ['one', 'Feb', '24'],
#      ['two', 'Mar', '3'],
#      ['three', 'Apr', '35']], dtype=object)

# What argument would you use to peek at the top of a data frame? 
df = pd.DataFrame(np.array([['zero',"Jan", 52], ['one',"Feb", 24], ['two',"Mar", 3], ['three',"Apr", 35]]),
                   columns=['ID', 'Month', 'Count'])
df.head()
# returns; 
# first 5 rows of data
# In this case that looks like;  
#       ID Month Count
# 0   zero   Jan    52
# 1    one   Feb    24
# 2    two   Mar     3
# 3  three   Apr    35
# Since there are fewer than 5, it shows all the rows available

import matplotlib.pyplot as plt 
plt.scatter([1,2,3,4], [5,6,7,8])

# What will this return? 
# np.array([True, 1, 2]) + np.array([3, 4, False])

import numpy as np
np.array([True, 1, 2]) + np.array([3, 4, False])
# returns; 
# array([4, 5, 2])

# Complete the code to return the output
# 0 
# print( ? * bool(3.2))

print(False * bool(3.2))
# returns; 
# 0

# Complete the code to return the output 
# <class 'bool'>
# p = ?
# print(type(p))

p = True
print(type(p))
# or
p = False
print(type(p))
# returns; 
# <class 'bool'>

# Complete the code to return the output
# 10
# x = 5
# y = x
# print(x ? y)

x = 5
y = x
print(x + y)

# Reverse the order of the elements
# y = [12, 18, 1, 2]

y = [12, 18, 1, 2]
y.reverse()
print(y)
# returns;
# [2, 1, 18, 12]


# Write code to display the 2nd and 3rd rows of a data frame df 
import pandas as pd
import numpy as np
df = pd.DataFrame(np.array([['zero',"Jan", 52], ['one',"Feb", 24], ['two',"Mar", 3], ['three',"Apr", 35]]),
                   columns=['ID', 'Month', 'Count'])
print(df.iloc[1:3])


# Write code that prints the row of the data frame df where the count is 3
import pandas as pd
import numpy as np
df = pd.DataFrame(np.array([['zero',"Jan", 52], ['one',"Feb", 24], ['two',"Mar", 3], ['three',"Apr", 35]]),
                   columns=['ID', 'Month', 'Count'])
print(df.loc[df['Count'] == 3])

# What is the output of this code? 
# practice = ["Introduction","Python","DataCamp", "R", "SQL", "Data Science"]
# x = -6
# y = -3
# print(practice[x:y])

practice = ["Introduction","Python","DataCamp", "R", "SQL", "Data Science"]
x = -6
y = -3
print(practice[x:y])
# returns; 
# ['Introduction', 'Python', 'DataCamp']

# Complete the code to return the output; 
# (2, 4)
# import numpy as np
# x = np.array([14, 21, 24, 24])
# y = np.array([12, 6, 23, 29])
# z = np.array([x, y])
# print(z.?)

import numpy as np
x = np.array([14, 21, 24, 24])
y = np.array([12, 6, 23, 29])
z = np.array([x, y])
print(z.shape)
# returns; 
# (2, 4) 
# which corresponds to 2 rows and 4 columns as shown in the data frame z 
print(z)

# Write code to return the output
# [1, 0, 2]
x = 1
y = 0
z = 2
print([x,y,z])
# returns; 
# [1, 0, 2]

# Write code to print the help available for the function len()
print(help(len))


# Write code to print the name and surname of an individual using variables name = "Bob" and surname = "Smith"
name = "Bob"
surname = " Smith"
print(name + surname)

# Write code to print the second through the fourth entries of the variable x
x = [1,2,3,4,5]
print(x[1:4])

# What is the output of this code? 
import numpy as np
z = np.array([[5, 9, 8], 
              [9, 0, 6]])
print(z[0:, 1:])
# returns; 
# [[9 8]
#  [0 6]]

# Complete the code to return the output
# 100
# 4 * 5 ** ? 
print(4 * 5 ** 2)
# returns; 
# 100

# What would be the result of running this code on the data frame iris_sample? 
# print(iris_sample.iloc[[0], [1]])
# returns the second column of the first row in iris_sample

# Complete the code to return the output
# array([[ 4, 11],
#       [ 5, 12],
#       [ 6, 13]])
# import numpy as np
# y = np.array([[4, 5, 6],
#              [11, 12, 13]])
# ? (y)
import numpy as np
y = np.array([[4, 5, 6],
             [11, 12, 13]])
np.transpose(y)
# returns; 
# array([[ 4, 11],
#       [ 5, 12],
#       [ 6, 13]])

np.flip(y)
# returns; 
# array([[13, 12, 11],
#       [ 6,  5,  4]])

np.rotate(y)
# returns; 
# AttributeError: module 'numpy' has no attribute 'rotate'

np.reverse(y)
# returns; 
# AttributeError: module 'numpy' has no attribute 'reverse'

# Write code that returns the following based on the two nunmpy arrays named numpy1 and numpy2
# array([ True, False, False, False], dtype=bool)
numpy1 = np.array([17.2, 20.0, 8.25, 9.50])
numpy2 = np.array([13.0, 24.0, 8.25, 9.0])
np.logical_and(numpy1 > 10, numpy2 < 20)
# returns; 
# array([ True, False, False, False])

np.or(numpy1 > 10, numpy2 < 20)
# returns;
# SyntaxError: invalid syntax

np.logical_or(numpy1 > 10, numpy2 < 20)
# returns; 
# array([ True,  True,  True,  True])

np.logical_or(numpy1 > 10, numpy2 < 20)
# returns; 
# array([ True,  True,  True,  True])

np.and(numpy1 > 10, numpy2 < 20)
# returns; 
# SyntaxError: invalid syntax

# Write code to interate through and print the elements of numpy arrays numpy1 and numpy2
import numpy as np 
np_array1 = np.array([1,2,3])
np_array2 = np.array([4,5,6])
np_array = np.array([np_array1, np_array2])

for val in np.nditer(np_array):
    print(val)

# What does this code do?  
# df.iloc[[1]]
# selects the second row of values 

### #### ### ### Section Break ### ### ### 
# For reference about the material: see midterm materials folder
# 

x = int(input(2))
y = int(input(4))
print(x+y)


def concatA(a,b):
     return a + b

print(concatA([9, 2, 1], [4, 8, 7]))

def extendList(a):
    return 2*a
print(extendList([7,1,1]))


		
def addList(a):


def addList(a):
    return sum(a)
print(addList([7,1,1]))

x = 6
elif  x % 2 == 0:
    print("x is even")

x = 6
else  x % 2 == 0:
    print("x is even")

x = 6
if  x % 2 == 0:
    print("x is even")

x = 6
for  x % 2 == 0:
    print("x is even")


input()



class A:
      X = 0
      def __init__(self, v=0):
            self.Y=v
            A.X += v


a = A()
b = A(1)
c = A(2)
print(c.X)



x = 2
y = 4
x= x / y
y = y / x
print(y)


[1, 0, 1] + [2, 4, 6]




x = input(3)
y = int(input(6))
print(x * y)

3*6

practice = {'python':100, "r":30, "SQL": 10}
for key, value in practice :
       print(key+ " practice has " + str(value) + " items")



Which statement is illegal in Python?
Given the Python statement:



value = (42, "universe", "everything")


value.append(35)	
value.extend([5,7])
value.insert(1, "hitchhiker")


not(39 < 63)
Required Output:
False


x = 7
def is_odd (x) : return x % 2 == 1 # True

x = 9
def is_odd (x) : return x / 2 == 1 # False

x = 11
def is_odd (x) : if x % 2 == 1: return True else: return False # False

is_odd(x) 

( 1 < 15 ) and (15 <  25)

## New Practice ## 



# What is the ouput of this code?
import numpy as np
z = np.array([[4, 0, 5], 
              [2, 8, 4]])
print(z[0, 0])
# 4

# What will this return?
complex(5,4)
# Out[8]: (5+4j)

# What is the output of this code?
import numpy as np
m = np.array([2, 6, 4])
n = 2
print(m * n)
# [ 4 12  8]

# Complete the code to return the output
# 2.266911751455907
import numpy as np
np_2d = np.array([[5,6,1,2,3,4],[4,5,3,2,1,8],[9,10,3,7,6,5]])   
print(np.std(np_2d[1,:]))

# What will this return?
np.array([4,5]) < 6
# A boolean numpy array
# specifically; 
# Out[17]: array([ True,  True])

# Which of the following creates a 2D numpy array?
import numpy as np
np.array([[4.5,3,1], [5,6,7]])

# Which function is used to determine the data type of an object? 
# type()

# Select the code to return the output;
# [1,2,3]

x = [0,2,3]
y = x
y[0] = 1
print(x)
# [1,2,3]

# Select the code to return the output 
# 9 

import numpy as np 
p = np.array([9,19,13,16])
print(p[0])
# 9 

# Select the code to return the output
# [4 5 6]

import numpy as np 
m = np.array([2,4,6])
n = np.array([2, True, False])
print(m + n)
# [4 5 6]

# Which of the following statements is true for numpy arrays? 
# Numpy arrays cannot contain elements with different data types.


# Select the code to return the output 
# 3.5

import numpy as np 
np_2d = np.array([[5,6,1,2,3,4],[4,5,3,2,1,8],[9,10,3,7,6,5]])
print(np.median(np_2d[0,:]))
# 3.5

# Compelte the code to return the output
# 6.5 

x = 6.5 
print(x)
# 6.5 

# Which one of these will return the same result when slicing?
# x = ["a","b","c","d"]

x = ["a","b","c","d"]

x[1:] and x[:4]
# Out[27]: ['a', 'b', 'c', 'd']
x[:] and x[:-1]
# Out[28]: ['a', 'b', 'c']
x[-3] and x[1:] 
# Out[26]: ['b', 'c', 'd']

# which one of these will return the same result when slicing?
# x[-3] and x[1:] index the same values in a list

# Complete the code to return the output
# [['i', 'x', 'y'], [0, 0, 3], [2.54, 9.2, 3.84]]

a = [2.54, 9.2, 3.84]
b = ['i', 'x', 'y']
c = [0, 0, 3]
print([b,c,a])
# [['i', 'x', 'y'], [0, 0, 3], [2.54, 9.2, 3.84]]

# What code was added to identify the point 1994, 35? 
# plt.annotate('my point', xy = (1994, 35) xytext = (1980, 40) ) 

# Which of the following lines of code will set the style to dark_background?
# plt.style.use('dark_background')

# What code was added to create the text 'a blue line'?
# plt.plot(x, data, color = 'blue', label = 'a blue line')

# Which of the following information is not shown in a boxplot? 
# The mean
# Options:
    # the mean
    # the outliers
    # the median 
    # the 25th and 75th percentiles

# Complete the code to return the output
# y = df['diabetes'].values
# X = df.drop('diabetes', 
#              axis=1).values

# X_test and y_test are available localled and y_pred=knn.predict(X_test) . Make sure to have columns by predicted labels, like the convention.
# Complete the code to return the output
# [[23  0  0]
#  [ 0 19  0]
#  [ 0  1 17]]
# print(confusion_matrix(y_test, y_pred))

# Fill in the function so the accuracy of a regularized model is printed
# reg = ? (normalize = True)
# cv_scores = cross_val_score(?, 
#                 X, y, cv=5)
# print(cv_scores)

reg = Ridge(normalize = True)
cv_scores = cross_val_score(reg, 
                 X, y, cv=5)
print(cv_scores)

# When you print the shape method of your data you get the output below. 
# (5, 3)
# Which option correctly describe the format of the output?
# knn.predict(your_data)
# A 5 by 1 array: one prediction for each observation in your_data

# What code will return 
# True and True
True

# Complete the code to return the output 
# False 
not(39 < 63)

import numpy as np 
import pandas as pd
# Either create dictionary
d = {'product':['A','A','A','B','B','B'], 'month':['Jan','Feb','Mar','Jan','Feb','Mar'], 'sold':[85,200,180,90,80,130]}
# Or create array
array = np.array([['A','Jan','85'], ['A','Feb','200'],['A','Mar','180'],['B','Jan','90'],['B','Feb','80'],['B','Mar','130']])
sales = pd.DataFrame(d)
sales2 = pd.DataFrame(array, columns = ['product', 'month', 'sold'])
print(sales)
print(sales2)
# They are the same type
type(sales) == type(sales2)
# but do not have the same sold column as shown below
sales == sales2
# Why is this? 
# taking a closer look we can see the data types
sales['sold'] 
sales2['sold'] 
# this makes sense because of how we entered the data
# if we create the array without marks around the numerical values then the type changes
# For example, if we want the 'sold' column to be of int64 type then we change our array formating
# Our dictionary stays the same 
d = {'product':['A','A','A','B','B','B'], 'month':['Jan','Feb','Mar','Jan','Feb','Mar'], 'sold':[85,200,180,90,80,130]}
# But the array changes to this
array = np.array([['A','Jan',85], ['A','Feb',200],['A','Mar',180],['B','Jan',90],['B','Feb',80],['B','Mar',130]])
# Then rerun the pd.DataFrame functions
sales = pd.DataFrame(d)
sales2 = pd.DataFrame(array, columns = ['product','month','sold'])
# and print the results
print(sales)
print(sales2)
# They should be identical now but we can check
# First we look at their type which should both be pandas dataframes
type(sales) == type(sales2)
# Then use another boolean operator to show if all values are equal
sales == sales2 
# Interesting that the results are the same as above
# Our change in formating did nothing different
# Let's check the data types again to see
sales['sold'] 
# This dataframe from our dictionary remains the same with int64 
sales2['sold'] 
# But from our numpy array the result also remains an object data type
# ?pd.DataFrame
# From the documentation of pd.DataFrame we notice the inferred dtype is int64 when constructing a data frame from a dictionary
# To solve this during creation, one might use a different tool from dataclass
# Example of dataclass data frame creation
from dataclasses import make_dataclass
Point = make_dataclass("Point", [("col1", int), ("col2", int), ('col3', object)])
example = pd.DataFrame([Point(0, 0, 'obj1'), Point(0, 3, 'obj2'), Point(2, 3, 'obj3')])
print(example)
# Now we can apply this to our data frame
Point = make_dataclass("Point", [("product", object), ("month", object), ("sold", int)])
sales3 = pd.DataFrame([Point("A", "Jan", 85), Point("A", "Feb", 200), Point("A", "Mar", 180), Point("B", "Jan", 90), Point("B", "Feb", 80), Point("B", "Mar", 130)])
print(sales3)
# That looks great
# Lets repeat our boolean check of equality
sales == sales3
# Et voila! C'est magnifique et est exactement que nous voulons
# All values are true as desired

# Complete the code to return the output
#  product month  sold
# 1       A   Feb   200
# 2       A   Mar   180
import pandas as pd
d = {'product':['A','A','A','B','B','B'], 'month':['Jan','Feb','Mar','Jan','Feb','Mar'], 'sold':[85,200,180,90,80,130]}
sales = pd.DataFrame(d)
import numpy as np 
pick = np.logical_and(sales['product'] == 'A', sales['sold'] > 100)
sales[pick]

# Complete the code to return the output 
# False
x = 12
y = 7 
not(not(x < 6) and not(y > 20 or y > 10))

# What does ndarray stand for? 
# n dimensional aray

# Which data types can a list hold? 
# Any object

# Given the following list x, what does x[0] return? 
x = [2, 5, 4, 0, 7, 1]
x[0]

# What is a python list?
# It is a compound data type

# What is the output of this code? 
x = 3 
y = "Python"
print([x,y])
# [3, 'Python']

# Select the code to return the output
#    Month Count
# 0    Jan    52
# You have the following DataFrame df:
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Selection
print(df.loc[df['Month'] == 'Jan'])

# Which DataFrame method can you use to re-assign the index of a data frame?
# .reindex()

# Complete the code to return the output
# 52
# You have the following DataFrame df:
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Code to produce output
print(df['Count'].max)

# Complete the code to return the output 
#    SepalLength     ...              Name
# 0          5.1     ...       Iris-setosa
# 1          4.9     ...       Iris-setosa
# 2          4.7     ...       Iris-setosa
# 3          4.6     ...       Iris-setosa
# 4          5.0     ...       Iris-setosa
# [5 rows x 5 columns]
import pandas as pd 
df = pd.read_csv(iris.csv)
df.head()

# Complete the code to return the output
#    s_len     ...              name
# 0    5.1     ...       Iris-setosa
# 1    4.9     ...       Iris-setosa
# 2    4.7     ...       Iris-setosa
# 3    4.6     ...       Iris-setosa
# 4    5.0     ...       Iris-setosa
# [5 rows x 5 columns]
new_names = ['s_len', 's_wid', 'p_len', 
            'p_wid', 'name']
df = pd.read_csv(iris_csv, 
                 names =new_names, 
                 header = 0 )
print(df.head())

# Which of the following attributes would you use to get a DataFrame as a numpy array? 
# .values 

# You have the following DataFrame df:
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Complete the code to return the output
# 52 
print(df['Count'].max())

# Which of the following is the correct way to specify the number of rows to plt.subplots()?
# nrows=

# Which of the following lines of code matches the plot shown? 
plt.xticks(rotation=60) 
# x axis 'ticks' are rotated almost to the point of being perpedicular to the axis

# What code was added to place the legend 'a blue line'
plt.legend(loc='center right')

# What is the objective of image equalization?
# To reassign pixel intensitites to the image, so that the CDF of pixel intensities becomes a straight line

# Which function was used to generate the following image? 
# Image of pixelated colors
plt.pcolor

# Which plot can NOT be used to display a single variable? 
# lmplot()
# hist() is single variable
# violinplot() is single variable
# stripplot() is single variable

# Build a pipline that imputes with imp and then uses logistic regression with logreg
# no output
steps = [('impute',imp), ('logistic_reg',logreg)]
pipline = Pipline(steps)

# A colleague asks you to do an analysis on a dataset, df, full of missing data. You want to get rid of all rows with missing data before you start analyzing, which line of code do you start with?
df = df.dropna()

# Import the correct function/package for k-Nearest Neighbors Classification
# there is no output for this exercise
from sklearn.neighbors import KNeighborsClassifier

# Choose the correct import statement to use a scaler within a pipline. 
from sklearn.preprocessing import scale

# Other than calling the method drop on a column after using pd.get_dummies, which code below shows an equivalent way of deleting the redundant column?
pd.get_dummies(drop_first=True)

# Instantiate the regressor for linear regression
reg = LinearRegression()

# Which is NOT true about the format of data to be used in classification functions of scikit-learn?
# Features must have discrete values

# Which of the following statements about k-Nearest Neighbors classification is correct?
# A larger k leads to a less complex model, while a smaller k leads to a more complex model

# Import the correct function/package for accuracy analysis with a training and test data set
from sklearn.model_selection import train_test_split


# Fill in the code to get rid of the redundant column
df_party = pd.get_dummies(df)
df_party = df_party.drop('party_rep', axis = 1)
print(df_party.head())

# You have the following data frame
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3], ' ':['zero','one','two','three']}
df = pd.DataFrame(d)
# Set index
df = df.set_index([' '])
print(df)
# Complete the code to return the output
#      Month  Count                  
# one     Apr     29
# two     Mar     46
# three   Feb      3
print(df.loc['one':'three'])

# Assume you have run import matplotlib.pyplot as plt. Which method will display a pandas plot?
import matplotlib.pyplot as plt
plt.show()

# Select the code to return the output
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
print(df.loc[df['Count'] == 3])


# Which of the following is the correct way to specify the number of rows to plt.subplots()?
# nrows= 

# Complete the code to return the output
import pandas as pd
df = pd.read_csv(iris_csv)
df.head()

# Read this data set of purchases into python
import pandas as pd
exp2019 = pd.read_csv('C:/Users/Zachary Palmore/Desktop/2019.csv')
print(exp2019) 

# What is the total number of unique locations?
n = len(pd.unique(exp2019['Location']))
print("No.of.unique values :", n)

# How many unique values for each column/field?
n = exp2019.nunique(axis=0)
print("No.of.unique values in each column :\n", n)

# What are the unique values for the location column/field? 
quant = 0
unique_vals = []
for i in range(0, len(exp2019['Location'])):
    if exp2019['Location'][i] not in unique_vals: 
        unique_vals.append(exp2019['Location'][i])
        quant += 1
print("No.of.unique values :",
      quant)
print("unique values :",
      unique_vals)

# Which of the following is used to install numpy on a local system? 
pip3 install numpy

# Which command invokes the method x() of p? 
p.x()

# Complete the code to return the output
# 1.56 
import numpy as np
np_heights = np.array([[1.75,1.65,1.8,1.5],[1.56,1.70,1.4,1.29],[1.49,1.68,1.3,1.8]])
np.sort(np_heights[0])
print(np.median(np_heights[:,0]))

# Other options are incorrect because
import numpy as np
np_heights = np.array([[1.75,1.65,1.8,1.5],[1.56,1.70,1.4,1.29],[1.49,1.68,1.3,1.8]])
np.sort(np_heights[0])
print(np.mean(np_heights[:,0]))
# result; 1.59999999

# And the rest produce this error 
import numpy as np
np_heights = np.array([[1.75,1.65,1.8,1.5],[1.56,1.70,1.4,1.29],[1.49,1.68,1.3,1.8]])
np.sort(np_heights[0])
print(center(np_heights[:,0]))
# result; NameError: name 'center' is not defined

# Which command opens up the documentation from inside the IPython Shell for the len() function? 
help(len)

# Complete the code to return the output
# array([1, 2, 3])
import numpy as np 
data = [1,2,3]
np.array(data)

# Complete the code to return the output
# Instantiate the regressor for linear regression. 
# no output for this exercise
reg = LinearRegression()

# Fill in the function that gives the area under the roc curve
# Complete the code to return the output
print(roc_auc_score(y_test, y_pred_prob))

# A colleague asks you to do an analysis on a dataset, df, full of missing data.
# You want to get rid of all rows with missing data before you start analyzing. 
# Which line of code to you start with? 
df = df.dropna()

# For which of the following example of target variables can regression not be used? 
# The neighborhood where a house is located

# Other than calling the method drop on a column after using pd.get_dummies
# which code below shows an equivalent way of deleting the redundant column? 
pd.get_dummies(drop_first=True)

# You have the following data frame: 
import pandas as pd 
d = {'animal':["dog","cat","horse"]}
df = pd.DataFrame(d)
print(df)
# Select the code to return the output
#   animal
# 0     dog
# 10    NaN
# 20    NaN
# 30    NaN
# 40    NaN

new_index = [0, 10, 20, 30, 40]
df.reindex(new_index)



# You have the following DataFrame df:
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Select the code to return the output 
#   Month  Count
# 1   Feb      3
# 2   Mar     46
print(df.iloc[1:3])

# Which of the following is the correct way to specify the number of rows to plt.subplots()? 
nrows=

# Complete the code to return the output
# DatetimeIndex(['2013-01-01 09:12:34', '2013-01-01 09:12:34'], dtype='datetime64[ns]', freq=None)
l = ['2013-01-01 091234','2013-01-01 091234']
print((pd.to_datetime(l)))

# Which method is used to peek at the top of a DataFrame? 
.head()

# Complete the code to return the output
# {'name': 'Helen', 'age': '20', 'city': 'New York'}
dict = { 'name' : 'Helen', 'age':'20', 'city':'New York' }
print(dict)

# Complete the code to return the output
# l
# a
# z
# y
x = 'lazy'
for letter in x:
    print(letter)

# Here's the dictionary datacamp:
datacamp = { 'course':'python', 'level':'intermediate', 'lesson': {'dictionaries':'python', 'lists':'r' } }
# Complete the code to return the output
# {'course': 'python', 'level': 'intermediate', 'lesson': {'dictionaries': 'python', 'lists': 'sql'}}
datacamp['lesson']['lists'] = 'sql'
print(datacamp)

# Complete the code to return the output
# 2
# 3
# 4
i = 1
while i < 4:
    i = i + 1
    print(i)

# What is the main purpose of customizing a plot?
# To make the correct plot that makes the message very clear.


# Which line of code below will generate the same image as teh following:
# plt.imshow(img, extent=(-0.5,0.5,-1,1), aspect=1)
plt.imshow(img, extent=(-1,1,-1,1), aspect=2)

# Pick the pair of functions from matplotlin.pyplot that will allow you to load in an image then view it. 
imread, imshow

# Fill in the code to ensure that the strip plot shown below has small non-overlappin points
sns.stripplot(x='cyl', y='hp', data=auto, Jitter = True, size=2)

# The second figure is a zoomed in view of the first one. What was the code added to the plot? 
plt.xlim(1985, 1995) and plt.ylim(25,35)

# Print two plots, one on top of the other. Make sure they don't overlap!
plt.subplot(2,1,1)
plt.plot(v1, dataframe, color='blue')

plt.subplot(2,1,2)
plt.plot(v2, dataframe, color='red')

plt.tight_layout()
plt.show()


# Complete the code to return the output
# 'datacamp'
"datascience".replace("science","camp")

# Which command explicity imports the function sort() from the package numpy?
from numpy import sort

# Select the code to return the output
# 
# (For reference the output is empty/blank)
x = int(False)
y = 1
print(x * str(y))

# Complete the code to return the output
# 15 
import math
print(int(math.pi * 5))

# Complete the code to return the output
import numpy as np
store = np.array(["X", "Z", "Z", "Z"])
cost  = np.array([7, 1, 9, 4])
select_cost = cost[store == "X"]
print(select_cost)

# You have the following DataFrame df:
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Complete the code to return the output 
# 21.946905628508695
# get the standard devation of 'Count'
print(df['Count'].std())

# Which DataFrame method can you use to re-assign the index of a DataFrame? 
.reindex()

# You have the following DataFrame df: 
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Complete the code to return the output
# 0.1    10.8
# 0.9    50.2
# Name: Count, dtype: float64
print(df['Count'].quantile([0.10,0.90]))

# Which of the following is the correct way to specify the numbder of rows to plt.subplots()
plt.subplots(nrows=)

# Which method is used to peek at the top of a DataFrame? 
.head()
# Select the code to return the output
#   s_len     ...              name
#0    5.1     ...       Iris-setosa
#1    4.9     ...       Iris-setosa
#2    4.7     ...       Iris-setosa
#3    4.6     ...       Iris-setosa
#4    5.0     ...       Iris-setosa
#
#[5 rows x 5 columns]

new_names = ['s_len', 's_wid', 'p_len', 'p_wid', 'name'] 
df = pd.read_csv(iris_csv,    
names=new_names, 
header=0)
print(df.head())

# Which data frame method could you use to reassign the index of a data frame? 
.reindex()

# When plotting a scatter plot with DataFrame.plot() 
# which keyword argument is used to set the radius of each circle to plot? 
DataFrame.plot(s = )

# Complete the code to return the output
# 52 
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# get the max of 'Count'
print(df['Count'].max())

# Complete the code to return the output 
#   Month  Count
# 2   Mar     46
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
print(df.iloc[2:3])


# Fill in the code to generate the plot
sns.lmplot('accel', 'hp', data = auto, col='origin')

# which seaborn function should you use if you want to show the variation of a multivariate (more than 2 variables) dataset? 
sns.pairplot()

# What dates are included if you slice the time series using the following code fragment: 
# time_series['2018-05-22':'2018-05-24']
# May 22nd, May 23rd, and May 24th

# What code is used to display a plot? 
plt.show()

# You have the following DataFrame df: 
# Complete the code to return the output
# 52 
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# get the max of 'Count'
print(df['Count'].max())

# You have the following DataFrame df: 
# Complete the code to return the output
#   Month Count
# 3   Feb     3
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Solution
print(df.loc[df['Count'] == 3])

# You have the following DataFrame df: 
# Complete the code to return the output
# 0.1    10.8
# 0.9    50.2
# Name: Count, dtype: float64 
import pandas as pd 
d = {'Month':["Jan","Apr","Mar","Feb"], 'Count':[52,29,46,3]}
df = pd.DataFrame(d)
print(df)
# Solution
print(df['Count'].quantile([0.10, 0.90]))

# You have the following DataFrame df: 
# Complete the code to return the output
#  Month  Count
#1   Feb      3
#2   Mar     46
import pandas as pd 
d = {'Month':["Jan","Feb","Mar","Apr"], 'Count':[52,3,46,29]}
df = pd.DataFrame(d)
print(df)
# Solution
print(df.iloc[1:3])

# You have the following DataFrame: 
import pandas as pd
d = {'animal':["dog","cat","horse"]}
df = pd.DataFrame(d)
print(df)
# Complete the code to return the output
#    animal
# 0     dog
# 10    NaN
# 20    NaN
# 30    NaN
# 40    NaN
new_index = [0, 10, 20, 30, 40]
df.reindex(new_index)

# Import the correct package for confusion_matrix and classification_report 
# Complete the code to return the output
# there is no output for this exercise
from sklearn.metrics import confusion_matrix, classification_report

# choose the correct import statement to use cross validation
from sklearn.model_selection import cross_val_score

# Make a parameter dictionary for use within a pipeline that adjusts the number of neighbors in k-Nearest Neighbors classification
parameters = {'knn_n_neighbors' = np.arrange(1,50)}

# What statement about the difference between RandomizedSearchCV and GridSearchCV is correct? 
# GridSearchCV tried out all different parameter values while RandomizedSearchCV does not. 

# Complete the code to return the output
# Fill in the code to get rid of the redundant column
df_party = pd.get_dummies(df)
df_party = df_party.drop('party_rep', axis = 1)
print(df_party.head())

# The following shows the first 3 rows of the party column from the votes dataset. 
# What would the first 3 values of the new part_democrat column be after using pd.get_dummies? 
# party
# democrat
# democrat
# republican
# 1 1 0

# Fill in the code to find the accuracy of your regression model. 
# What is the output of this code? 
cv_scores = cross_val_score(reg_all, X, y, cv= 10)
print(cv_scores)
# 10 values that contain the decimal vectors of the cross val scores

# Complete the code to return the output
# Make prediction using your regularized model and analyze the performance. 
ridge = Ridge(alpha = 0.1, 
    normalize = True)
ridge.fit(X_train,y_train)
ridge_pred = ridge.predict(X_test)
print(ridge.score(X_test,y_test))

# Which of the following statement about k-Nearest Neighbors classification is correct? 
# A model with a smaller k is more likely to overfit to the data. 

# Complete the code to return the output
# Use GridSearchCV to find the optimal number of neighbors to use for knn classification
param_grid = {'n_neighbors':np.arange(1,50)}
knn = KNeighborsClassifier()
knn_cv = GridSearchCV(knn, param_grid, cv=5)
print(param_grid.keys())
# dict_keys(['n_neighbors'])


# X is unscaled with a mean of 24.623, X_scaled is scaled using scale() and y is unscaled
# with a mean of 69.603
# Select the code to return the output
# 69.60287769784172 9.0893165404277
print(np.mean(y),
      np.std(y))

# The make_logreg function initalizes your classifier. Print the probabilities that the predicted target is 0. 
# Complete the code to return the output
# [0.24854157 0.61361035 0.50724571 0.43195002 0.43309789 0.57375517
#  0.51326504 0.34523781 0.7716404  0.67059803]
logreg, X_test = make_logreg(X,y)
prob = logreg.predict_proba(X_test)[:,0]
print(prob)

# Ensure that the split of training and testing data is the correct size. The entire dataset has 100 rows.
# What is the output of this code? 
X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size = 0.3, random_state = 21)
print(X_test.shape)
# The output is:
# (30, 16)

# X, y, X_train, y_train, X_test, y_test are all available locally
# Complete the code to return the output
# 7 
knn = KNeighborsClassifier(n_neighbors=7)
knn.fit(X_train, y_train)
print(knn.n_neighbors)

# Fill in the code to find the accuracy of your regression model
# Complete the code to return the output 
# 0.838046873142936
print(reg_all.score(X_test, y_test))

# Which of the following imports DataFrame from pandas? 
from pandas import DataFrame

# Which method is used to peek at the top of a DataFrame? 
.head()

# Which of the following attributes can be used to set the title on a plot? 
.title

