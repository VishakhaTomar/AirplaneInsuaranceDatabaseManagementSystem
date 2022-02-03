from os import error, write
import streamlit as st
import psycopg2
from psycopg2 import sql
import datetime
from configparser import ConfigParser
import logging
import re
import pandas as pd
import hashlib

from streamlit.type_util import OptionSequence

# import psycopg2

regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w+$'


@st.cache
def get_config(filename="database.ini", section="postgresql"):
    parser = ConfigParser()
    parser.read(filename)
    return {k: v for k, v in parser.items(section)}


def make_hashes(password):
    return hashlib.sha256(str.encode(password)).hexdigest()


def check_hashes(password, hashed_text):
    if make_hashes(password) == hashed_text:
        return hashed_text
    return False


def checkEmail(email):
    if (email is None or email == ''):
        st.error('Email cannot be blank')
    if (email):
        if (not re.search(regex, email)):
            st.error('Invalid email id')


def add_userdata(username, password, security_question, security_answer):
    insert_query_db(
        f'INSERT INTO userstable(username,password,usertype,security_question,security_answer) VALUES ( \'{username}\',\'{password}\',\'U\',\'{security_question}\',\'{security_answer}\')')
    return


def login_user(username, password):
    return \
    query_db(f'SELECT count(1) as found FROM userstable WHERE username =\'{username}\' AND password = \'{password}\';')[
        'found'].loc[0]


def login_usertype(username, password):
    return query_db(f'SELECT usertype FROM userstable WHERE username =\'{username}\' AND password = \'{password}\';')


def query_db(sql: str):
    print(sql)
    # print(f'Running query_db(): {sql}')

    db_info = get_config()

    # Connect to an existing database
    conn = psycopg2.connect(**db_info)

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    cur.execute(sql)

    # Obtain data
    data = cur.fetchall()

    column_names = [desc[0] for desc in cur.description]

    # Make the changes to the database persistent
    conn.commit()

    # Close communication with the database
    cur.close()
    conn.close()

    df = pd.DataFrame(data=data, columns=column_names)

    return df


def insert_query_db(sql: str):
    print(sql)
    # print(f'Running query_db(): {sql}')

    db_info = get_config()

    # Connect to an existing database
    conn = psycopg2.connect(**db_info)

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    cur.execute(sql)

    # Make the changes to the database persistent
    conn.commit()

    # Close communication with the database
    cur.close()
    conn.close()
    return


def insertUser(cid, fnampe, lnamep, dob, nationalityy, gender, email, housenum, street, city, state, zipcode,
               country_code, country, contact_number, nop, ec_fname, ec_lname, ec_cc, ec_contact, pspt_num, pspt_expd,
               c_type):
    checkEmail(email)
    sql_insert_user = 'insert into vcvt_cust (c_id, fnamep,lnamep,dob,nationalityy, gender, email, housenum, street,city, state, zipcode,country_code,country,contact_number,nop,ec_fname,ec_lname, ec_cc, ec_contact,pspt_num,pspt_expd, c_type)values ( ' + str(
        cid) + ',\'' + fnampe.strip() + '\' , \'' + lnamep.strip() + '\' ,\'' + str(
        dob) + '\',\'' + nationalityy.strip() + '\', \'' + gender + '\',\'' + email + '\',' + str(
        housenum) + ' , ' + str(street) + ',\'' + city.strip() + '\',\'' + state.strip() + '\',' + str(
        zipcode) + ',' + str(country_code) + ',\'' + country + '\',' + str(contact_number) + ',' + str(
        nop) + ',\'' + ec_fname.strip() + '\', \'' + ec_lname.strip() + '\',\'' + str(ec_cc) + '\',\'' + str(
        ec_contact) + '\',\'' + str(pspt_num) + '\',\'' + str(pspt_expd) + '\',\'' + str(c_type) + '\');'
    try:
        df = insert_query_db(sql_insert_user)
        st.write('User Created!')
    except Exception as e:
        print(e)
        st.write(
            "Sorry! Something went wrong with your query, please try again."
        )
    return


