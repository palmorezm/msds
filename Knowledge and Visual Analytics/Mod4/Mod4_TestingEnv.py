# -*- coding: utf-8 -*-
"""
Created on Tue Oct 19 15:08:08 2021

@author: Owner
"""

# Packages
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 
import seaborn as sns
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output 
import plotly.express as px
import plotly.io as pio
pio.renderers.default='browser' # Let plotly display in local browser

# Socrata API Background
# Examples shown below:
# Reading JSON with Pandas
url = 'https://data.cityofnewyork.us/resource/nwxe-4ae8.json'
trees = pd.read_json(url)
trees.head(10)
trees.shape # shows dimensions of data 
# limited to 1000 obs by the api of 45 variables 
# We can avoid limits by paginating 
# This works well if we have a mobile phone app
# Chuunk shows the first 5 
firstfive_url = 'https://data.cityofnewyork.us/resource/nwxe-4ae8.json?$limit=5&$offset=0'
firstfive_trees = pd.read_json(firstfive_url)
firstfive_trees
# Chunk shows the next 5 
nextfive_url = 'https://data.cityofnewyork.us/resource/nwxe-4ae8.json?$limit=5&$offset=5'
nextfive_trees = pd.read_json(nextfive_url)
nextfive_trees
# We can also obtain more specific data
# Here we filter by the boro 'Bronx' and find the 
# spc_common and count the quantity of trees
# (sps_common is the species name tree_id is a unique number to each tree)
boro = 'Bronx'
soql_url = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=spc_common,count(tree_id)' +\
        '&$group=spc_common').replace(' ', '%20')
soql_trees = pd.read_json(soql_url)
soql_trees
# **NOTE**: One tip in dealing with URLs: you may need to 
# replace spaces with `'%20'`. This cab done with .replace(' ', '%20')
# as shown in the call query above


# The questions: 
# 1. Across each borough, what proportion of trees are in good, fair, or 
# poor health according to the ‘health’ variable?
# 2. Across each borough, Are stewards (steward activity measured by the 
# ‘steward’ variable) having an impact on the health of trees?


# Extracting our Data
# We seperate by boroughs
# Bronx 
soql_url1 = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, sps_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=health').replace(' ', '%20')
bronx = pd.read_json(soql_url1)
# Brooklyn
soql_url2 = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, count(tree_id)' +\
        '&$where=boroname=\'Brooklyn\'' +\
        '&$group=health').replace(' ', '%20')
brooklyn = pd.read_json(soql_url2)
# Manhattan
soql_url3 = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, count(tree_id)' +\
        '&$where=boroname=\'Manhattan\'' +\
        '&$group=health').replace(' ', '%20')
manhattan = pd.read_json(soql_url3)
# Staten Island
soql_url4 = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, count(tree_id)' +\
        '&$where=boroname=\'Staten Island\'' +\
        '&$group=health').replace(' ', '%20')
staten = pd.read_json(soql_url4)
# Queens
soql_url5 = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, count(tree_id)' +\
        '&$where=boroname=\'Queens\'' +\
        '&$group=health').replace(' ', '%20')
queens = pd.read_json(soql_url5)
# Set boro for each borough
bronx["boro"] = "bronx"
brooklyn["boro"] = "brooklyn"
manhattan["boro"] = "manhattan"
staten["boro"] = "staten island"
queens["boro"] = "queens"
# Combine
frames = [bronx, brooklyn, manhattan, staten, queens]
borotreehealth = pd.concat(frames)
borotreehealth

# Cleaning
# Remove some missing values
df = borotreehealth.fillna("Unknown")
hue_order = ["Poor", "Fair", "Good", "Unknown"] # Set order (for graphs)


# Visualizing Before Development 

# Test Graphics 
# Decide what we want it to look like
# Barplot? 
sns.barplot(x = "boro", y = "count_tree_id", 
            hue = "health", hue_order = hue_order, data = df)

# How about interactivity?
fig = px.bar(df, x = "boro", y = "count_tree_id", color = "health")
fig.update_layout(barmode='group', xaxis_tickangle=0)
fig.show() # Should show in seperate browser based on pio (plotly.io) setting

# Develop Dash App
boros = df.boro.unique()

app = dash.Dash(__name__)

app.layout = html.Div([
    dcc.Dropdown(
        id="dropdown",
        options=[{"label": x, "value": x} for x in boros],
        value=boros[0],
        clearable=False,
    ),
    dcc.Graph(id="bar-chart"),
])

@app.callback(
    Output("bar-chart", "figure"), 
    [Input("dropdown", "value")])
def update_bar_chart(boros):
    mask = df["boros"] == boros
    fig = px.bar(df[mask], x="boros", y="count_tree_id", 
                 color="health", barmode="group")
    return fig

if __name__ == '__main__':
    app.run_server(debug = False)


# Collect Full Data

# Bronx 
soql_url_bronx = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=steward, health, spc_common').replace(' ', '%20')
bronx = pd.read_json(soql_url_bronx)

bronx.head(10)

# Brooklyn
soql_url_brooklyn = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=steward, health, spc_common').replace(' ', '%20')
brooklyn = pd.read_json(soql_url_brooklyn)

# Manhattan
soql_url_manhattan = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=steward, health, spc_common').replace(' ', '%20')
manhattan = pd.read_json(soql_url_manhattan)

# Staten Island
soql_url_staten = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=steward, health, spc_common').replace(' ', '%20')
staten = pd.read_json(soql_url_staten)

# Queens
soql_url_queens = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=steward, health, spc_common').replace(' ', '%20')
queens = pd.read_json(soql_url_queens)

# create a 'boro' variable and set correct label before merge
bronx["boro"] = "bronx"
brooklyn["boro"] = "brooklyn"
manhattan["boro"] = "manhattan"
staten["boro"] = "staten island"
queens["boro"] = "queens"

# merge all boroughs together
boroughs = [bronx, brooklyn, manhattan, staten, queens]
trees = pd.concat(boroughs) 

# Refill unknowns
df = trees.fillna("Unknown")

# Build App 
boros = df.boro.unique()

app = dash.Dash(__name__)

app.layout = html.Div([
    dcc.Dropdown(
        id="boro_dropdown",
        options=[{"label": x, "value": x} for x in boros],
        # set default value
        value=boros[0],
        clearable=False,
    ),
    dcc.Graph(id="bar-chart"),
])

@app.callback(
    Output("bar-chart", "figure"), 
    [Input("boro_dropdown", "value")])
def update_bar_chart(boro):
    mask = df["boro"] == boro
    fig2 = px.bar(df[mask], x="steward", y="count_tree_id", color="health")
    return fig2

app.run_server(debug=False)




