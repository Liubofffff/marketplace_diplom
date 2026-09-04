#!/usr/bin/env python3
# Загрузка исторических данных
import sys
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
        print(f"Запуск load_day.py для даты: {date_str}")
        result = subprocess.run(
            [sys.executable, script_path, date_str],
            capture_output=True,
            text=True,
            check=False
        )

        # Выводим stdout и stderr
        if result.stdout:
            print(result.stdout)
        if result.stderr:
            print(result.stderr, file=sys.stderr)

        if result.returncode != 0:
            print(f"Ошибка при выполнении для даты {date_str}. Код возврата: {result.returncode}")
            return False
        return True

    except FileNotFoundError:
        print(f"Ошибка: Файл {script_path} не найден")
        sys.exit(1)
    except Exception as e:
        print(f"Ошибка при запуске: {e}")
        return False


def main():
    # Период, за который нужны данные
    start_date_str = '2023-12-30'
    end_date_str = '2023-12-30'

    # Преобразуем строки в datetime объекты
    start_date = datetime.strptime(start_date_str, '%Y-%m-%d')
    end_date = datetime.strptime(end_date_str, '%Y-%m-%d')

    date_list = generate_date_range(start_date, end_date)
    print(f"Будет обработано {len(date_list)} дней: с {start_date_str} по {end_date_str}")
    print("-" * 50)

    success_count = 0
    error_count = 0

    for i, date_str in enumerate(date_list, 1):
        print(f"\n[{i}/{len(date_list)}] Обработка даты: {date_str}")
        success = run_load_day(date_str)

        if success:
            success_count += 1
        else:
            error_count += 1

    # Выводим статистику после цикла
    print("\n" + "=" * 50)
    print(f"Итоги выполнения:")
    print(f"  Успешно: {success_count}")
    print(f"  С ошибками: {error_count}")
    print(f"  Всего обработано: {success_count + error_count}")

    if error_count > 0:
        print("❌ Есть ошибки при выполнении!")
        sys.exit(1)
    else:
        print("✅ Все даты обработаны успешно!")


if __name__ == "__main__":
    main()
