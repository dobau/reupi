import requests
url = '<url>'
myfile = requests.get(url)
open('datas.zip', 'wb').write(myfile.content)
