from flask import Flask
app = Flask(__name__)


@app.route('/RegisterUser')
def registerUser():
    return "Hello World!"


if __name__ == '__main__':
    app.run()
