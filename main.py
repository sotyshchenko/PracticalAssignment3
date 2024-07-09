import mysql.connector
from mysql.connector import Error
import uuid
import os
from dotenv import load_dotenv
from faker import Faker
import random

# Load environment variables
load_dotenv()

# Connection settings
HOST = os.getenv('HOST')  # Your MySQL host
USER = os.getenv('USER')  # Your MySQL username
PASSWORD = os.getenv('PASSWORD')  # Your MySQL password
DATABASE = os.getenv('DATABASE')  # Your MySQL database name

# Initialize Faker
fake = Faker()

def create_connection():
    """Create a database connection"""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='password',
            database='bookrestaurant_db'
        )
        if connection.is_connected():
            print("Connection to MySQL DB successful")
        return connection
    except Error as e:
        print(f"The error '{e}' occurred")
        return None

def execute_many_queries(connection, query, data, table_name):
    """Execute multiple queries"""
    cursor = connection.cursor()
    try:
        print(f"Inserting into {table_name}...")
        cursor.executemany(query, data)
        connection.commit()
        print(f"Inserted into {table_name}.")
    except Error as e:
        print(f"The error '{e}' occurred")

def insert_data():
    connection = create_connection()

    if connection is None:
        return

    # Insert data into customers table
    customer_insert_query = """
    INSERT INTO customers (id, first_name, last_name, email, phone, birth_date, regular) 
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    customers_data = [
        (str(uuid.uuid4()), fake.first_name(), fake.last_name(), fake.email(), fake.phone_number(), fake.date_of_birth(minimum_age=18, maximum_age=80), random.choice([True, False]))
        for _ in range(100000)
    ]
    execute_many_queries(connection, customer_insert_query, customers_data, "customers")

    # Insert data into employees table
    employee_insert_query = """
    INSERT INTO employees (id, first_name, last_name, email, phone, birth_date, position) 
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    positions = ['Manager', 'Cashier', 'Chef', 'Waiter', 'Cleaner']
    employees_data = [
        (str(uuid.uuid4()), fake.first_name(), fake.last_name(), fake.email(), fake.phone_number(), fake.date_of_birth(minimum_age=18, maximum_age=65), random.choice(positions))
        for _ in range(10000)
    ]
    execute_many_queries(connection, employee_insert_query, employees_data, "employees")

    shifts_insert_query = """
        INSERT INTO shifts (shift_id, shift_name, start_time, end_time) 
        VALUES (%s, %s, %s, %s)
        """
    shifts_data = [
        (str(uuid.uuid4()), fake.word(), fake.time(), fake.time())
        for _ in range(30000)
    ]
    execute_many_queries(connection, shifts_insert_query, shifts_data, "shifts")

    # Insert data into salaries table
    salaries_insert_query = """
        INSERT INTO salary (employee_id, salary_amount, salary_date) 
        VALUES (%s, %s, %s)
        """
    salaries_data = [
        (employee[0], round(random.uniform(1000, 10000), 2), fake.date_this_year())
        for employee in employees_data
    ]

    execute_many_queries(connection, salaries_insert_query, salaries_data, "salary")

    # Insert data into authors table
    author_insert_query = """
    INSERT INTO authors (id, first_name, last_name, biography) 
    VALUES (%s, %s, %s, %s)
    """
    authors_data = [
        (str(uuid.uuid4()), fake.first_name(), fake.last_name(), fake.text(max_nb_chars=200))
        for _ in range(15000)
    ]
    execute_many_queries(connection, author_insert_query, authors_data, "authors")

    # Insert data into books table
    book_insert_query = """
    INSERT INTO books (id, title, genre, price, isbn, publication_year) 
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    genres = ['Dystopian', 'Fantasy', 'Science Fiction', 'Non-Fiction', 'Mystery']
    books_data = [
        (str(uuid.uuid4()), fake.catch_phrase(), random.choice(genres), round(random.uniform(5.99, 29.99), 2), fake.isbn13(), fake.year())
        for _ in range(400000)
    ]
    execute_many_queries(connection, book_insert_query, books_data, "books")

    # Insert data into authors_books table
    authors_books_query = """
    INSERT INTO authors_books (author_id, book_id) 
    VALUES (%s, %s)
    """
    authors_books_data = [
        (random.choice(authors_data)[0], random.choice(books_data)[0])
        for _ in range(40000)
    ]
    execute_many_queries(connection, authors_books_query, authors_books_data, "authors_books")

    # Insert data into book_orders table
    book_orders_query = """
    INSERT INTO book_orders (id, book_id, customer_id, handled_by, order_date, status) 
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    order_statuses = ['Completed', 'Pending', 'Cancelled']
    book_orders_data = [
        (str(uuid.uuid4()), random.choice(books_data)[0], random.choice(customers_data)[0], random.choice(employees_data)[0], fake.date_this_year(), random.choice(order_statuses))
        for _ in range(100000)
    ]
    execute_many_queries(connection, book_orders_query, book_orders_data, "book_orders")

    # Insert data into menu_categories table
    menu_categories_query = """
    INSERT INTO menu_categories (id, name, description) 
    VALUES (%s, %s, %s)
    """
    category_names = ['Appetizers', 'Entrees', 'Sides', 'Desserts', 'Beverages']
    menu_categories_data = [
        (str(uuid.uuid4()), name, fake.text(max_nb_chars=100))
        for name in category_names
    ]
    execute_many_queries(connection, menu_categories_query, menu_categories_data, "menu_categories")

    execute_many_queries(connection, menu_categories_query, menu_categories_data, "menu_categories")

    # Insert data into menu table
    menu_query = """
    INSERT INTO menu (id, name, description, price, category_id, is_vegan, is_gluten_free, ingredients, date_added, is_available, preparation_time, calories, image_url, spicy_level, allergens) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    spicy_levels = [0, 1, 2, 3]
    menu_data = [
        (str(uuid.uuid4()), fake.word(), fake.text(max_nb_chars=200), round(random.uniform(5.99, 25.99), 2), random.choice(menu_categories_data)[0], fake.boolean(), fake.boolean(), ' '.join(fake.words(nb=5)), fake.date_this_year(), fake.boolean(), random.randint(5, 30), random.randint(100, 900), fake.image_url(), random.choice(spicy_levels), ' '.join(fake.words(nb=3)))
        for _ in range(50)
    ]
    execute_many_queries(connection, menu_query, menu_data, "menu")

    # Insert data into menu_orders table
    menu_orders_query = """
    INSERT INTO menu_orders (id, order_date, customer_id, menu_id, quantity, employee_id, order_status) 
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    menu_orders_data = [
        (str(uuid.uuid4()), fake.date_time_this_year(), random.choice(customers_data)[0], random.choice(menu_data)[0], random.randint(1, 10), random.choice(employees_data)[0], random.choice(order_statuses))
        for _ in range(200)
    ]
    execute_many_queries(connection, menu_orders_query, menu_orders_data, "menu_orders")

    connection.close()

if __name__ == "__main__":
    insert_data()
