# -*- coding: utf-8 -*-
"""
Created on Thu Oct 21 20:33:37 2021

@author: Owner
"""

# Question 1
# For a given species (silver maple, honeylocust, or any single species), what proportion
# trees are in good, fair, and poor health within each boro?


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
soql_url1  = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Bronx\'' +\
        '&$group=health, steward, spc_common').replace(' ', '%20')
bronx = pd.read_json(soql_url1)
#Brooklyn
soql_url2  = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Brooklyn\'' +\
        '&$group=health, steward, spc_common').replace(' ', '%20')
brooklyn = pd.read_json(soql_url2)
# Manhattan
soql_url3  = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Manhattan\'' +\
        '&$group=health, steward, spc_common').replace(' ', '%20')
manhattan = pd.read_json(soql_url3)
# Staten Island
soql_url4  = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Staten Island\'' +\
        '&$group=health, steward, spc_common').replace(' ', '%20')
staten = pd.read_json(soql_url4)
# Queens
soql_url5  = ('https://data.cityofnewyork.us/resource/nwxe-4ae8.json?' +\
        '$select=health, steward, spc_common, count(tree_id)' +\
        '&$where=boroname=\'Queens\'' +\
        '&$group=health, steward, spc_common').replace(' ', '%20')
queens = pd.read_json(soql_url5)
# Set boro for each borough
bronx["boro"] = "bronx"
brooklyn["boro"] = "brooklyn"
manhattan["boro"] = "manhattan"
staten["boro"] = "staten island"
queens["boro"] = "queens"
# Merge
boros = [bronx, brooklyn, manhattan, staten, queens]
data = pd.concat(boros) 
# Remove NA
df = data.dropna()


# Select 5 trees for testing
select5 = ['ginko', 'American linden', 'Chinese elm', 'Japanese hornbeam', 'pin oak']
df5 = df[df.spc_common.isin(select5)]

# Select 1 species for testing
select1 = ['pin oak']
df1 = df[df.spc_common.isin(select1)]

# Plotly Express
fig = px.bar(df5, x="boro", y="count_tree_id", 
                 color="health", barmode="group", 
                 pattern_shape="health")
fig.show()

# Plotly Full - See "Rotated Bar Chart Labels"
https://plotly.com/python/bar-charts/#customize-bar-charts-with-plotly-express


# Test App (Functions Good - except colors chnage with each species)
species1 = df1.spc_common.unique() # Specify unique features for dropdown
species5 = df5.spc_common.unique() 

app = dash.Dash(__name__)
app.layout = html.Div([
    # Sets up for a dropdown box with options 
    # label x and values of x in df.spc_common.unique()
    dcc.Dropdown(
        id="dropdown",
        options=[{"label": x, "value": x} for x in species5],
        # What to show at start
        value=species5[0],
        clearable=False,
    ),
    # Sets up for graph object to be shown
    dcc.Graph(id="q1graph"),
])

@app.callback(
    Output("q1graph", "figure"), 
    [Input("dropdown", "value")])
def update_bar_chart(species5):
    mask = df5["spc_common"] == species5
    fig = px.bar(df5[mask], 
                 y="boro", x="count_tree_id", 
                 color="health", barmode="group", 
                 pattern_shape="health")
    return fig

if __name__ == '__main__':
    app.run_server(debug = False)




# Dash Side-by-Side Figure Output
app = dash.Dash()
app.layout = html.Div([
    html.Div([
        html.Div([
            html.H3('Column 1'),
            dcc.Graph(id='g1', figure= px.bar(df5[mask], x="boro", y="count_tree_id", 
                             color="health", barmode="group", 
                             pattern_shape="health")
                      ) 
        ], className="six columns"),

        html.Div([
            html.H3('Column 2'),
            dcc.Graph(id='g2', figure={'data': [{'y': [1, 2, 3]}]})
        ], className="six columns"),
    ], className="row")
])

app.css.append_css({
    'external_url': 'https://codepen.io/chriddyp/pen/bWLwgP.css'
})

if __name__ == '__main__':
    app.run_server(debug=False)


