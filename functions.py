import pandas as pd 
import streamlit as st
from database import create_table, add_data, view_table, edit_details, delete_data, show_tables, get_attribute, misc_query


tables = {
	'InstoreStaff' : {'StaffId' : 1, 'fName' : 1, 'lName' : 1, 'ADDRESS' : 1, 'ContactNo' : 1,'taxFileNo' : 1, 'BankCode' : 1, 'bName': 1, 'accNo': 1, 'Status': 1, 'HourlyRate': 1},
	'Customer'   : {'CustomerID' : 1, 'firstName' : 1, 'lastName' : 1, 'Address' : 1, 'phoneNumber' : 1, 'isHoax' : 1},
	'Orders' : {'OrderNo' : 1, 'OrderDateTime' : 1, 'OrderType': 1, 'TotalAmountDue': 0, 'PaymentMethod': 1, 'PaymentApprovalNo': 1, 'OrderStatus': 1, 'CustomerID': 1, 'StaffId': 1},
	'MenuSellingPrice' : {'CurrentSellingPrice' : 1, 'Small' : 1, 'Medium' : 1, 'Large' : 1},
	'MenuItem' : {'ItemCode' : 1, 'Name' : 1, 'Size' : 1, 'Price' : 1, 'CurrentSellingPrice' : 1, 'Description' : 1},
	'InstorePayRecord' : {'TotalAmountPaid' : 1, 'GrossPayment' : 1, 'TaxWithheld': 1},
	'InstorePay' : {'RecordId' : 1, 'TotalAmountPaid' : 1, 'DatePayment' : 1, 'PeriodStartDate' : 1, 'PeriodEndDate' : 1},
	'InstoreShift' : {'RecordId' : 1, 'StartDate' : 1, 'StartTime' : 1, 'EndDate' : 1, 'EndTime': 1, 'StaffId': 1, 'InstorePayRecordId': 1}
}

primary_keys = {'InstoreStaff' : ['StaffId'], 'Customer' : ['CustomerID'], 'Orders' : ['OrderNo'], 'MenuSellingPrice' : ['CurrentSellingPrice'], 'MenuItem' : ['ItemCode'], 'InstorePayRecord' : ['TotalAmountPaid'], 'InstorePay' : ['RecordId'], 'InstoreShift' : ['RecordId']}

def delete():
	list_of_tables = tables.keys()
	list_of_tables = [i for i in list_of_tables]
	selected_table = st.selectbox("Select Table", list_of_tables)

	result = view_table(selected_table, list(tables[selected_table].keys()))
	df = pd.DataFrame(result, columns=list(tables[selected_table].keys()))
	with st.expander("Current Data"):
		st.dataframe(df)

	to_delete_items = {}
	for column in primary_keys[selected_table]:
		list_of_items = [i[0] for i in view_table(selected_table, list([column]))]

		if(tables[selected_table][column] != 0):
			selected_item = str(st.selectbox(column + " to delete", list_of_items))
			selected_item = '\'' + selected_item + '\''
		else:
			selected_item = str(st.selectbox(column + " to delete", list_of_items))

		to_delete_items[column] = selected_item

	st.warning("Are you sure you want to delete?")
	if st.button("Delete"):
		err = delete_data(selected_table, primary_keys[selected_table], list(to_delete_items.values()))
		if(err != ''):
			st.warning(err)
		else:
			st.success("Item has been deleted successfully")

	new_result = view_table(selected_table, list(tables[selected_table].keys()))
	df2 = pd.DataFrame(new_result, columns=list(tables[selected_table].keys()))
	with st.expander("Updated Data"):
		st.dataframe(df2)

