# -*- coding: utf-8 -*-
"""
Created on Tue Oct 19 17:14:47 2021

@author: Owner
"""

# Packages
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 
import seaborn as sns
from tabulate import tabulate
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output 
import plotly.express as px
import plotly.io as pio
pio.renderers.default='browser' # Let plotly display in local browser



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
# Remove missing values
df  = trees.dropna()


# Refill unknowns
df = trees.fillna("Unknown")


borohealthdf = df[['count_tree_id','boro','health']]
borohealthdf['health'].value_counts()

pd.value_counts(df.boro).to_frame().reset_index()

df.groupby('boro').groupby('health').size().sort_values(ascending=False).reset_index(name = 'Count of Tree IDs')

fig = px.bar(df, x = "count_tree_id", y = "boro", color = "health")
fig.update_layout(barmode='group', xaxis_tickangle=0)
fig.show()

fig = px.bar(df, x="count_tree_id", y="steward", color="health")
fig.update_layout(barmode='group', xaxis_tickangle=0), 
fig.show()


df.groupby('boro').size().value_counts('health').size().sort_values(ascending=False).reset_index()

df.groupby(['health','boro']).size().sort_values(ascending=False).reset_index()



df.groupby(['health','boro']).transform('count')

df.health.unique()



# Goals 
# For Question 1:
# Filter by species for all boroughs and color by health
# The selection box would be for species name or spc_common 
# For Question 2:
# Repeat filter by species for all boroughs and color by health
# The selection remains species 
# Create a new plot with steward categories that show count of tree ids




# Build App 
boros = df.boro.unique()
species = df.spc_common.unique()

app = dash.Dash(__name__)

app.layout = html.Div([
    dcc.Dropdown(
        id="species_dropdown",
        options=[{"label": x, "value": x} for x in species],
        value=species[0],
        clearable=False,
    ),
    dcc.Graph(id="bar-chart"),
])

@app.callback(
    Output("bar-chart", "figure"), 
    [Input("species_dropdown", "value")])
def update_bar_chart(species):
    mask = df["spc_common"] == species
    fig2 = px.bar(df[mask], x="boro", y="boro", color="health")
    return fig2

app.run_server(debug=False)



# Build App 2
stewards = df.steward.unique()

app = dash.Dash(__name__)

app.layout = html.Div([
    dcc.Dropdown(
        id="stewards_dropdown",
        options=[{"label": x, "value": x} for x in stewards],
        value=stewards[0],
        clearable=False,
    ),
    dcc.Graph(id="bar-chart"),
])

@app.callback(
    Output("bar-chart", "figure"), 
    [Input("stewards_dropdown", "value")])
def update_bar_chart(stewards):
    mask = df["steward"] == stewards
    fig2 = px.bar(df[mask], x="count_tree_id", y="boro", color="health")
    return fig2

app.run_server(debug=False)


# Build App 3 
species = df.spc_common.unique()

app = dash.Dash(__name__)

app.layout = html.Div([
    dcc.Dropdown(
        id="species_dropdown",
        options=[{"label": x, "value": x} for x in species],
        value=species[0],
        clearable=False,
    ),
    dcc.Dropdown(
        id="species_dropdown",
        options=[{"label": x, "value": x} for x in species],
        value=species[0],
        clearable=False,
    ),
    dcc.Graph(id="bar-chart"),
    dcc.Graph(id="bar-chart"),
])

@app.callback(
    Output("bar-chart", "figure"), 
    [Input("species_dropdown", "value")])
def update_bar_chart(species):
    mask = df["spc_common"] == species
    fig2 = px.bar(df[mask], x="count_tree_id", y="boro", color="health")
    return fig2
    Output("bar-chart", "figure"), 
    [Input("species_dropdown", "value")]
    mask = df["spc_common"] == species
    fig2 = px.bar(df[mask], x="count_tree_id", y="boro", color="health")
    return fig2

app.run_server(debug=False)






