from flask import Flask
from flask import request
from flask import jsonify
import psycopg2



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




app = Flask(__name__)

# dummy list of sleep data
x = [60, 61, 60, 58, 90, 90, 90, 90, 90]

# creates an http request with linked name
@app.route('/getsleepdata')
def getSleepData():
    return jsonify(x)


@app.route('/registeruser')
def registerUser():
    # out of request we can extract the arguments given in the http request
    username = request.args.get('usn', None)
    password = request.args.get('psw', None)

    cursor.execute(
        """insert into "Users"(username, password) values(%s, %s)""" , ( username, password )
    )
    connection.commit()

    return jsonify( succes = True ) # this is a generated 200 response to the client side


@app.route('/getuser')
def getUser():
    return "user"



if __name__ == '__main__':
    app.run()

