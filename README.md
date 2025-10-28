# MyFirstApp - Docker Setup

Questo progetto mostra come creare e distribuire un'app Python utilizzando Docker.  
Contiene un esempio minimale con `src/runMain.py` che stampa `"Hello, world!"`.

---


## 0️⃣ Struttura del progetto

Ecco come è organizzato il progetto:
```
myFirstApp/
├── .git/
├── .gitignore
├── Dockerfile
├── .dockerignore
├── README.md
└── PY/
    ├── requirements.txt
    ├── myEnv
    ├── src/
        ├── runMain.py
```
- `Dockerfile`: definisce come costruire l'immagine Docker
- `.dockerignore`: elenca i file da escludere dalla build dell'immagine
- `.git`: repo locale creato da comando **git init**
- `.gitignore`: elenca i file da escludere nel git commit
- `README.md`: questa guida
- `PY/`: cartella con il codice Python e i requisiti

---

## 1️⃣ Dockerfile

Il **Dockerfile** è il file che definisce **come costruire l'immagine Docker**.  
Ecco un esempio ottimizzato:

```dockerfile
# Usa un'immagine Python leggera
FROM python:3.11-slim

# Imposta la cartella di lavoro nel container
WORKDIR /app

# Copia i requisiti nella cartella di lavoro e installa le dipendenze senza cache pip
COPY PY/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia tutta la cartella PY nella cartella di lavoro
COPY PY/ .

# Comando di default all'avvio del container
CMD ["python", "src/runMain.py"]
```

---

## 2️⃣ .dockerignore

Il **.dockerignore** serve a **escludere file e cartelle** che non devono entrare nell'immagine Docker, riducendo dimensione e tempo di build.

Esempio:

```dockerignore
__pycache__/
*.pyc
*.pyo
*.pyd
*.py~
*.egg-info/
*.egg
PY/myenv
venv/
.env/
build/
dist/
.git
.gitignore
*.log
.DS_Store
Thumbs.db
```

---

## 3️⃣ Comandi principali

### Costruire l'immagine
```bash
docker build -t myfirstdockerapp .
```

### Verificare le immagini disponibili
```bash
docker images
```

### Avviare il container
```bash
docker run --rm myfirstdockerapp
```

> Opzione interattiva (utile per vedere log o debug):
```bash
docker run -it --rm myfirstdockerapp
```

### Taggare e pubblicare l'immagine su Docker Hub
```bash
# Taggare con username e versione
docker tag myfirstdockerapp YOUR_USERNAME_ON_DOCKER_HUB/myfirstdockerapp:1.0

# Login a Docker Hub
docker login

# Pusha l'immagine
docker push YOUR_USERNAME_ON_DOCKER_HUB/myfirstdockerapp:1.0
```

### Scaricare e avviare l'immagine da Docker Hub
```bash
docker pull YOUR_USERNAME_ON_DOCKER_HUB/myfirstdockerapp:1.0
docker run --rm YOUR_USERNAME_ON_DOCKER_HUB/myfirstdockerapp:1.0
```

---

## 4️⃣ Suggerimenti

- Usare `--no-cache-dir` nel Dockerfile riduce le dimensioni dell'immagine.  
- Usare `.dockerignore` evita di copiare file inutili (venv, .git, build).  
- Per aggiornare l'immagine su Docker Hub, incrementare il tag (es. `1.1`) e ripushare.  

---

## 5️⃣ Risultato

Avviando il container, vedrai:
```
Hello, world!
```
proprio come definito in `src/runMain.py`.

