#!.venv/bin/python
# Загрузка предыдущего дня
from sys import argv, exit
from dotenv import load_dotenv
from os import getenv
import configparser
from datetime import date, timedelta
from pgdb import PGDatabase
import requests

load_dotenv()

# берём данные из конфига
config = configparser.ConfigParser()
config.read('config.ini')
apiUrl = config['API']['url']

# проверяем передан ли скрипту аргумент с датой
if len(argv) > 1:
    yesterday = argv[1]
# если нет - используем вчерашний день
else:
    yesterday = (date.today() - timedelta(days=1)).isoformat()

# запрашиваем данные через API
response = requests.get(apiUrl, params={'date': yesterday})

if response.status_code != 200:
    exit(f"Ошибка получения данных за {yesterday}")

# создаём подключение к базе данных
db = PGDatabase(
    host=config['Database']['host'],
    database=config['Database']['name'],
    user=config['Database']['user'],
    password=getenv('POSTGRES_PASSWORD'),
)

# определяем SQL-запрос с параметрами
SQL_QUERY = """
    INSERT INTO sales 
    (client_id, discount_per_item, gender, price_per_item, product_id, purchase_datetime, 
    purchase_time_as_seconds_from_midnight, quantity, total_price)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# заполняем данные для массовой вставки
data_to_insert = []
for item in response.json():
    values = (
        item['client_id'],
        item['discount_per_item'],
        item['gender'],
        item['price_per_item'],
        item['product_id'],
        item['purchase_datetime'],
        item['purchase_time_as_seconds_from_midnight'],
        item['quantity'],
        item['total_price']
    )
    data_to_insert.append(values)

# вставляем данные и выводим результат
rows_inserted = db.post_many(SQL_QUERY, data_to_insert)
print(f"Данные за: {yesterday}. Вставлено строк: {rows_inserted}")
