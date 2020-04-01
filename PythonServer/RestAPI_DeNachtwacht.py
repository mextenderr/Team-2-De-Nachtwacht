from flask import Flask
import mysql.connector

app = Flask(__name__)

mydb = mysql.connector.connect(
    host="localhost",
    user="yourusername",
    passwd="yourpassword"
)


@app.route('/registeruser')
def registerUser():


    print(mydb)

    return "Hello World!"



@app.route('/getuser')
def getUser():
    return "Hello World!"



if __name__ == '__main__':
    app.run()

