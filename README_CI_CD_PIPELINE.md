# GitHub Actions CI/CD - Pull Request e Docker Deployment

Questo file spiega passo passo il workflow GitHub Actions per il progetto `myfirstapp`. Il workflow fa:

1. Controlli automatici sulle pull request verso `main`.
2. Pubblicazione dell'immagine Docker su Docker Hub quando la PR viene mergiata su `main`.

---

## 1️⃣ Struttura del workflow

- File workflow: `.github/workflows/ci-cd.yml`
- Trigger:
  - `pull_request` su `main` → build & test
  - `push` su `main` → build, test e deploy su Docker Hub

### Workflow jobs

#### Job: `build-and-test`
- Esegue lint, test e build dell'immagine Docker per controllare che tutto funzioni.
- Steps principali:
  1. Checkout repository
  2. Setup Python 3.11
  3. Cache pip per velocità
  4. Installazione dipendenze
  5. Lint del codice (`flake8`)
  6. Esecuzione test (`pytest`)
  7. Build immagine Docker locale

#### Job: `docker-deploy`
- Si attiva solo quando la PR è mergiata su `main`.
- Dipende dal job `build-and-test`.
- Steps principali:
  1. Checkout repository
  2. Login a Docker Hub usando segreti `DOCKER_HUB_USERNAME` e `DOCKER_HUB_ACCESS_TOKEN`
  3. Build e push dell'immagine Docker su Docker Hub

---

## 2️⃣ Segreti GitHub necessari

- `DOCKER_HUB_USERNAME` → il tuo username Docker Hub
- `DOCKER_HUB_ACCESS_TOKEN` → token di accesso Docker Hub (più sicuro della password)

Questi segreti si impostano in **Settings > Secrets and Variables > Actions** del repository.

---

## 3️⃣ Flusso concettuale

```
Pull Request verso main
        │
        ▼
  Job build-and-test
        │
        ▼ (se tutto OK)
Merge su main
        │
        ▼
  Job docker-deploy
        │
        ▼
Push immagine Docker su Docker Hub
```

- Le PR vengono verificate prima di essere mergiate.
- Il deploy su Docker Hub avviene **solo sul branch main**.

---

## 4️⃣ Comandi che vengono eseguiti

- Checkout codice: `actions/checkout@v3`
- Setup Python: `actions/setup-python@v4`
- Cache pip: `actions/cache@v3`
- Install dependencies: `pip install -r PY/requirements.txt`
- Lint: `flake8 PY/`
- Test: `pytest PY/`
- Build Docker: `docker build -t myfirstapp .`
- Docker login: `docker/login-action@v2`
- Docker push: `docker push ${{ secrets.DOCKER_HUB_USERNAME }}/myfirstapp:latest`

---

## 5️⃣ Vantaggi di questo workflow

1. Automatizza i controlli sulle PR.
2. Garantisce che solo codice testato e corretto venga mergiato.
3. Automatizza il deploy su Docker Hub.
4. Mantiene la CI/CD sicura usando segreti per Docker Hub.
5. Tutto avviene senza intervento manuale, riducendo errori e tempi di deploy.

---

Questo file serve come guida completa per capire **cosa succede nelle GitHub Actions** per le pull request e il deploy Docker.

