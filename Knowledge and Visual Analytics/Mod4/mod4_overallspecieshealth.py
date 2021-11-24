# -*- coding: utf-8 -*-
"""
Created on Sun Oct 24 16:27:19 2021

@author: Owner
"""

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


df1_dropped = df1.drop(columns=['steward'])
df1_counts = df1_dropped.groupby(['health', 'boro']).count_tree_id.sum().reset_index(name='frequency')
borough_totals = df1_counts.groupby(['boro']).frequency.sum()
boro_totals = pd.DataFrame([borough_totals]*3).stack().reset_index(name='boro_totals')
df1_counts.insert(3, 'boro_total', boro_totals['boro_totals'])
perc = ((df1_counts.frequency / df1_counts.boro_total)*100)
df1_counts.insert(4, 'percent', perc)
df1_counts

df_dropped = df.drop(columns=['steward'])
df_counts = df_dropped.groupby(['health', 'boro']).count_tree_id.sum().reset_index(name='frequency')
borough_totals = df_counts.groupby(['boro']).frequency.sum()
boro_totals = pd.DataFrame([borough_totals]*3).stack().reset_index(name='boro_totals')
df_counts.insert(3, 'boro_total', boro_totals['boro_totals'])
perc = ((df_counts.frequency / df_counts.boro_total)*100)
df_counts.insert(4, 'percent', perc)
df_counts

species1 = df1.spc_common.unique() # Specify unique features for dropdown
species5 = df5.spc_common.unique() 
species = df.spc_common.unique()

app = dash.Dash(__name__)
app.layout = html.Div([
    # Sets up for a dropdown box with options 
    # label x and values of x in df.spc_common.unique()
    dcc.Dropdown(
        id="dropdown",
        options=[{"label": x, "value": x} for x in species],
        # What to show at start
        value=species[0],
        clearable=False,
    ),
    # Sets up for graph object to be shown
    dcc.Graph(id="q1graph"),
])

@app.callback(
    Output("q1graph", "figure"), 
    [Input("dropdown", "value")])
def update_bar_chart(species):
    mask = df["spc_common"] == species
    species_selection = df[mask]
    df_dropped = species_selection.drop(columns=['steward'])
    df_counts = df_dropped.groupby(['health', 'boro']).count_tree_id.sum().reset_index(name='frequency')
    borough_totals = df_counts.groupby(['boro']).frequency.sum()
    boro_totals = pd.DataFrame([borough_totals]*3).stack().reset_index(name='boro_totals')
    df_counts.insert(3, 'boro_total', boro_totals['boro_totals'])
    perc = ((df_counts.frequency / df_counts.boro_total)*100)
    df_counts.insert(4, 'percent', perc)
    fig = px.bar(df_counts, 
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
    return fig

if __name__ == '__main__':
    app.run_server(debug = False)




