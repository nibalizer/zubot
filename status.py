#!/usr/bin/python

import requests

r = requests.get('https://p.datadoghq.com/screen/shared_batch_update/1xfifX-a17f211ecb')

status = r.json()["responses"]["0"][0]["groups"][0]["status"]

print status
