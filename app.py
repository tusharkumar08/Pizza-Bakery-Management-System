import mysql.connector

# mydb = mysql.connector.connect(
#     host = "localhost",
#     user = "root",
#     password = ""
# )

# c = mydb.cursor()

import streamlit as st
from database import create_table
from functions import delete, create, update, query


mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="pizzabakery_pes1ug20cs473"
)

c = mydb.cursor()
c.execute("USE pizzabakery_pes1ug20cs473")
c.close()


def main():
    st.title("Pizza Bakery")
    # menu = ["Add", "View", "Edit", "Remove"]
    menu = ["Add", "Edit", "Remove", "Misc Queries"]
    choice = st.sidebar.selectbox("Menu", menu)
    # create_table()
    if choice == "Add":
        st.subheader("Enter details:")
        create()
    elif choice == "Misc Queries":
        st.subheader("Enter any query -")
        query()
    elif choice == "Edit":
        st.subheader("Update tasks")
        update()
    elif choice == "Remove":
        st.subheader("Delete tasks")
        delete()
    else:
        st.subheader("About tasks")


if __name__ == '__main__':
    main()
