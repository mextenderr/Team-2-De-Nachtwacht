from flask import Flask
from flask import request
from flask import jsonify
from random import randint, sample
import statistics as st
import Data_Analysis as da
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

except Exception as e:
    print(e)
    print("--- Server could not establish connection with database ---\n")

cursor = connection.cursor()


# END:    Database setup    #





# START:    http requests     #

app = Flask(__name__)

@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Not found'})

@app.route('/test')
def test():
    return jsonify({"succes" : True})

@app.route('/login')
def login():
    auth = request.authorization
    if not auth or not auth.username or not auth.password:
        return jsonify({"succes" : False})
    

    username = auth.username
    password = auth.password
    query = """SELECT * FROM "Users" where (username = %s) and (password = %s) """, (username, password)
    cursor.execute(query)
    user = cursor.fetchall()
    if(len(user) > 0):
        print(user[0][0])
        return jsonify({"succes" : True, "uid":user[0][0]})

    else:
        return jsonify({"succes" : False})
 

@app.route( '/user', methods = ["GET", "POST"] )
def user():
    # GET requests are used to retreive al information about a user [args -> 'uid']
    if request.method == "GET":
        # out of request we can extract the arguments given in the http request (account details)
        userid = request.args.get('uid', None)

        cursor.execute(
            """select * from "Users" where uid = %s""", (userid,)
        )
        userinfo = cursor.fetchall()[0]
        usrdict = {"uid":userinfo[0], "username":userinfo[1], "name":userinfo[2], "age":userinfo[3], "csv":userinfo[5]}

        return jsonify(usrdict)

    # POST requests are used to store new user entries in the database
    if request.method == "POST":

        body = json.loads(request.data, strict=False)   # getting the body out of the post request
        username = body["username"]
        name = body["name"]
        age = body["age"]
        password = body["password"]

        cursor.execute(
            """select * from "Users" where username = %s""", (username,)
        )
        existingUsers = len(cursor.fetchall())
        if existingUsers > 0:
            return jsonify( succes = False )


        # making a csv file to store incomming sleep data on
        csvFileName = username + '_sleepData.csv'

        with open("/home/max/nachtwachtFiles/" + csvFileName, 'w', ) as file:
            writer = csv.writer(file)
            writer.writerow(['time', 'heartrate'])

        # storing user account details in database and refering the csv file linked to the account
        cursor.execute(
            """insert into "Users"(username, name, age, password, csvfilename) values(%s, %s, %s, %s, %s)""" , ( username, name, age, password, csvFileName )
        )
        connection.commit()

        # returning a succes response to the client
        return jsonify( succes = True ) # this is a generated 200 response to the client side


@app.route('/sleepdata', methods = ["GET", "POST"])
def sleepData():

    # Args      -> uid | size(Amount of data points)
    # Returns   -> JSON array of Time/Heartrate Tuples
    if request.method == "GET":
        user = request.args.get('uid', None)
        size = int(request.args.get('size', None))

        csvUser = getCsvForUser(user)

        with open(csvUser, 'r') as file:
            data = []
            csv_reader = list(reversed(list(csv.reader(file, delimiter=','))))
            line = 0
            while line < size and line < len(csv_reader) - 1:
                data.append(csv_reader[line])
                line += 1

        return json.dumps(data)

    # Post method uploads data to database for mentioned user
    if request.method == "POST":

        body = json.loads(request.data, strict=False)
        user = body["uid"]
        data = body["data"]
        csvUser = getCsvForUser(user)

        # Writing the new datapoints to csv file of user
        with open(csvUser, 'a') as file:
            writer = csv.writer(file)

            for row in data:
                writer.writerow([row[0], row[1]])

        analyseResult = analyse(csvUser)


        res = json.dumps({ "succes" : True , "wakeup" : analyseResult})

        return res


@app.route('/checkforwakeup', methods = ["GET"])
def checkForWakeUp():
    user = request.args.get('uid', None)

    res = analyse(getCsvForUser(user))

    return json.dumps({"wakeup" : res})


# END:    http requests     #



# START:  global funcs      #

def getCsvForUser(user):
    # returns the path to the user's csv file

    cursor.execute("""select csvfilename from "Users" where uid = %s""", (user,))
    path = "/home/max/nachtwachtFiles/" + str(cursor.fetchone()[0])
    return path

def analyse(givenCsv):
        with open(givenCsv, 'r') as file:
            csvIterator = csv.reader(file, delimiter=',')
            next(csvIterator)
            dataPoints = list(csvIterator)

        heartrates = []
        for datapoint in dataPoints:
            heartrates.append(int(datapoint[1]))

        std = st.stdev(sample(heartrates, int(len(heartrates)*0.9))) # calculating the standard deviation with a sample of heartrates
        usersAvg = sum(heartrates) / len(heartrates)
        print(std, usersAvg)

        if len(dataPoints) > 100:
            heartrates = dataPoints[:100]

        analyseResult = da.analyseData(heartrates, usersAvg, std)

        return analyseResult

# END:   global funcs       #


if __name__ == '__main__':
    app.run()
