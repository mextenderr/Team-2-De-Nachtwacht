from flask import Flask
from flask import request
from flask import jsonify
from random import randint
import json
import csv
import psycopg2
import datetime



# START:  Database setup    #

DB_NAME = "DeNachtwachtDB"
DB_USER = "postgres"
DB_PASS = "admin"
DB_HOST = "127.0.0.1"
DB_PORT = 5432

try:
    connection = psycopg2.connect(database = DB_NAME, user = DB_USER, password = DB_PASS, host = DB_HOST, port = DB_PORT)

    print("--- Server established connection with the database ---\n")

except:
    print("--- Server could not establish connection with database ---\n")

cursor = connection.cursor()


# END:    Database setup    #





# START:    http requests     #

app = Flask(__name__)


@app.route( '/user', methods = ['GET', 'POST'] )
def registerUser():

    # GET requests are used to retreive al information about a user [args -> 'uid']
    if request.method == "GET":
        # out of request we can extract the arguments given in the http request (account details)
        userid = request.args.get('uid', None)

        cursor.execute(
            """select * from "Users" where uid = %s""", (userid,)
        )
        userinfo = cursor.fetchall()[0]
        usrdict = {"uid":userinfo[0], "username":userinfo[1], "password":userinfo[2], "csv":userinfo[3]}

        return usrdict

    # POST requests are used to store new user entries in the database
    if request.method == "POST":

        data = json.loads(request.data, strict=False)   # getting the body out of the post request
        username = data["username"]
        password = data["password"]

        # making a csv file to store incomming sleep data on
        csvFileName = username + '_' + str(randint(1000, 9999)) + '_sleepData.csv'

        with open(csvFileName, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(['time', 'heartrate'])

        # storing user account details in database and refering the csv file linked to the account
        cursor.execute(
            """insert into "Users"(username, password, csvfilename) values(%s, %s, %s)""" , ( username, password, csvFileName )
        )
        connection.commit()

        # returning a succes response to the client
        return jsonify( succes = True ) # this is a generated 200 response to the client side


@app.route('/getsleepdata')
def getSleepData():
    user = request.args.get('uid', None)

    csvUser = getCsvForUser(user)

    with open(csvUser, 'r') as file:
        # TODO: return sleep data out of opened file
        reader = csv.reader(file, delimiter=',')




    return


@app.route('/uploadsleepdata')
def uploadSleepData():
    # TODO: receive data in determined data structure

    user = request.args.get('uid', None)
    time = request.args.get('time', None)
    heartrate = request.args.get('hr', None)

    # retreiving path to users' csv file
    csvUser = getCsvForUser(user)

    # opening a csv file with parameter 'a' will allow appending rows at end of file
    with open(csvUser, 'a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow([time, heartrate])

    return jsonify( succes = True )



def getCsvForUser(user):
    # returns the path to the user's csv file

    cursor.execute("""select csvfilename from "Users" where username = %s""", (user,))
    return str(cursor.fetchone()[0])


# END:    http requests     #



if __name__ == '__main__':
    app.run()

