from flask import Flask, jsonify, request
from flask_restful import Resource, Api, reqparse

import pandas as pd
import numpy as np

app = Flask(__name__)
api = Api(app)

# constructors -> 

class add(Resource):
    def post(self):
        add_data = request.get_json()
        addition = sum(list(add_data.values()))
        return addition

# assign addition endpoint
api.add_resource(add, '/add')

class subtract(Resource):
    def post(self):
        sub_data = request.get_json()
        sub_list = list(sub_data.values())
        subtraction = []
        for number in range(len(sub_list)-1):
            temp_num = sub_list[number] - sub_list[number+1]
            subtraction.append(temp_num)
        return subtraction

# assign addition endpoint
api.add_resource(subtract, '/subtract')