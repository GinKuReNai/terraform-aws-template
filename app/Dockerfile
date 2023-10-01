FROM python:3.11-buster as build
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN pip install poetry

COPY pyproject.toml* poetry.lock* ./

RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# -------------------------------------

FROM python:3.11-slim-buster as runtime
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages/
COPY --from=build /usr/local/bin/poetry /usr/local/bin/poetry
COPY --from=build /app /app/

ENTRYPOINT ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--reload"]
