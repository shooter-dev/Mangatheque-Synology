#!/usr/bin/env python
# -*- coding: utf8 -*-

import sys
import cgi
import logging
import psycopg2

from config import config

logging.getLogger().setLevel(logging.INFO)
    
def convertToJson(mapping, values):
    logging.info("Converting result to json file")
    json = '{"result":['
    total = 0

    for item in values:
        if total > 0:
            json += ','
        
        json += '{'

        for i in range(len(item)):
            if i > 0:
                json += ','
                
            if mapping[i]["type"] == 'int':
                json += '"' + mapping[i]["name"] + '":' + str(item[i])
            else:
                json += '"' + mapping[i]["name"] + '":"' + item[i] + '"'
            
        json += '}'
        total += 1
    
    json += '],"success":true,"total": '+str(total)+'}'
    logging.info("json file" + json)

    return json
    
def generateSelectRequest(table, columns):
    logging.info("Creating select request")
    i = 0
    request = 'SELECT '
    for item in columns:
        if i > 0:
            request += ','

        request += columns[i]["name"]
        i += 1

    request += ' FROM ' + table

    logging.info("Generated request: " + request)
    
    return request

def process(params, table, columns):
    logging.info("'execute' method.")
    logging.info("Retrieval of DB connection")

    logging.info("Establish connection to postgresql db")
    connection = psycopg2.connect(**params)

    request = generateSelectRequest(table, columns)

    cur = connection.cursor()
    cur.execute(request)
    magazines = cur.fetchall()

    json = convertToJson(columns, magazines)
    
    cur.close()
    connection.close()
    
    return json
    
# Request pattern
# http://HOST:PORT/webapi/mangatheque/mangatheque.cgi?list=recipes
def extractParameters():
    parameters = cgi.FieldStorage()
    logging.info(parameters)
    
    requestParameters = None
    
    if parameters != None:
        logging.info("Retrieve list parameter")
        identifier = parameters.getvalue("list")
        
        logging.info("Retrieve parameters according to request type")
        if identifier != None:
            requestParameters = REQUEST_PARAMETER[identifier]
            logging.info(requestParameters)
    
    return requestParameters

logging.info("Started...")
logging.info("Initializing...")

REQUEST_PARAMETER = { 
    "recipes": { "table": "t_recipe", "columns": [{"name":"identifier", "type": "int"}, {"name":"title", "type": "string"}, {"name":"description", "type": "string"}] },
    "magazines": { "table": "t_magazine", "columns": [{"name":"identifier", "type": "int"}, {"name":"title", "type": "string"}, {"name":"description", "type": "string"}] },
    "editeurs": {  "table": "Editeurs", "columns": [{ "name":"id", "type": "int"}, { "name":"name", "type": "string" }, { "name":"cover", "type": "string" }] },
    "genres": { "table": "Genres", "columns": [{ "name":"id", "type": "int" }, { "name":"name", "type": "string" }, { "name":"cover", "type": "string" }] },
    "types": { "table": "Types", "columns": [{ "name":"id", "type": "int" }, { "name":"name", "type": "string" }, { "name":"cover", "type": "string" }] },
    "personnes": { "table": "Personnes", "columns": [{ "name":"id", "type": "int"}, { "name":"name", "type": "string" }, { "name":"firstname", "type": "string" }, { "name":"sex", "type": "char" }, { "name":"naissance", "type": "string" }, { "name":"cover", "type": "string" }] },
    "series": { "table": "Series",  "columns": [{ "name":"id", "type": "int"}, { "name":"name", "type": "string" }, { "name":"volumes", "type": "float" }, { "name":"cover", "type": "string" }] },
    "tomes": { "table": "Tomes", "columns": [{ "name":"code", "type": "string" }, { "name":"name", "type": "string" }, { "name":"volumes", "type": "float" }, { "name":"pages", "type": "int" }, { "name":"date_VF", "type": "string" }, { "name":"date_VO", "type": "string" }, { "name":"resumer", "type": "string" }, { "name":"cover", "type": "string" }] }
}

logging.info("Load configuration file")
db_parameters = config()

logging.info("Extracting parameters...")
url_parameters = extractParameters()

if url_parameters != None:
    logging.info("Processing request...")
    body = process(db_parameters, url_parameters["table"], url_parameters["columns"])
    logging.info("Finished...")
else:
    logging.info("Invalid parameters...")

print("Context-Type: application/json")
print
print(body)
