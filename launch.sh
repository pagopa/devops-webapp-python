#Launch the application using gunicorn backend
#gunicorn -w 4 -b 0.0.0.0:${APP_ENDPOINT_PORT:-8045} app.main:app
# gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:${APP_ENDPOINT_PORT:-8045} --preload --log-level ${VERBOSIT:-INFO} app.main:app
# python ./app/main.py
uvicorn app.main:app --reload --host 0.0.0.0 --port ${APP_ENDPOINT_PORT:-8045} --log-level ${VERBOSIT:-info} --reload
