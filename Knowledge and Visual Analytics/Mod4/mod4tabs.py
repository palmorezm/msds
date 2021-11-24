# -*- coding: utf-8 -*-
"""
Created on Sat Oct 23 22:12:15 2021

@author: Owner
"""

# Working from
# https://dash.plotly.com/dash-core-components/tabs

# Question 1
# For a given species (silver maple, honeylocust, or any single species), what proportion 
# of trees are in good, fair, and poor health within each boro?
# Question 2
# For a given species (silver maple, honeylocust, or any single species), are stewards 
# (steward activity measured by the ‘steward’ variable) having an impact on the health of trees?


# Packages
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 
import seaborn as sns
import sklearn as sk
from sklearn.preprocessing import scale
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

# Choose Colors
colors = ({'Poor':'red','Fair':'yellow','Good':'green'})


# Order (As umbridge would say, "I will have order!")
df5.sort_values(['health', 'steward'])
df1.sort_values(['count_tree_id','boro','health','steward'])
cat_orders = category_orders=({'health': ["Poor","Fair","Good"],
                               'steward': ['1or2','3or4','4orMore','None'],
                               'boro': ['bronx','brooklyn','manhattan','staten island','queens'] })

# Preprocessing 
skdf5_counttreeids = sk.preprocessing.scale(df5['count_tree_id'])
df5_countreeids_abovezero = (skdf5_counttreeids + abs(skdf5_counttreeids.min()))
df5['trees_scaled'] = df5_countreeids_abovezero.tolist()

species1 = df1.spc_common.unique() # Specify unique features for dropdown
species5 = df5.spc_common.unique() 

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

app.layout = html.Div([
    dcc.Tabs([
        dcc.Tab(label='Tab one', children=[
            dcc.Graph(
                figure={
                   px.bar(df5, x="boro", y="count_tree_id", color="health", 
                          barmode="group", color_discrete_map= colors, category_orders= cat_orders)
                }
            )
        ]),
        dcc.Tab(label='Tab two', children=[
            dcc.Graph(
                figure={
                    'data': [
                        {'x': [1, 2, 3], 'y': [1, 4, 1],
                            'type': 'bar', 'name': 'SF'},
                        {'x': [1, 2, 3], 'y': [1, 2, 3],
                         'type': 'bar', 'name': u'Montréal'},
                    ]
                }
            )
        ]),
        dcc.Tab(label='Tab three', children=[
            dcc.Graph(
                figure={
                    'data': [
                        {'x': [1, 2, 3], 'y': [2, 4, 3],
                            'type': 'bar', 'name': 'SF'},
                        {'x': [1, 2, 3], 'y': [5, 4, 3],
                         'type': 'bar', 'name': u'Montréal'},
                    ]
                }
            )
        ]),
    ])
])

if __name__ == '__main__':
    app.run_server(debug=False)

# Fully written Static Two Tabs
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
app.layout = html.Div([
    dcc.Tabs([
        dcc.Tab(label='Tab 1', children = [ 
            dcc.Graph(
                figure = px.bar(df5, x = 'boro', y="count_tree_id", color="health", 
                                barmode="group", color_discrete_map= colors, category_orders= cat_orders)
                )
            ]),
        dcc.Tab(label='Tab 2', children = [ 
            dcc.Graph(
                figure = px.bar(df5, x = 'boro', y="count_tree_id", color="health", 
                                barmode="group", color_discrete_map= colors, category_orders= cat_orders)
                )
            ])        
    ])
])

if __name__ == '__main__':
    app.run_server(debug=False)
    
    
# Tab with dropdown callback
species5 = df5.spc_common.unique() # Specify unique features for dropdown
default_category = 'pin oak'
default_index = 0

# Method 1
tab1 = html.Div([
    html.H3('Tab content 1'),
    dcc.Dropdown(id='first-dropdown',
                 options=[{"label": x, "value": x} for x in species5],
                 value=species5[0],
                 clearable=False),
    dcc.Graph(id='q1graph')
    ])

tab2 = html.Div([
    html.H3('Tab content 2'),
    dcc.Dropdown(id='first-dropdown',
                 options=[{"label": x, "value": x} for x in species5],
                 value=species5[0],
                 clearable=False),
    dcc.Graph(id='q2graph')
    ])

app.layout = html.Div([
    html.H1('Dash Tabs Component Demo'),
    dcc.Tabs(id='tabs-example', value = 'tab-1-example', children=[
        dcc.Tab(id="tab-1", label='Tab One', value='tab-1-example'),
        dcc.Tab(id="tab-1", label='Tab One', value='tab-1-example')
        ])
    html.Div(id='tabs-content-example', children = tab1)
    ])

@app.callback(dash.dependencies.Output('tabs-content-example', 'children'),
              [dash.dependencies.Input('tabs-example', 'value')])
def render_content(tab):
    if tab == 'tab-1-example':
        return tab1
    if tab == 'tab-2-example':
        return tab2
    
@app.callback([desh.dependencies.Output('second-dropdown', 'options'),
               dash.dependencies.Output('second-dropdown', 'value')],
              [dash.dependencies.Input('first-dropdown', 'value')])
def update_dropdown(value):
    return [[ {'label': i, 'value': i} for i in df5[value] ], df5[value][default_index]]
    


# Method 2
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dahs(__name__, external_stylesheets=external_stylesheets)
app.layout = html.Div([
    html.H1('Dash Tabs Component Demo'),
    dcc.Tabs(id='tabs-example', value = 'tab-1-example', children=[
        dcc.Tab(label='Tab 1', value = 'tab-1-example'), 
            dcc.Dropdown(id = 'dropdown', 
                         options=[{"label": x, "value": x} for x in species5],
                         value = species5[0],
                         clearable = False), 
            dcc.Graph(id='q1graph'),
        dcc.Tab(label='Tab 2', value='tab-2-example'),
            dcc.Dropdown(id='dropdown',
                         options=[{"label": x, "value": x} for x in species5],
                         value = species5[0],
                         clearable = False),
            dcc.Graph(id='q2_2graph')
        ]),
    html.Div(id='tabs-content-example')
 ])

@app.callback(Output(component_id='tabs-content-example', component_property='children'),
              [Input(component_id='tabs-example', component_property='value')])
def render_content(tab):
    if tab == 'tab-1-example':
        return html.Div([
            html.H3('Tab content 1'), 
            dcc.Dropdown(id='dropdown',
                         options=[{"label": x, "value": x} for x in species5],
                         value =species5[0],
                         clearable=False),
            dcc.Graph(id='q1graph')
        ])
    elif tab == 'tab-2-example':
        return html.Div([
            html.H3('Tab content 2'),
            dcc.Dropdown(id='dropdown',
                         options=[{"label": x, "value": x} for x in species5],
                         value =species5[0],
                         clearable=False),
            dcc.Graph(id='q2graph')
        ])
    


