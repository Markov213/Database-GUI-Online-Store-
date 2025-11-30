import streamlit as st
import mysql.connector
import pandas as pd

# -------------------- DATABASE CONNECTION --------------------
def get_connection():
    return mysql.connector.connect(
        host="den1.mssql8.gear.host", # this is a localhost on my device
        user="onlinestore5",
        password="Sa73aw~~29RD",        
        database="onlinestore5", 
        port=3306               
    )

# -------------------- SIDEBAR --------------------
st.sidebar.title("📦 Online Store Dashboard")
menu = st.sidebar.radio("Navigate", ["Home", "Insert Data", "View Data", "Run Queries"])

# -------------------- HOME --------------------
if menu == "Home": # Home Page there is nothing important here fellas
    st.title("Welcome to Online Store Dashboard")
    st.write("Use the sidebar to insert data, view tables, or run queries.")

# -------------------- INSERT DATA --------------------
elif menu == "Insert Data":
    st.header("Insert New Records")
    option = st.selectbox("Choose Table", [
        "Customers", "Departments", "Employees", "Orders",
        "Categories", "Products", "Vendor", "Warehouse",
        "Order_Details", "Contain", "Sell"
    ])
    # we open a connection and cursor to execute queries and start sending or data to the database on our server
    conn = get_connection()
    cursor = conn.cursor()

    # -------------------- Customers --------------------
    if option == "Customers":
        fname = st.text_input("First Name")
        lname = st.text_input("Last Name")
        gender = st.selectbox("Gender", ["M", "F"])
        status = st.text_input("Status")
        email = st.text_input("Email")
        phone = st.text_input("Phone")
        address = st.text_input("Address")
        birth_date = st.date_input("Birth Date")
        reg_date = st.date_input("Registration Date")

        if st.button("Insert Customer"):
            cursor.execute("""
                INSERT INTO Customers (First_Name, Last_Name, Gender, Status, Email, phone, Address, Birth_Date, Registeration_Date)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
            """, (fname, lname, gender, status, email, phone, address, birth_date, reg_date))
            conn.commit()
            st.success("✅ Customer inserted successfully!")

    # -------------------- Departments --------------------
    elif option == "Departments":
        dep_name = st.text_input("Department Name")
        # we here run a query to get all the employee IDs to choose a manager from them
        cursor.execute("SELECT ID FROM Employees")
        managers = [row[0] for row in cursor.fetchall()]
        mgr_id = st.selectbox("Manager ID", managers)

        if st.button("Insert Department"):
            cursor.execute("""
                INSERT INTO Departments (Dep_Name, Mgr_ID) VALUES (%s,%s)
            """, (dep_name, mgr_id))
            conn.commit()
            st.success("✅ Department inserted successfully!")

    # -------------------- Employees --------------------
    elif option == "Employees":
        fname = st.text_input("First Name")
        lname = st.text_input("Last Name")
        status = st.text_input("Status")
        salary = st.number_input("Salary", min_value=0.0)
        email = st.text_input("Email")
        gender = st.selectbox("Gender", ["Male", "Female"])
        attribute = st.text_input("Attribute")
        cursor.execute("SELECT ID FROM Employees")
        supervisors = [row[0] for row in cursor.fetchall()]
        super_id = st.selectbox("Supervisor ID", [None] + supervisors)
        cursor.execute("SELECT ID FROM Departments")
        departments = [row[0] for row in cursor.fetchall()]
        dep_id = st.selectbox("Department ID", [None] + departments)
        phone = st.text_input("Phone")
        address = st.text_input("Address")
        birth_date = st.date_input("Birth Date")
        hire_date = st.date_input("Hire Date")

        if st.button("Insert Employee"):
            cursor.execute("""
                INSERT INTO Employees (Status, Salary, First_Name, Last_Name, Email, Gender, Attribute, Super_ID, Phone, Dep_ID, Address, Birth_Date, Hire_Date)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            """, (status, salary, fname, lname, email, gender, attribute, super_id, phone, dep_id, address, birth_date, hire_date))
            conn.commit()
            st.success("✅ Employee inserted successfully!")

    # -------------------- Orders --------------------
    elif option == "Orders":
        amount = st.number_input("Amount", min_value=0)
        order_date = st.date_input("Order Date")
        delivery_date = st.date_input("Delivery Date")
        status = st.selectbox("Status", ["Pending", "Delivered"])
        cursor.execute("SELECT ID FROM Customers")
        customers = [row[0] for row in cursor.fetchall()]
        customer_id = st.selectbox("Customer ID", customers)
        cursor.execute("SELECT ID FROM Employees")
        employees = [row[0] for row in cursor.fetchall()]
        delivery_id = st.selectbox("Delivery Employee ID", employees)

        if st.button("Insert Order"):
            cursor.execute("""
                INSERT INTO Orders (Amount, Order_Date, Delivery_Date, Status, Customer_ID, Delivery_ID)
                VALUES (%s,%s,%s,%s,%s,%s)
            """, (amount, order_date, delivery_date, status, customer_id, delivery_id))
            conn.commit()
            st.success("✅ Order inserted successfully!")

    # -------------------- Categories --------------------
    elif option == "Categories":
        name = st.text_input("Category Name")
        description = st.text_area("Description")

        if st.button("Insert Category"):
            cursor.execute("""
                INSERT INTO Categories (Name, Description) VALUES (%s,%s)
            """, (name, description))
            conn.commit()
            st.success("✅ Category inserted successfully!")

    # -------------------- Products --------------------
    elif option == "Products":
        name = st.text_input("Product Name")
        price = st.number_input("Price", min_value=0.0)
        quantity = st.number_input("Quantity", min_value=0)
        cursor.execute("SELECT ID FROM Categories")
        categories = [row[0] for row in cursor.fetchall()]
        category_id = st.selectbox("Category ID", categories)
        status = st.selectbox("Status", ["Available", "Out of Stock"])

        if st.button("Insert Product"):
            cursor.execute("""
                INSERT INTO Products (Name, Price, Quantity, Category_ID, Status)
                VALUES (%s,%s,%s,%s,%s)
            """, (name, price, quantity, category_id, status))
            conn.commit()
            st.success("✅ Product inserted successfully!")

    # -------------------- Vendor --------------------
    elif option == "Vendor":
        fname = st.text_input("First Name")
        lname = st.text_input("Last Name")
        email = st.text_input("Email")
        address = st.text_input("Address")
        phone = st.text_input("Phone")

        if st.button("Insert Vendor"):
            cursor.execute("""
                INSERT INTO Vendor (First_Name, Last_Name, Email, Address, Phone)
                VALUES (%s,%s,%s,%s,%s)
            """, (fname, lname, email, address, phone))
            conn.commit()
            st.success("✅ Vendor inserted successfully!")

    # -------------------- Warehouse --------------------
    elif option == "Warehouse":
        name = st.text_input("Warehouse Name")
        location = st.text_input("Location")
        capacity = st.number_input("Capacity", min_value=0)

        if st.button("Insert Warehouse"):
            cursor.execute("""
                INSERT INTO Warehouse (Name, Location, Capacity)
                VALUES (%s,%s,%s)
            """, (name, location, capacity))
            conn.commit()
            st.success("✅ Warehouse inserted successfully!")

    # -------------------- Order_Details --------------------
    elif option == "Order_Details":
        cursor.execute("SELECT ID FROM Orders")
        orders = [row[0] for row in cursor.fetchall()]
        cursor.execute("SELECT ID FROM Products")
        products = [row[0] for row in cursor.fetchall()]
        order_id = st.selectbox("Order ID", orders)
        product_id = st.selectbox("Product ID", products)
        quantity = st.number_input("Quantity", min_value=1)
        price = st.number_input("Price", min_value=0.0)

        if st.button("Insert Order Detail"):
            cursor.execute("""
                INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
                VALUES (%s,%s,%s,%s)
            """, (order_id, product_id, quantity, price))
            conn.commit()
            st.success("✅ Order Detail inserted successfully!")
            
    elif option == "Order_Details":
        cursor.execute("SELECT ID, Name FROM Products")
        products = cursor.fetchall()
        product_options = {name: pid for pid, name in products}

        order_id = st.number_input("Order ID", min_value=1)
        selected_products = st.multiselect("Select Products", list(product_options.keys()))

        if st.button("Insert Order Details"):
            for product_name in selected_products:
                product_id = product_options[product_name]
                quantity = st.number_input(f"Quantity for {product_name}", min_value=1)
                cursor.execute("""
                    INSERT INTO Order_Details (Order_ID, Product_ID, Quantity)
                    VALUES (%s, %s, %s)
                """, (order_id, product_id, quantity))
            conn.commit()
            st.success("✅ Products added to order successfully!")


    # -------------------- Contain --------------------
    elif option == "Contain":
        cursor.execute("SELECT ID FROM Categories")
        categories = [row[0] for row in cursor.fetchall()]
        cursor.execute("SELECT ID FROM Warehouse")
        warehouses = [row[0] for row in cursor.fetchall()]
        cursor.execute("SELECT ID FROM Products")
        products = [row[0] for row in cursor.fetchall()]
        category_id = st.selectbox("Category ID", categories)
        warehouse_id = st.selectbox("Warehouse ID", warehouses)
        product_id = st.selectbox("Product ID", products)
        quantity = st.number_input("Quantity", min_value=1)

        if st.button("Insert Contain"):
            cursor.execute("""
            INSERT INTO Contain (Category_ID, Warehouse_ID, Product_ID, Quantity)
            VALUES (%s,%s,%s,%s)
        """, (category_id, warehouse_id, product_id, quantity))
        conn.commit()
        st.success("✅ Contain record inserted successfully!")

    # -------------------- Sell --------------------
    elif option == "Sell":
        cursor.execute("SELECT ID FROM Products")
        products = [row[0] for row in cursor.fetchall()]
        cursor.execute("SELECT ID FROM Categories")
        categories = [row[0] for row in cursor.fetchall()]
        cursor.execute("SELECT ID FROM Vendor")
        vendors = [row[0] for row in cursor.fetchall()]

        product_id = st.selectbox("Product ID", products)
        category_id = st.selectbox("Category ID", categories)
        vendor_id = st.selectbox("Vendor ID", vendors)
        quantity = st.number_input("Quantity", min_value=1)
        date = st.date_input("Date")
        price = st.number_input("Price", min_value=0.0)

        if st.button("Insert Sell"):
            cursor.execute("""
                INSERT INTO Sell (Product_ID, Category_ID, Vendor_ID, Quantity, Date, Price)
                VALUES (%s,%s,%s,%s,%s,%s)
            """, (product_id, category_id, vendor_id, quantity, date, price))
            conn.commit()
            st.success("✅ Sell record inserted successfully!")

    conn.close()
    
elif menu == "View Data":
    st.header("View Tables")
    table = st.selectbox("Select Table", [
        "Customers", "Departments", "Employees", "Orders",
        "Categories", "Products", "Vendor", "Warehouse",
        "Order_Details", "Contain", "Sell"
    ])
    try:
        conn = get_connection()
        df = pd.read_sql(f"SELECT * FROM {table}", conn)
        st.dataframe(df)
        conn.close()
    except Exception as e:
        st.error(f"❌ Error: {e}")


elif menu == "Run Queries":
    st.header("Run Custom SQL Query")
    query = st.text_area("Enter your SQL query:")
    if st.button("Execute"):
        try:
            conn = get_connection()
            df = pd.read_sql(query, conn)
            st.dataframe(df)
            conn.close()
        except Exception as e:
            st.error(f"❌ Error: {e}")

