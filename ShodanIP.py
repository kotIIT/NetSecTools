import webbrowser
import requests


#Simple Python Script that will get Your Router IP
#Check Router's IP in Shodan for Vulnerabilities

PublicIP = requests.get("http://ipecho.net/plain?").text


webbrowser.open('https://shodan.io/search?query=' + PublicIP)
