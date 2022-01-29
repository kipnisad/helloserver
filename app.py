import socket
from flask import Flask
app = Flask(__name__)

hostname = socket.gethostname()

@app.route('/')
def hello_world():
    return f'Host: {hostname}'

if __name__ == '__main__':
    app.run(host='0.0.0.0')