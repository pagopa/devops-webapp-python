FROM python:3.10-slim-buster

# Metadata
LABEL name="webapp-python"
LABEL maintainer="pagopa devops team"
LABEL version="0.1"

ARG YOUR_ENV="virtualenv" \
    APP_ENDPOINT_PORT=8000 \
    APP_VERBOSITY="info"

ENV YOUR_ENV=${YOUR_ENV} \
    APP_ENDPOINT_PORT=${APP_ENDPOINT_PORT} \
    APP_VERBOSITY=${APP_VERBOSITY} \
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.1.12 \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# Install poetry dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y libpq-dev gcc curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install project libraries
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# Install poetry - respects $POETRY_VERSION & $POETRY_HOME
RUN pip install --no-cache-dir "poetry==$POETRY_VERSION"

# Project Python definition
WORKDIR /admin-app

#Copy all the project files
COPY pyproject.toml .
#COPY poetry.lock .
COPY /app ./app

COPY launch.sh .

# Install libraries
RUN poetry config virtualenvs.create false \
    && poetry install $(test "$YOUR_ENV" = production) --no-dev --no-interaction --no-ansi

#Launch the main (if required)
RUN chmod +x launch.sh
CMD ["bash", "launch.sh"]
