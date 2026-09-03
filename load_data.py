#!.venv/bin/python

import configparser
from datetime import date, timedelta
from pprint import pprint

import requests

config = configparser.ConfigParser()
config.read('config.ini')
apiUrl = config['API']['url']

#yesterday = (date.today() - timedelta(days=1)).isoformat()
yesterday = date(2022, 1, 1)
response = requests.get(apiUrl, params={"date": yesterday})
pprint(response.json()[:5])