def create():
	list_of_tables = tables.keys()
	list_of_tables = [i for i in list_of_tables]
	selected_table = st.selectbox("Select Table", list_of_tables)

	result = view_table(selected_table, list(tables[selected_table].keys()))
	df = pd.DataFrame(result, columns=list(tables[selected_table].keys()))
	with st.expander("Current Data"):
		st.dataframe(df)

	to_insert = {}

	col1, col2 = st.columns(2)
	with col1:
		for i in range(0,len(list(tables[selected_table].keys())), 2):
			selected_item = st.text_input(list(tables[selected_table].keys())[i])
			if(tables[selected_table][list(tables[selected_table].keys())[i]] != 0):
				selected_item = '\'' + selected_item + '\''

			to_insert[list(tables[selected_table].keys())[i]] = selected_item

	with col2:
		for i in range(1,len(list(tables[selected_table].keys())), 2):
			selected_item = st.text_input(list(tables[selected_table].keys())[i])
			if(tables[selected_table][list(tables[selected_table].keys())[i]] != 0):
				selected_item = '\'' + selected_item + '\''

			to_insert[list(tables[selected_table].keys())[i]] = selected_item

	to_insert_list = []
	for column in list(tables[selected_table].keys()):
		to_insert_list.append(to_insert[column])

	if(st.button("Add Data")):
		err = add_data(selected_table, to_insert_list)
		if(err != ''):
			st.warning(err)
		else:
			st.success("Successfully added data!")

	new_result = view_table(selected_table, list(tables[selected_table].keys()))
	df2 = pd.DataFrame(new_result, columns=list(tables[selected_table].keys()))
	with st.expander("Updated Data"):
		st.dataframe(df2)

def update():
	list_of_tables = tables.keys()
	list_of_tables = [i for i in list_of_tables]
	selected_table = st.selectbox("Select Table", list_of_tables)

	result = view_table(selected_table, list(tables[selected_table].keys()))
	df = pd.DataFrame(result, columns=list(tables[selected_table].keys()))
	with st.expander("Current Data"):
		st.dataframe(df)

	to_update_keys = {}
	for column in primary_keys[selected_table]:
		list_of_items = [i[0] for i in view_table(selected_table, list([column]))]

		if(tables[selected_table][column] != 0):
			selected_item = str(st.selectbox(column + " to modify", list_of_items))
			selected_item = '\'' + selected_item + '\''
		else:
			selected_item = str(st.selectbox(column + " to modify", list_of_items))

		to_update_keys[column] = selected_item

	to_change_list = []
	for column in list(tables[selected_table].keys()):
		if column not in list(primary_keys[selected_table]):
			to_change_list.append(column)

	to_insert = {}

	col1, col2 = st.columns(2)
	with col1:
		for i in range(0,len(to_change_list), 2):
			default = get_attribute(selected_table, primary_keys[selected_table], list(to_update_keys.values()), to_change_list[i])
			if(len(default) == 0):
				default = ''
			else:
				default = default[0][0]
			selected_item = st.text_input(list(to_change_list)[i], value = default)

			if(tables[selected_table][list(to_change_list)[i]] != 0):
				selected_item = '\'' + selected_item + '\''

			to_insert[list(to_change_list)[i]] = selected_item

	with col2:
		for i in range(1,len(to_change_list), 2):
			default = get_attribute(selected_table, primary_keys[selected_table], list(to_update_keys.values()), to_change_list[i])
			if(len(default) == 0):
				default = ''
			else:
				default = default[0][0]
			selected_item = st.text_input(list(to_change_list)[i], value = default)
			if(tables[selected_table][list(to_change_list)[i]] != 0):
				selected_item = '\'' + selected_item + '\''

			to_insert[list(to_change_list)[i]] = selected_item

	to_insert_list = []
	for column in list(to_change_list):
		to_insert_list.append(to_insert[column])

	if st.button("Update Data"):
		err = edit_details(selected_table, to_change_list, to_insert_list, primary_keys[selected_table], list(to_update_keys.values()))
		if(err != ''):
			st.warning(err)
		else:
			st.success("Successfully updated the data")

	new_result = view_table(selected_table, list(tables[selected_table].keys()))
	df2 = pd.DataFrame(new_result, columns=list(tables[selected_table].keys()))
	with st.expander("Updated Data"):
		st.dataframe(df2)

def query():
	command = st.text_area("Enter any Query here - ")
	if(st.button("Submit Query")):
		err, message = misc_query(command)
		if(err):
			st.warning(message)
		else:
			df = pd.DataFrame(message)
			with st.expander("Result"):
				st.dataframe(df)

# def login_screen():
# 	user_id = st.sidebar.text_input("Enter your User ID - ")
# 	user_id = '\'' + user_id + '\''
# 	password = st.sidebar.text_input("Enter your Password - ")

# 	actual_password = get_attribute("user", primary_keys["user"], [user_id], "password")
# 	if(actual_password == []):
# 		actual_password = ""
# 	else:
# 		actual_password = actual_password[0][0]

# 	print(password, actual_password)

# 	if(st.sidebar.button("Login")):
# 		if(password == actual_password):
# 			return False

# 		else:
# 			st.warning("User ID or Password is incorrect")
# 			return True


	



