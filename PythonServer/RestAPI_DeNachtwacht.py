from flask import Flask
from flask import request
from flask import jsonify
from random import randint
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





# START:    http requests setup     #

app = Flask(__name__)


# creates an http request with linked name
@app.route('/registeruser')
def registerUser():
    # out of request we can extract the arguments given in the http request (account details)
    user = request.args.get('uid', None)
    password = request.args.get('psw', None)

    # making a csv file to store incomming sleep data on
    csvFileName = user + '_' + str(randint(1000, 9999)) + '_sleepData.csv'

    with open(csvFileName, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['time', 'heartrate'])

    # storing user account details in database and refering the csv file linked to the account
    cursor.execute(
        """insert into "Users"(username, password, csvfilename) values(%s, %s, %s)""" , ( user, password, csvFileName )
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
        pass

    return


@app.route('/uploadsleepdata')
def uploadSleepData():
    # TODO: receive data in determined data structure

    user = request.args.get('uid', None)
    data = request.args.get('data', None)

    csvUser = getCsvForUser(user)

    # opening a csv file with parameter 'a' will allow appending rows at end of file
    with open(csvUser, 'a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['13-04-2020-12-18', data])


    return jsonify( succes = True )



def getCsvForUser(user):
    cursor.execute("""select csvfilename from "Users" where username = %s""", (user,))
    return str(cursor.fetchone()[0])




if __name__ == '__main__':
    app.run()

