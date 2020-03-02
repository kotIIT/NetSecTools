from requests import get
import socket
import os

pubIP = get('https://api.ipify.org').text
print ("Public IP is", pubIP)

print (pubIP)