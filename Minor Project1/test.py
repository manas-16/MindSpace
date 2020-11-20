import simplejson
import requests
#posting data
url = "http://127.0.0.1:8000/rest/"
dict = {'csrfmiddlewaretoken':'9aW3PExKej3GIOjd8M3XtlPwwtHnpWNxm4MKAg9NNICKM2FZoTVtSmE7l3ULmYlI',
    "name": "wanda","sentiment": "neutral",
    "anger": 0.0,"sad": 0.0,
    "fear": 0.0,
    "happy": 0.0,
    "disgust": 0.0,
    "surprise": 0.0,
    "neutral": 0.0,
    "chat": "hey! i am so happy today",
    "unique":"1234567890"   }
headers = {'Content-type':'application/json'}
response = requests.post(url,data=simplejson.dumps(dict),headers=headers)
id = response.json()["id"]
print(id)
#receiving processed data back
url1 = "http://127.0.0.1:8000/rest/"+str(id)+"/"
response1 = requests.get(url1)
print(response1.json())

