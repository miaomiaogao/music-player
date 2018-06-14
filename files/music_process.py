# -*- coding: utf-8 -*-
"""
Created on Wed Jun 13 10:25:09 2018

@author: maggie
"""
import numpy as np
import pandas as pd

data = pd.read_csv('liangzhu.csv', header =None,names=['key'])
keys = list(range(0,16))
values = [0,1432,1276,1136,1073,955,851,758,716,638,568,536,478,426,379,358]
dic = dict(zip(keys,values))

data_values = data['key'].map(dic)
data['value'] = data_values

str2 = list(data_values)
str3 = ''.join('x\"%04x\", '%b for b in str2)
