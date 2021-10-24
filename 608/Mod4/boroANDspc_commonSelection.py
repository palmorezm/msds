# -*- coding: utf-8 -*-
"""
Created on Sun Oct 24 11:40:27 2021

@author: Owner
"""

import dash
import dash_html_components as html
import dash_core_components as dcc

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

myList = ['A', 'B']
myDict = {'A': [1,2,3],'B': [4,5,6] }
default_category = 'A'
default_index = 0

tab1 = html.Div([
    html.H3('Tab content 1'),
    dcc.Dropdown(id='first-dropdown',
                 options=[{'label':l, 'value':l} for l in myList],
                 value = default_category
    ),
    dcc.Graph(id='q1graph')
])

tab2 = html.Div([
    html.H3('Tab content 2'),
    dcc.Dropdown(id='first-dropdown',
                 options=[{'label':l, 'value':l} for l in myList],
                 value = default_category
    ),
    dcc.Graph(id='q2graph')
])    

app.layout = html.Div([
    html.H1('Dash Tabs component demo'),
    dcc.Tabs(id="tabs-example", value='tab-1-example', children=[
        dcc.Tab(id="tab-1", label='Tab One', value='tab-1-example'),
        dcc.Tab(id="tab-2", label='Tab Two', value='tab-2-example'),
    ]),
    html.Div(id='tabs-content-example',
             children = tab1)
])

@app.callback(dash.dependencies.Output('tabs-content-example', 'children'),
             [dash.dependencies.Input('tabs-example', 'value')])
def render_content(tab):
    if tab == 'tab-1-example':
        return tab1
    elif tab == 'tab-2-example':
        return tab2

@app.callback(
    [dash.dependencies.Output("q1graph", "figure")],
    [dash.dependencies.Input('first-dropdown', 'value')])
def update_bar_chart(value):
    return [[ {'label': i, 'value': i} for i in myDict[value] ], myDict[value][default_index]]

if __name__ == '__main__':
    app.run_server(debug=False)