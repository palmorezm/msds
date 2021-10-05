# -*- coding: utf-8 -*-
"""
Created on Tue Oct  5 14:14:49 2021

@author: Zachary Palmore
"""

import pandas as pd
import numpy as np

k1 = {-13, -10, -8, -5}

k2 = {2, 5, 8, 12, 15}

E1 = sum(k1)
E2 = sum(k2)

Mu1 = np.mean(k1)
Mu2 = np.mean(k2)

k1 = {-13, -10, -7, -5, -1, 3}

k2 = {-4, 1, 4, 6, 9, 10}
E1 = sum(k1)
E2 = sum(k2)

(E1+E2)/ 2