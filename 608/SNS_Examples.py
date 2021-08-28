# -*- coding: utf-8 -*-
"""
Created on Sat Aug 28 12:25:42 2021

@author: Owner
"""

# Data Visualization
# Introduction to Seaborn
# Notes and Examples of Common Visualization Techniques

# Packages
import seaborn as sns # named for Sanmuel Norman Seaborn in The West Wing TV show
import matplotlib.pyplot as plt # requires matplotlib to run (sns is built on it)

# Scatterplot Example 
# Uses two numeric data types to plots as x and y points
# ExQ: Do taller people tend to weigh more? 
height = [62, 64, 69, 75, 66, 68, 65, 71, 76, 73]
weight = [120, 136, 148, 175, 137, 165, 154, 172, 200, 187]
sns.scatterplot(x = height, y = weight)
plt.show()

# Count Plot Example
# Uses categorical list(s) and creates bars that represent the number of list entries per category
# ExQ: Were there more males or females in height/weight study?
import seaborn as sns # Importing packages is only necessary if...
import matplotlib.pyplot as plt # they were not imported prior to this example
gender = [ "Female", "Female", "Female", "Female", 
          "Male","Male","Male","Male","Male","Male"]
sns.countplot(x = gender)
plt.show()

#####################################################

# Adding Pandas
# This will allow us to use DataFrames 

# Importing the data 
import pandas as pd # Includes needed functions
# data taken from remote Github by FiveThirtyEight
df = pd.read_csv("https://raw.githubusercontent.com/palmorezm/misc/master/DCC/masculinity.csv") 
df.head()

# Check for missing values 
# In this case by each column
df.isnull().sum() # All zeros - good! 

# Create count plot the same as the example above
sns.countplot(x = "q0001", data = df)
plt.show()

######################################################

# Adding a hue 
# This allows nother dimension when visualizing (or third variable)

# The Seaborn package has a built in dataset 
# It is called "tips" and is imported as shown
import pandas as pd # import pandas package first since it will be a dataframe
import seaborn as sns # then the seaborn package
tips = sns.load_dataset("tips") # creates a new object with the "tips" data from seaborn 
tips.head() # View the first 5 rows


# Hue Scatterplot Example
sns.scatterplot(x = "total_bill", 
                y = "tip", 
                data = tips, 
                hue ="smoker") # Display "Yes" if smoker and "No" otherwise
plt.show()

# Changing other aspects of Hue
sns.scatterplot(x = "total_bill", 
                y = "tip", 
                data = tips, 
                hue ="smoker", 
                hue_order=["Yes","No"]) # Flip order of Hue legend
plt.show()

# Using a dictionary to change color
hue_colors = {"Yes" : "black", "No": "red"} # Create dictionary with colors specified
hue_colors2 = {"Yes" : "b", "No": "r"} # Letter abbreviations from matplotlib package
hue_colors3 = {"Yes" : "#BFBF00", "No": "#00bfbf"} # Using HTML hex codes 
sns.scatterplot(x = "total_bill", 
                y = "tip", 
                data = tips, 
                hue ="smoker", 
                hue_order=["Yes","No"],
                palette=hue_colors) # Changes values to specific colors chose
plt.show()
sns.scatterplot(x = "total_bill", 
                y = "tip", 
                data = tips, 
                hue ="smoker", 
                hue_order=["Yes","No"],
                palette=hue_colors2) # Changes values to abbreviated colors
plt.show()
sns.scatterplot(x = "total_bill", 
                y = "tip", 
                data = tips, 
                hue ="smoker", 
                hue_order=["Yes","No"],
                palette=hue_colors3) # Changes values to HTML hex color code specified in dictionary
plt.show()

# Hue Count Plot Example
# Follows the same programing as scatterplot example 
import seaborn as sns # Only required if not already imported
import matplotlib.pyplot as plt # Is what seaborn is built on
sns.countplot(x = "smoker", 
              data = tips, 
              hue = "sex") 
plt.show()

