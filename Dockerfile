FROM python:3.11-slim

# Imposta la directory di lavoro
WORKDIR /app

# Copia il requirements.txt dalla cartella PY nella directory di lavoro
COPY PY/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copia tutto il contenuto della cartella PY
COPY PY/ .

CMD ["python", "src/runMain.py"]