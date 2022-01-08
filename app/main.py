from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"root": "ok"}


@app.get("/status")
async def status():
    return {"status": "ok"}
