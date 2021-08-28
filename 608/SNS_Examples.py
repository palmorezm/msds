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

# 