import psycopg2


# Класс для работы с PostgreSQL базой данных
class PGDatabase:
    # Соединение с БД и настройка курсора
    def __init__(self, host, database, user, password):
        self.host = host
        self.database = database
        self.user = user
        self.password = password

        self.connection = psycopg2.connect(
            host=host,
            database=database,
            user=user,
            password=password
        )

        self.cursor = self.connection.cursor()
        self.connection.autocommit = True

    # массовая вставка данных из массива
    def post_many(self, query, data_list):
        try:
            self.cursor.executemany(query, data_list)
            if self.connection.autocommit:
                return self.cursor.rowcount
            else:
                self.connection.commit()
                return self.cursor.rowcount
        except Exception as err:
            if not self.connection.autocommit:
                self.connection.rollback()
            print(repr(err))
            return 0
