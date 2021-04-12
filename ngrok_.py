import os
import time
import json
from pyngrok import ngrok
NGROK_APIKEY = os.environ.get("NGROK_APIKEY", "YOUR_NGROK_APIKEY")
ngrok.set_auth_token(NGROK_APIKEY)
uri=ngrok.connect(5900, "tcp")
open("/work/noVNC/ngrok.txt", "w").write(uri.public_url)
open("/work/noVNC/ngrok.json", "w").write(json.dumps(uri.data))
while True:
    time.sleep(60*60*24)