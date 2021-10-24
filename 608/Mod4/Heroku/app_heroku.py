# -*- coding: utf-8 -*-
"""
Created on Sun Oct 24 17:55:49 2021

@author: Owner
"""


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
import gunicorn

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
colors = ({'Poor':'pink','Fair':'orange','Good':'green'})
color_sequence =["pink","goldenrod", "green"]

# Order (As umbridge would say, "I will have order!")
df5.sort_values(['health', 'steward'])
cat_orders = category_orders=({'health': ["Poor","Fair","Good"],
                               'steward': ['None','1or2','3or4','4orMore'],
                               'boro': ['bronx','brooklyn','manhattan','staten island','queens'] })

# Preprocessing 
skdf5_counttreeids = sk.preprocessing.scale(df5['count_tree_id'])
df5_countreeids_abovezero = (skdf5_counttreeids + abs(skdf5_counttreeids.min()))
df5['trees_scaled'] = df5_countreeids_abovezero.tolist()


# Species Selection Options
species1 = df1.spc_common.unique() # Specify unique features for dropdown
species5 = df5.spc_common.unique() 
species = df.spc_common.unique()

# App Side-by-Side Figure Output
app = dash.Dash(__name__)
server == app.server

app.layout = html.Div([
    html.Div([
        
        html.Div([
            html.H1('NYC Tree Species Health Assessment'),
            html.H3('Select Species'),
            dcc.Dropdown(id='dropdown',
                         options=[{"label": x, "value": x} for x in species],
                         value=species5[0],
                         clearable=False),
            html.H4('Note that this data was collected by volunteers across each borough with the goal of cateloging all trees in the city'),
            html.H3('Question 1'),
            html.H4('What proportion of trees are in good, fair, or poor health?'),
            html.H4('Part A: We review the number of healthy individuals of the selected species using the count of trees by borough'),
            dcc.Graph(id='g1')], className="six columns"),
        
        html.Div([
            html.H4('Part B: We review the proportion of good, fair, and poor, individuals of the selected species across each borough'),
            dcc.Graph(id='g2')], className="six columns"), 
        
        html.Div([
            html.H3('Question 2'),
            html.H4('Are steward having an impact on the health of trees?'),
            html.H4('A stacked bar chart that shows the normalized change in proportions of tree health by borough'),
            dcc.Graph(id='g3')], className="six columns"),
            html.H3('Data Source: https://data.cityofnewyork.us/Environment/2015-Street-Tree-Census-Tree-Data/uvpi-gqnh')
        
        ], className="row")
    ])

app.css.append_css({
    'external_url': 'https://codepen.io/chriddyp/pen/bWLwgP.css'
})

# Desired Figure Order 
# Q1 - proportion of trees by health using real counted quantities of a tree species for each boro
# Q1_2 - proportion of trees by percentage health for each boro
# Q2_2 - percentage of trees' health with facet_col = steward within each boro

@app.callback(Output("g1", "figure"),
              Output("g2", "figure"),
              Output("g3", "figure"),
              [Input("dropdown","value")])
def update_charts(species):
    mask = df["spc_common"] == species
    species_selection = df[mask]
    df_table_steward = species_selection.groupby(['steward', 'boro']).health.value_counts(normalize=True).mul(100).rename('percent').reset_index()
    df_dropped = species_selection.drop(columns=['steward'])
    df_counts = df_dropped.groupby(['health', 'boro']).count_tree_id.sum().reset_index(name='frequency')
    borough_totals = df_counts.groupby(['boro']).frequency.sum()
    boro_totals = pd.DataFrame([borough_totals]*3).stack().reset_index(name='boro_totals')
    df_counts.insert(3, 'boro_total', boro_totals['boro_totals'])
    perc = ((df_counts.frequency / df_counts.boro_total)*100)
    df_counts.insert(4, 'percent', perc)
    figure1 = px.bar(df[mask], 
                 y="count_tree_id", x="boro", 
                 color="health", barmode="group", 
                 opacity=0.50, title ="Number of Species Per Borough",
                 category_orders= cat_orders, 
                 color_discrete_sequence=color_sequence, 
                 template='simple_white', labels={"boro":" ", 
                                                  "count_tree_id": "Number of Trees"})
    figure2 = px.bar(df_counts, 
                 x="boro", 
                 y="percent", 
                 color="health", 
                 barmode="group",
                 log_y=False, opacity=0.50,
                 category_orders= cat_orders, 
                 color_discrete_sequence=color_sequence, 
                 template='simple_white', 
                 title = "Health of Species Per Borough", 
                 labels={"boro": " ",
                         "percent": "Percent of Trees(%)"})
    figure3 = px.bar(df_table_steward, 
                 x="boro", # boro
                 y="percent", # percent
                 color="health", # health
                 facet_col='steward', # steward
                 barmode="stack",
                 log_y=False, opacity=0.50,
                 category_orders= cat_orders,
                 color_discrete_sequence=color_sequence, 
                 template='simple_white', title = "Health of Species by Steward Activity", 
                 labels={"boro": " ",
                         "percent": "Percent of Trees (%)"})
    return figure1, figure2, figure3

if __name__ == '__main__':
    app.run_server(debug=False)





