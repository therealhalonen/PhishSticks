**EDUCATIONAL USE ONLY, USE AT YOUR OWN RISK!**
# Web server with Flask

## What it is? What it does?
Simple python script, to launch a web server which takes POST requests.

## How to use:

- Download the file `webhook`
- Edit `host='<IP>', port=<PORT>` , to the IP and Port, you want to listen the incoming traffic.
- Give permission `chmod 700 webhook`
- Run `./webhook`
**Profit!**   
Webhook is now running, in `/server` endpoint.

---

### Commented code:

```python
#!/bin/python3
from flask import Flask, request
import os

app = Flask(__name__)

# Function to get the next available log number
def get_next_log_number():
    log_number = 1
    # Check if log files exist with incremental numbers and find the next available number
    while os.path.exists(f'log-{log_number}.txt'):
        log_number += 1
    return log_number

# Define a route that listens for POST requests at '/server'
@app.route('/server', methods=['POST'])
def handle_webhook():
    if request.method == 'POST':
        # Get the incoming data from the POST request
        data = request.data
        # Get the next available log number
        log_number = get_next_log_number()
        # Create a log filename using the log number
        log_filename = f'log-{log_number}.txt'

        # Write the received data to a log file
        with open(log_filename, 'w') as file:
            file.write(data.decode("utf-8"))

        # Return a response indicating successful data reception and logging
        return f"Webhook data received and logged as {log_filename}", 200
    else:
        # Return a response for unsupported HTTP methods
        return "Unsupported method", 501

if __name__ == '__main__':
    # Run the Flask app on the specified host and port
    app.run(host='<IP>', port=<PORT>)

```
