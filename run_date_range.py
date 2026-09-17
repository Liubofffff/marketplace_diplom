#!.venv/bin/python
# Загрузка исторических данных
import sys
import logging
import subprocess
from datetime import datetime, timedelta


def generate_date_range(start_date, end_date):
    """Генерирует список дат между start_date и end_date включительно"""
    dates = []
    current = start_date
    while current <= end_date:
        dates.append(current.strftime('%Y-%m-%d'))
        current += timedelta(days=1)
    return dates


def run_load_day(date_str, script_path='load_day.py'):
    try:
        logging.info(f"Запуск load_day.py для даты: {date_str}")
        result = subprocess.run(
            [sys.executable, script_path, date_str],
            capture_output=True,
            text=True,
            check=False,
            timeout=180  # таймаут 3 минуты
        )

        # Выводим stdout и stderr
        if result.stdout:
            logging.info(result.stdout)
        if result.stderr:
            logging.info(result.stderr)

        if result.returncode != 0:
            logging.error(f"Ошибка при выполнении для даты {date_str}. Код возврата: {result.returncode}")
            return False
        return True

    except FileNotFoundError:
        logging.error(f"Ошибка: Файл {script_path} не найден")
        sys.exit(1)
    except Exception as e:
        logging.error(f"Ошибка при запуске: {e}")
        return False


def main():
    # Период, за который нужны данные
    start_date_str = '2022-01-01'
    end_date_str = '2026-09-15'

    # дефолтные настройки логирования
    logging.basicConfig(filename="loader.log")

    # Преобразуем строки в datetime объекты
    start_date = datetime.strptime(start_date_str, '%Y-%m-%d')
    end_date = datetime.strptime(end_date_str, '%Y-%m-%d')

    date_list = generate_date_range(start_date, end_date)
    logging.info(f"Будет обработано {len(date_list)} дней: с {start_date_str} по {end_date_str}")
    logging.info("-" * 50)

    success_count = 0
    error_count = 0

    for i, date_str in enumerate(date_list, 1):
        logging.info(f"\n[{i}/{len(date_list)}] Обработка даты: {date_str}")
        success = run_load_day(date_str)

        if success:
            success_count += 1
        else:
            error_count += 1

    # Выводим статистику после цикла
    logging.info("\n" + "=" * 50)
    logging.info(f"Итоги выполнения:")
    logging.info(f"  Успешно: {success_count}")
    logging.info(f"  С ошибками: {error_count}")
    logging.info(f"  Всего обработано: {success_count + error_count}")

    if error_count > 0:
        logging.error("Есть ошибки при выполнении!")
        sys.exit(1)
    else:
        logging.info("✅ Все даты обработаны успешно!")


if __name__ == "__main__":
    main()
