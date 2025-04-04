from flask import Flask
import socket
import requests
app = Flask(__name__)

def get_host_ip():
    try:
        # Lấy địa chỉ IP của host
        hostname = socket.gethostname()
        ip_address = socket.gethostbyname(hostname)
        return ip_address
    except Exception as e:
        return str(e)

@app.route('/')
def show_ip():
    ip_address = get_host_ip()
    response = requests.get('https://httpbin.org/ip')
    public_ip_address = response.json().get('origin')
    return f'Host IP Address: {ip_address} \nPublic IP Address: {public_ip_address}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)