def insertPassenger(c_id, fnampe, lnamep, dob, nationalityy, gender, email, housenum, street, city, state, zipcode,
                    country_code, country, contact_number, nop, ec_fname, ec_lname, ec_cc, ec_contact, pspt_num,
                    pspt_expd, c_type):
    sql_insert_psngr = 'insert into vcvt_psngr(c_id,fnamep,lnamep,dob,nationalityy, gender, email, housenum, street,city, state, zipcode,country_code,country,contact_number,nop,ec_fname,ec_lname, ec_cc, ec_contact, pspt_num,pspt_expd, c_type)values ( \'' + str(
        c_id) + '\', \'' + fnampe.strip() + '\' , \'' + lnamep.strip() + '\' ,\'' + str(
        dob) + '\',\'' + nationalityy.strip() + '\', \'' + gender + '\',\'' + email + '\',' + str(
        housenum) + ' , ' + str(street) + ',\'' + city.strip() + '\',\'' + state.strip() + '\',' + str(
        zipcode) + ',' + str(country_code) + ',\'' + country + '\',' + str(contact_number) + ',' + str(
        nop) + ',\'' + ec_fname.strip() + '\', \'' + ec_lname.strip() + '\',\'' + str(ec_cc) + '\',\'' + str(
        ec_contact) + '\',\'' + str(pspt_num) + '\',\'' + str(pspt_expd) + '\',\'' + str(c_type) + '\');'
    try:
        df = insert_query_db(sql_insert_psngr)
        st.write('Passenger Added!')
    except Exception as e:
        print(e)
        st.write(
            "Sorry! Something went wrong with your query, please try again."
        )
    return


