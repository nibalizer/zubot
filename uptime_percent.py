#!/usr/bin/python

# Uptime over 4 hours by percent

import requests

r = requests.get('https://p.datadoghq.com/screen/shared_batch_update/1xfifX-a17f211ecb')

percent = "{:.2%}".format(r.json()["responses"]["4"][0]['value'] / 100.)

print percent
