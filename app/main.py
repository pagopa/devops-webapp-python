from ast import If
import json
import os
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"root": "ok"}

@app.get("/api")
async def api():
    my_configmap_value = os.getenv("MY_CONFIGMAP_VALUE")
    my_secret_value = os.getenv("MY_SECRET_VALUE")

    api_values = {
        "my_configmap_value" : my_configmap_value,
        "my_secret_value" : my_secret_value
    }

    return api_values

@app.get("/status")
async def status():
    return {"status": "ok"}