def main():
    # from PIL import Image
    # image = Image.open('img.jpg')
    # st.image(image)

    # st.markdown(page_bg_img, unsafe_allow_html=True)
    st.title("SAME")

    menu = ["Home", "Login", "SignUp"]

    choice = st.sidebar.selectbox("Menu", menu)

    if choice == "Home":
        st.subheader("Home")

    elif choice == "Login":
        st.subheader("Login Section")
        username = st.sidebar.text_input("User Name")
        password = st.sidebar.text_input("Password", type='password')

        if st.sidebar.checkbox("Change/Forget Password"):
            sql_security = f'select security_question , security_answer from userstable where username= \'{username}\';'
            changepwd = query_db(sql_security)
            st.write("Your security Question")
            st.write(changepwd['security_question'].loc[0])
            useranswer = st.text_input('Input your answer here')
            if st.checkbox("Proceed"):
                if (useranswer == changepwd['security_answer'].loc[0]):
                    st.write(username)
                    updated_password = st.text_input("Enter your new password", type='password')
                    if st.button('Submit'):
                        hashed_pswd = make_hashes(updated_password)
                        update_password_sql = f'UPDATE USERSTABLE SET password = \'{hashed_pswd}\' where username= \'{username}\';'
                        insert_query_db(update_password_sql)
                        st.success("Password updated, go to login again")
                else:
                    st.write("Wrong answer, please try again")

        if st.sidebar.checkbox("Login"):
            # if password == '12345':
            hashed_pswd = make_hashes(password)
            result = login_user(username, check_hashes(password, hashed_pswd))
            print(result)
            if result:
                st.write("Logged In as {}".format(username))
                userType = login_usertype(username, check_hashes(password, hashed_pswd))
                user = userType['usertype'].loc[0]

                # user = st.write(login_usertype.loc[login_usertype,'usertype'].iloc[0])
                # st.write(insuranceplans.loc[insuranceplans['p_name'] == planName, 'description'].iloc[0])
                if user == 'A':
                    temp = ['Add Airline', 'Add Airport', 'Add Insurance Plans', 'Add Flights']
                    choice = st.selectbox('Menu', temp)
                    if choice == 'Add Airline':
                        a_id = st.number_input('Enter the ID', max_value=99999)
                        a_name = st.text_input('Enter Airlines name', max_chars=30)
                        main_hub = st.text_input('Enter Main hum of the airline', max_chars=30)
                        hq_city = st.text_input('Enter Headquarters of the airline', max_chars=30)
                        country = st.text_input('Enter Country of the airline', max_chars=30)
                        if st.button('Submit'):
                            sql_input_airline = f'INSERT INTO VCVT_AL (a_id, a_name, main_hub, hq_city, country) VALUES ({a_id},\'{a_name}\',\'{main_hub}\', \'{hq_city}\',\'{country}\');'
                            insert_query_db(sql_input_airline)
                            st.write('Airline Added')

                    if choice == 'Add Insurance Plans':
                        pln_id = st.number_input('Insurance Plan ID', max_value=9999)
                        p_name = st.text_input('Insurance Name', max_chars=30)
                        description = st.text_input('Insurance description', max_chars=500)
                        cpp = st.number_input('Cost per plan')
                        if st.button('Submit'):
                            sql_input_insurance = f'INSERT INTO VCVT_ISPLN (pln_id, p_name, description, cpp) VALUES ({pln_id},\' {p_name}\', \'{description}\',{cpp});'
                            insert_query_db(sql_input_insurance)
                            st.write('Insurance Plan Added')

                    if choice == 'Add Airport':
                        ARPT_CODE = st.text_input('Airport ID', max_chars=4)
                        ARPT_NAME = st.text_input('Airport Name', max_chars=50)
                        CITY = st.text_input('Airport City', max_chars=20)
                        COUNTRY = st.text_input('Airport Country', max_chars=30)
                        TYPE = st.selectbox('Airport type', ['INTERNATIONAL', 'DOMESTIC'])
                        if st.button('Submit'):
                            sql_input_airport = f'INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES (\'{ARPT_CODE}\',\' {ARPT_NAME}\', \'{CITY}\',\'{COUNTRY}\',\'{TYPE}\');'
                            insert_query_db(sql_input_airport)
                            st.write('Airport Added')

                    if choice == 'Add Flights':
                        F_ID = st.number_input('Flight ID', max_value=999999)
                        D_TIME = st.date_input('Departure Time', min_value=datetime.date.today())
                        D_TZ = st.selectbox('Departure City TimeZone', ['GMT', 'CET', 'EST', 'MSK', 'IST'])
                        ARR_TIME = st.date_input('Arrival Time', min_value=datetime.date.today())
                        A_TZ = st.selectbox('Arrival City TimeZone', ['GMT', 'CET', 'EST', 'MSK', 'IST'])
                        A_TZ = 59
                        ARPT_CODE_ARV = st.text_input('Arrival Airport Code', max_chars=4)
                        ARPT_CODE_DEP = st.text_input('Departure Airport Code', max_chars=4)

                        if st.button('Submit'):
                            sql_input_flight = f'INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,A_TZ, AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP) VALUES ({F_ID},\'{D_TIME}\', \'{D_TZ}\', \'{ARR_TIME}\',\'{A_TZ}\',{A_TZ}, \'{ARPT_CODE_ARV}\', \'{ARPT_CODE_DEP}\');'
                            insert_query_db(sql_input_flight)
                            st.write('Flight Added')


                elif user == 'U':
                    temp = ['New Customer', 'Add a passenger', 'Select Insurance Plan', 'Add Flight details',
                            'Checkout']
                    choice = st.selectbox('Menu', temp)
                    sql_check_customer = f'select count(*)  as count from vcvt_cust a, userstable b where  b.username = \'{username}\' and b.customerID = a.c_id; '
                    existing = query_db(sql_check_customer)['count'].loc[0]
                    if choice == 'New Customer':
                        if existing == 0:
                            fname = st.text_input('Enter your First name', max_chars=30)
                            lname = st.text_input('Enter your Last name', max_chars=30)
                            dob = st.date_input('Date of Birth', max_value=datetime.date.today())
                            nationalityy = st.text_input('Nationality', max_chars=30)
                            gender = st.selectbox('Gender', ['M', 'F'])
                            email = st.text_input('Enter your email', max_chars=30)
                            housenum = st.number_input('House Number', max_value=9999)
                            street = st.number_input('street Number', max_value=9999)
                            city = st.text_input('City', max_chars=30)
                            state = st.text_input('State', max_chars=30)
                            zipcode = st.text_input('Zipcode', max_chars=10)
                            country_code = st.number_input('country code', max_value=999)
                            country = st.text_input('Country', max_chars=30)
                            contact_number = st.number_input('contact number', min_value=999999999,
                                                             max_value=9999999999)
                            nop = st.number_input('Number of Passengers travelling with you', min_value=99)
                            ec_fname = st.text_input('Emergency Contact first name', max_chars=30)
                            ec_lname = st.text_input('Emergency Contact Last name', max_chars=30)
                            ec_cc = st.number_input('Emergency contact country code', max_value=9999)
                            ec_contact = st.number_input('Emergency contact number', min_value=999999999,
                                                         max_value=9999999999)
                            pspt_num = st.text_input('Passport number', max_chars=15)
                            pspt_expd = st.date_input('Date of Passport expiry', min_value=datetime.date.today())
                            c_type = st.selectbox('Do you have any Booking agent or Membership',
                                                  ['None', 'Booking Agent', 'Membership'])
                            if c_type:
                                if c_type == 'Booking Agent':
                                    c_type = 'A'
                                elif c_type == 'Membership':
                                    c_type = 'M'
                                elif c_type == 'None':
                                    c_type = 'C'

                            if st.button('Submit'):
                                sql_get_cust_id = f'select customerID from userstable where username = \'{username}\''
                                insertUser(query_db(sql_get_cust_id)['customerid'].loc[0], fname, lname, dob,
                                           nationalityy, gender, email, housenum, street, city, state, zipcode,
                                           country_code, country, contact_number, nop, ec_fname, ec_lname, ec_cc,
                                           ec_contact, pspt_num, pspt_expd, c_type)
                                # restaurants = query_db(sql_find_rest)
                                # planid = st.selectbox('Select a plan:' ,  restaurants['name'].tolist())
                        elif existing == 1:
                            sql_get_cust_id = f'select customerID from userstable where username = \'{username}\''
                            st.write('You are already registered and your customer id is ' + str(
                                query_db(sql_get_cust_id)['customerid'].loc[0]))

                    elif choice == 'Add a passenger':
                        sql_get_cust_id = f'select customerID from userstable where username = \'{username}\''
                        c_id = str(query_db(sql_get_cust_id)['customerid'].loc[0])
                        fname = st.text_input('Enter your First name', max_chars=30)
                        lname = st.text_input('Enter your Last name', max_chars=30)
                        dob = st.date_input('Date of Birth', max_value=datetime.date.today())
                        nationalityy = st.text_input('Nationality', max_chars=30)
                        gender = st.selectbox('Gender', ['M', 'F'])
                        email = st.text_input('Enter your email', max_chars=30)
                        housenum = st.number_input('House Number', max_value=9999)
                        street = st.number_input('street Number', max_value=9999)
                        city = st.text_input('City', max_chars=30)
                        state = st.text_input('State', max_chars=30)
                        zipcode = st.text_input('Zipcode', max_chars=10)
                        country_code = st.number_input('country code', max_value=999)
                        country = st.text_input('Country', max_chars=30)
                        contact_number = st.number_input('contact number', min_value=999999999, max_value=9999999999)
                        nop = st.number_input('Number of Passengers travelling with you', min_value=99)
                        ec_fname = st.text_input('Emergency Contact first name', max_chars=30)
                        ec_lname = st.text_input('Emergency Contact Last name', max_chars=30)
                        ec_cc = st.number_input('Emergency contact country code', max_value=9999)
                        ec_contact = st.number_input('Emergency contact number', min_value=999999999,
                                                     max_value=9999999999)
                        pspt_num = st.text_input('Passport number', max_chars=15)
                        pspt_expd = st.date_input('Date of Passport expiry', min_value=datetime.date.today())
                        c_type = st.selectbox('Do you have any Booking agent or Membership',
                                              ['None', 'Booking Agent', 'Membership'])
                        if c_type:
                            if c_type == 'Booking Agent':
                                c_type = 'A'
                            elif c_type == 'Membership':
                                c_type = 'M'
                            elif c_type == 'None':
                                c_type = 'C'
                        if st.button('Submit'):
                            insertPassenger(c_id, fname, lname, dob, nationalityy, gender, email, housenum, street,
                                            city, state, zipcode, country_code, country, contact_number, nop, ec_fname,
                                            ec_lname, ec_cc, ec_contact, pspt_num, pspt_expd, c_type)
                            sql_pid = '  SELECT max(p_id) as max FROM vcvt_psngr;'
                            st.write('Your passenger id is ', query_db(sql_pid)['max'].loc[0])


                    elif choice == 'Select Insurance Plan':
                        sql_insurance_plan = 'select pln_id , p_name , description from vcvt_ispln;'
                        insuranceplans = query_db(sql_insurance_plan)
                        p_id = st.number_input("Enter you Passenger ID", min_value=1)
                        planName = st.selectbox("Choose a insurance plan", insuranceplans['p_name'].tolist())
                        if planName:
                            plan_id = insuranceplans.loc[insuranceplans['p_name'] == planName, 'pln_id'].iloc[0]
                            st.write(insuranceplans.loc[insuranceplans['p_name'] == planName, 'description'].iloc[0])
                        if st.button('Submit'):
                            sql_cust_ispln = f'INSERT INTO VCVT_CUST_ISPLN (PLN_ID, P_ID) VALUES ({plan_id},{p_id});     '
                            insert_query_db(sql_cust_ispln)


                    elif choice == 'Add Flight details':
                        p_id = st.number_input("Enter you Passenger ID", min_value=1)
                        sql_flight_detail = 'select * from VCVT_FLT;'
                        flightdetail = query_db(sql_flight_detail)
                        flightid = st.selectbox('Choose your flight ID', flightdetail['f_id'].tolist())
                        if flightid:
                            flight = flightdetail.loc[flightdetail['f_id'] == flightid, 'f_id'].iloc[0]
                            # flightdetail.rename(columns={"f_id":"Flight ID", "d_time":"Departure time","d_tz":"Departure Time zone","arr_time":"Arrival time zone", "a_tz":"Arrival time zone","am_id":"Aircraft Model","arpt_code_arv":"Arrival airport code","arpt_code_dep":"Departure airport code" })
                            st.dataframe(flightdetail.loc[flightdetail['f_id'] == flightid].rename(
                                columns={"f_id": "Flight ID", "d_time": "Departure time", "d_tz": "Departure Time zone",
                                         "arr_time": "Arrival time", "a_tz": "Arrival time zone",
                                         "am_id": "Aircraft Model", "arpt_code_arv": "Arrival airport code",
                                         "arpt_code_dep": "Departure airport code"}))

                        sql_airline_detail = 'select a_id, a_name from VCVT_AL;'
                        Airlinedetail = query_db(sql_airline_detail)
                        airlineid = st.selectbox('Choose your Airline', Airlinedetail['a_name'].tolist())
                        airline = 0
                        if airlineid:
                            airline = Airlinedetail.loc[Airlinedetail['a_name'] == airlineid, 'a_id'].iloc[0]

                        sql_meal_detail = 'select * from VCVT_MEAL;'
                        mealdetail = query_db(sql_meal_detail)
                        mealid = st.selectbox('Choose your Meal Plan', mealdetail['meal_plan'].tolist())
                        Meal = 0
                        if mealid:
                            Meal = mealdetail.loc[mealdetail['meal_plan'] == mealid, 'meal_id'].iloc[0]

                        sql_cabin_detail = 'select * from VDVT_cabin;'
                        cabindetail = query_db(sql_cabin_detail)
                        cabinid = st.selectbox('Choose your Cabin Class', cabindetail['cabin_class'].tolist())
                        Cabin = 0
                        if cabinid:
                            Cabin = cabindetail.loc[cabindetail['cabin_class'] == cabinid, 'cabin_id'].iloc[0]

                        sql_special_request = 'select * from VCVT_spereq;'
                        specialREequest = query_db(sql_special_request)
                        speREq = st.multiselect('Choose any special request', specialREequest['sr_name'].tolist())

                        # adding at the submit button
                        if st.button('Submit'):
                            sql_psngr_flight = f'INSERT INTO VCVT_FL_PR (P_ID, A_ID, F_ID, MEAL_ID, CABIN_ID) VALUES ({p_id}, {airline}, {flightid},\'{Meal}\', \'{Cabin}\');'
                            insert_query_db(sql_psngr_flight)
                            for i in speREq:
                                temp = specialREequest.loc[specialREequest['sr_name'] == i, 'sr_id'].iloc[0]
                                sql_psngr_flight = f'INSERT INTO VCVT_SR_FL_PR (P_ID, SR_ID) VALUES ({p_id}, {temp});'
                                insert_query_db(sql_psngr_flight)
                            st.write(
                                'Flight Detail Added. To add the connecting flight, please add flight detail again')

                    elif choice == 'Checkout':
                        sql_invoice_num = f'select last_value from invoice_increment'
                        sql_get_cust_id = f'select customerID from userstable where username = \'{username}\''
                        c_id = str(query_db(sql_get_cust_id)['customerid'].loc[0])
                        sql_invoice_total = f'select sum(b.cpp) as total from vcvt_cust_ispln a,vcvt_ispln b,vcvt_psngr c where a.p_id =c.p_id and a.pln_id = b.pln_id and c.c_id={c_id};'

                        # SQL Injection
                        sql_get_customer_id = 'select customerID from userstable where username = {usernm}'.format(
                            usernm=sql.Placeholder(username))
                        invoiceID = str(query_db(sql_invoice_num)['last_value'].loc[0])
                        invoicetotal = str(query_db(sql_invoice_total)['total'].loc[0])
                        st.header('Invoice')
                        st.subheader('Invoice ID:  ' + str(query_db(sql_invoice_num)['last_value'].loc[0]))
                        st.subheader('Total Amount Payable:  ' + str(query_db(sql_invoice_total)['total'].loc[0]))
                        st.button('Proceed to Payment')
                        #   SQL Join command
                        sql_invoice_details = f'INSERT INTO VCVT_INVCE_NMBR (INVOICE_NUMBER, INVOICE_DATE, INVOICE_AMT, C_ID) VALUES ({invoiceID}, {datetime.date.today}, {invoicetotal}, {c_id});'
                        insert_query_db(sql_invoice_total)
                        item = 0
                        if item == 1:
                            query_db(sql_get_customer_id)

            else:
                st.warning("Incorrect Username/Password")
    elif choice == "SignUp":
        st.subheader("Create New Account")
        new_user = st.text_input("Username")
        new_password = st.text_input("Password", type='password')
        security_question = st.text_input("Enter your security question")
        security_answer = st.text_input("Enter your answer for the security question")
        if st.button("Signup"):
            add_userdata(new_user, make_hashes(new_password), security_question, security_answer)
            st.success("You have successfully created a valid Account")
            st.write('Your Customer id is ' + str(
                query_db(f'select max(customerID) as custid from userstable')['custid'].loc[0]))
            st.info("Go to Login Menu to login")


if __name__ == '__main__':
    main()
