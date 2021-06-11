# -*- coding: utf-8 -*-
"""
Created on Thu Mar 25 16:51:04 2021

@author: Zachary Palmore
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import datetime as dt

data = pd.read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRVUsZrUEFrV0_2OQSCIn_JHCgs-ylPlFyowhr63XTCyAebIpVp7Dzq4Os_ARfm0yeEsrkenL_he4K4/pub?gid=0&single=true&output=csv")
print(data.head())

print(data.columns)

type(data['PlantWidth'])

# Unable to remove due to LT0.5 in begining of string
# ValueError: Unable to parse string "LT0.5" at position 0
pd.to_numeric(data['PlantWidth'])


# Must remove LT and impute something reasonable...
 
    

