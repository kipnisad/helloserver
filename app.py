import socket
from flask import Flask
from flask_healthz import healthz
from flask_healthz import HealthError

app = Flask(__name__)
app.register_blueprint(healthz, url_prefix="/healthz")

hostname = socket.gethostname()

## healthz liveness/readiness probes for k8s

def liveness():
    try:
        #print('liveness probe')
        i = 1 #
    except Exception:
        raise HealthError("Can't connect to the file")

def readiness():
    try:
        #print('readiness probe')
        i = 1
    except Exception:
        raise HealthError("Can't connect to the file")


app.config.update(
    HEALTHZ = {
        "live": "app.liveness",
        "ready": "app.readiness",
    }
)

@app.route('/')
def hello_world():
    return f'Host: {hostname}'

if __name__ == '__main__':
    #app.debug = True
    app.run(host='0.0.0.0')