import requests

ipaddr = requests.get('https://ifconfig.co/ip').text
print(f'Hello from python script! Ip Address: {ipaddr}')

