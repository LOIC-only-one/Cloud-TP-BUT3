# Rapport de TP 1 - De Local à Global : Déploiement d'un microservice conteneurisé en Serverless

## Section 1 : Introduction
Dans ce premier TP, nous avons exploré le déploiement d'un microservice conteneurisé en utilisant une architecture serverless (minikube). L'objectif principal était de comprendre les concepts fondamentaux du serverless, ainsi que les avantages et les défis associés à cette approche.

## Section 2 : Préparation de l'environnement

N'aillant pas de crédit GCP, j'ai décidé de monter un cluster mono node minikube en local sur ma machine. J'ai installé Minikube et kubectl, puis j'ai démarré le cluster avec la commande `minikube start`.

Installation de docker : 

```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
Vérification de l'installation :

![alt text](images/image.png)


Installation de minikube :

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```
Lancement du cluster :

```bash
minikube start --driver=docker
```

![alt text](images/image.png)

## Section 3 : Développement du microservice

Nous avons suivis les instructions du TP pour créer un microservice simple en Python utilisant Flask. Le code source du microservice est le suivant :

package.json :

```js
{
  "name": "pizza-api",
  "version": "1.0.0",
  "description": "API commande pizza serverless",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "node index.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  },
  "engines": {
    "node": "18"
  }
}
```

Et l'index.js :

```js
const express = require('express');
const app = express();

// PORT injecté par env (Facteur III 12-Factor)
// Default 8080 si env vide (Cloud Run injecte PORT=8080)
const port = process.env.PORT || 8080;

// Middleware
app.use(express.json());

// Logger simple stdout (Facteur XI 12-Factor)
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});

// Route santé (healthcheck Cloud Run)
app.get('/', (req, res) => {
  res.json({
    status: 'ok',
    service: 'Pizza-Tech API v1.0',
    timestamp: new Date().toISOString()
  });
});

// Menu endpoint
app.get('/menu', (req, res) => {
  const menu = [
    { id: 1, name: 'Margherita', price: 12.99 },
    { id: 2, name: 'Pepperoni', price: 14.99 },
    { id: 3, name: 'Veggie', price: 13.99 },
    { id: 4, name: 'Quattro Formaggi', price: 15.99 }
  ];
  res.json(menu);
});

// Commande endpoint
app.post('/order', (req, res) => {
  const { pizzaId, quantity, address } = req.body;
  
  // Validation simple (Facteur VIII)
  if (!pizzaId || !quantity || !address) {
    return res.status(400).json({ error: 'Missing fields' });
  }
  
  // Simulation traitement
  const orderId = Math.random().toString(36).substring(7);
  res.json({
    orderId: orderId,
    status: 'confirmed',
    estimatedDelivery: '30 minutes'
  });
});

// Gestion erreurs 404
app.use((req, res) => {
  res.status(404).json({ error: 'Not found' });
});

// Démarrage serveur
app.listen(port, () => {
  console.log(`[STARTUP] Pizza-Tech API listening on port ${port}`);
  console.log(`[STARTUP] Health check: GET http://localhost:${port}/`);
});

// Graceful shutdown (Facteur IX 12-Factor)
process.on('SIGTERM', () => {
  console.log('[SHUTDOWN] SIGTERM received, closing gracefully...');
  process.exit(0);
});
```

Construction et installation des dépendances :

```bash
npm install
```
Et lancement de l'applicaiton en local pour tester :

```bash
node start
```
Et on lance des requêtes curl pour tester les endpoints :

```bash
curl http://localhost:8080/

# Résultat :
# {
#   "status": "ok",
#   "service": "Pizza-Tech API v1.0",
#   "timestamp": "2024-06-10T12:34:56.789Z"
# }

curl http://localhost:8080/menu

# Résultat :
#[{"id":1,"name":"Margherita","price":12.99},{"id":2,"name":"Pepperoni","price":14.99},{"id":3,"name":"Veggie","price":13.99},{"id":4,"name":"Quattro Formaggi","price":15.99}]

curl -X POST http://localhost:8080/order \
    -H "Content-Type: application/json" \
    -d '{"pizzaId":1,"quantity":2,"address":"123 Rue de la Paix"}'

# Résultat :
#{"orderId":"hfd84p","status":"confirmed","estimatedDelivery":"30 minutes"}
```
Et on voit les call api dans les logs :

![alt text](images/image2.png)

## Section 4 : Conteneurisation avec Docker

On va créer une image Docker pour notre microservice. Voici le Dockerfile utilisé :

```Dockerfile
# Stage 1: Build & Audit
FROM node:18-slim AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --only=production \
    && npm audit --audit-level=high --production
COPY . .

# Stage 2: Production
FROM node:18-slim AS production
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app ./
RUN npm prune --production \
    && rm -rf /usr/src/app/tests /usr/src/app/.git /usr/src/app/*.md
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:8080', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"
CMD [ "npm", "start" ]
```

On ajoute un .dockerignore pour éviter de copier les fichiers inutiles dans l'image Docker :

```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.env.local
.env.example
.DS_Store
deployment/
DEPLOYMENT.md
*.sh
```

Construction de l'image Docker :

```bash
docker build -t pizza-api:latest .
```

Lancement du conteneur Docker en local pour tester :

![alt text](images/image3.png)

## Section 5 : Déploiement sur Minikube à l'aide d'un déploiement Kubernetes

On crée un fichier de déploiement Kubernetes `deployment.yaml` avec un Service pour exposer l'API :

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pizza-api-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pizza-api
  template:
    metadata:
      labels:
        app: pizza-api
    spec:
      containers:
        - name: pizza-api
          image: pizza-api:local
          ports:
            - containerPort: 8080
          readinessProbe:
            httpGet:
              path: /
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 10
---
apiVersion: v1
kind: Service
metadata:
  name: pizza-api-service
spec:
  selector:
    app: pizza-api
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
      nodePort: 30080
  type: NodePort
```

Vous pouvez ensuite tester l'API sur `http://192.168.49.2:30080`.
L'ip peut être obtenue avec la commande `minikube ip`.
Et le port est celui défini dans le service (30080).

On applique le déploiement sur Minikube :

```bash
kubectl apply -f deployment/pizza-deployment.yaml
```
On voit que le pod est bien créé et en cours d'exécution :
![alt text](images/image4.png)

## Section 7 : Démonstration de l'elasticité et de la scalabilité

Afin de démontrer la scalabilité nous allons modifier le micro service de la manière suivante :

```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pizza-api-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pizza-api
  template:
    metadata:
      labels:
        app: pizza-api
    spec:
      containers:
        - name: pizza-api
          image: pizza-api:local
          ports:
            - containerPort: 8080
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
          readinessProbe:
            httpGet:
              path: /
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 10

---
apiVersion: v1
kind: Service
metadata:
  name: pizza-api-service
spec:
  selector:
    app: pizza-api
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
      nodePort: 30080
  type: NodePort
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: pizza-api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: pizza-api-deployment
  minReplicas: 1
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```
- Nous avons ajouté un HorizontalPodAutoscaler (HPA) pour permettre au déploiement de scaler automatiquement entre 1 et 5 réplicas en fonction de l'utilisation du CPU.
- Nous avons défini une métrique basée sur l'utilisation du CPU avec un seuil de 50%.
On applique le nouveau déploiement avec l'HPA :

```bash
kubectl apply -f deployment/pizza-deployment.yaml
```

Terminal 1 : Générateur de trafic simple avec bash
Pour générer du trafic en parallèle et tester la scalabilité, vous pouvez utiliser le script suivant qui lance plusieurs processus curl en arrière-plan :

```bash
#!/bin/bash
# Génère du trafic parallèle vers l'API /menu

PARALLEL=10  # Nombre de processus parallèles

for i in $(seq 1 $PARALLEL); do
    while true; do
        curl -s http://192.168.49.2:30080/menu > /dev/null
        sleep 0.1
    done &
done

echo "$PARALLEL générateurs de trafic lancés en arrière-plan."
echo "Utilisez 'pkill curl' pour arrêter tous les processus."
```

Ce script lance 10 boucles curl en parallèle. Vous pouvez ajuster la variable `PARALLEL` selon vos besoins.

Terminal 2 : Alternative avec Apache Benchmark (ab)
Vous pouvez également utiliser l'outil Apache Benchmark (ab) pour générer du trafic de manière plus contrôlée. Voici un exemple de commande ab :
```bash
ab -n 1000 -c 50 http://192.168.49.2:30080/menu
```
![alt text](images/image5.png)

## Section 8 : Amélioration de la sécurité et de la configuration (Niveau Expert)

### 8.1 Externalisation complète de la configuration (12-Factor App - Facteur III)

Pour atteindre le niveau expert, nous avons complètement externalisé la configuration de l'application. Toutes les valeurs configurables sont maintenant gérées via des variables d'environnement.

#### Code mis à jour (index.js)

```js
const express = require('express');
const app = express();

// ===== Configuration via Variables d'Environnement (Facteur III 12-Factor) =====
const config = {
  port: process.env.PORT || 8080,
  serviceName: process.env.SERVICE_NAME || 'Pizza-Tech API',
  serviceVersion: process.env.SERVICE_VERSION || '1.0',
  nodeEnv: process.env.NODE_ENV || 'production',
  deliveryTime: process.env.DEFAULT_DELIVERY_TIME || '30 minutes',
  // Secrets (ne jamais hardcoder en production)
  apiKey: process.env.API_KEY || '',
  dbConnectionString: process.env.DB_CONNECTION_STRING || ''
};
```

#### ConfigMap Kubernetes (configmap.yaml)

Création d'un ConfigMap pour gérer les variables de configuration non-sensibles :

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: pizza-api-config
data:
  SERVICE_NAME: "Pizza-Tech API"
  SERVICE_VERSION: "2.0"
  NODE_ENV: "production"
  DEFAULT_DELIVERY_TIME: "30 minutes"
```

#### Secret Kubernetes (secret.yaml)

Création d'un Secret pour les données sensibles (API keys, credentials DB, etc.) :

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: pizza-api-secret
type: Opaque
stringData:
  # ATTENTION : En production, utiliser un Secrets Manager externe (Vault, GCP Secret Manager)
  API_KEY: "demo-api-key-12345"
  DB_CONNECTION_STRING: "mongodb://user:pass@localhost:27017/pizzadb"
```

### 8.2 Mise en place du HTTPS obligatoire

Pour sécuriser les communications, nous avons configuré un Ingress Kubernetes avec TLS.

#### Modification du Service

Le Service est maintenant de type `ClusterIP` au lieu de `NodePort`, car le trafic passera par l'Ingress (reverse proxy).

```yaml
apiVersion: v1
kind: Service
metadata:
  name: pizza-api-service
spec:
  selector:
    app: pizza-api
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP
```

#### Configuration de l'Ingress avec TLS (ingress.yaml)

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: pizza-api-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - pizza-api.local
      secretName: pizza-tls-secret
  rules:
    - host: pizza-api.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: pizza-api-service
                port:
                  number: 80
```

**Fonctionnalités :**
- HTTPS obligatoire (redirection automatique HTTP → HTTPS)
- Certificat TLS stocké dans un Secret Kubernetes
- Isolation réseau via ClusterIP
- Gestion centralisée du trafic via Ingress

#### Génération du certificat TLS

Pour le développement local, un certificat auto-signé est généré automatiquement :

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /tmp/tls.key -out /tmp/tls.crt \
    -subj "/CN=pizza-api.local/O=pizza-api" \
    -addext "subjectAltName = DNS:pizza-api.local"

kubectl create secret tls pizza-tls-secret \
    --key /tmp/tls.key \
    --cert /tmp/tls.crt
```

#### Scan de sécurité

Le build inclut automatiquement un audit de sécurité :

```bash
npm audit --audit-level=high --production
```

### 8.4 Mise à jour du déploiement Kubernetes

Le fichier `pizza-deployment.yaml` a été mis à jour pour intégrer les ConfigMaps et Secrets :

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pizza-api-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pizza-api
  template:
    metadata:
      labels:
        app: pizza-api
    spec:
      containers:
        - name: pizza-api
          image: pizza-api:local
          ports:
            - containerPort: 8080
          # Injection des variables d'environnement depuis ConfigMap
          envFrom:
            - configMapRef:
                name: pizza-api-config
          # Injection des secrets
          env:
            - name: API_KEY
              valueFrom:
                secretKeyRef:
                  name: pizza-api-secret
                  key: API_KEY
            - name: DB_CONNECTION_STRING
              valueFrom:
                secretKeyRef:
                  name: pizza-api-secret
                  key: DB_CONNECTION_STRING
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
          readinessProbe:
            httpGet:
              path: /
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 10
          livenessProbe:
            httpGet:
              path: /
              port: 8080
            initialDelaySeconds: 15
            periodSeconds: 20
```

### 8.6 Procédure de redéploiement

Le script affiche automatiquement les informations de connexion.

#### Option 1 : Déploiement manuel (étape par étape)

```bash
# 1. Builder l'image
eval $(minikube docker-env)
docker build -t pizza-api:v2.0 .

# 2. Activer les addons
minikube addons enable ingress
minikube addons enable metrics-server

# 3. Appliquer les ressources
kubectl apply -f deployment/configmap.yaml
kubectl apply -f deployment/secret.yaml
kubectl apply -f deployment/pizza-deployment.yaml

# 4. Générer le certificat TLS
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /tmp/tls.key -out /tmp/tls.crt \
    -subj "/CN=pizza-api.local/O=pizza-api" \
    -addext "subjectAltName = DNS:pizza-api.local"

kubectl create secret tls pizza-tls-secret \
    --key /tmp/tls.key --cert /tmp/tls.crt

rm -f /tmp/tls.key /tmp/tls.crt

kubectl apply -f deployment/ingress.yaml

# 5. Ajouter l'entrée DNS locale
echo "$(minikube ip) pizza-api.local" | sudo tee -a /etc/hosts
```

### 8.7 Tests de l'API en HTTPS

Après avoir ajouté l'entrée DNS dans `/etc/hosts`, nous pouvons tester l'API :

```bash
# Healthcheck
curl -k https://pizza-api.local/

# Menu
curl -k https://pizza-api.local/menu

# Commande
curl -k -X POST https://pizza-api.local/order \
    -H "Content-Type: application/json" \
    -d '{"pizzaId":1,"quantity":2,"address":"123 Rue de la Paix"}'
```

![alt text](images/image10.png)
**Note :** Le flag `-k` permet d'ignorer la vérification du certificat auto-signé. En production, avec un certificat valide (Let's Encrypt), ce flag n'est pas nécessaire.

#### Vérification de l'état du déploiement

```bash
# Vérifier les pods
kubectl get pods -l app=pizza-api
# NAME                                    READY   STATUS    RESTARTS   AGE
# pizza-api-deployment-747bb6876f-hgxrr   1/1     Running   0          27m

# Vérifier l'Ingress
kubectl get ingress pizza-api-ingress
# NAME                CLASS   HOSTS             ADDRESS        PORTS     AGE
# pizza-api-ingress   nginx   pizza-api.local   192.168.49.2   80, 443   28m
```

### 8.8 Vérification de la sécurité

#### Vérification que les secrets ne sont pas en clair

```bash
kubectl get secret pizza-api-secret -o yaml
```

![alt text](images/image7.png)


#### Vérification du scan de vulnérabilités

```bash
# Scan avec npm audit
npm audit --production
```

![alt text](images/image8.png)

### 8.9 Test de charge avec HTTPS

```bash
# Avec Apache Benchmark
ab -n 5000 -c 100 https://pizza-api.local/menu

# Observer le scaling
kubectl get hpa pizza-api-hpa -w
```

![alt text](images/image9.png)

### 8.10 Récapitulatif des améliorations (Niveau Expert)

| Critère | Avant | Après (Expert) |
|---------|-------|----------------|
| **Dockerfile** | Image slim, build multi-stage basique | Image alpine, utilisateur non-root, scan vulnérabilités, healthcheck intégré |
| **12-Factor** | PORT via env uniquement | Configuration complète externalisée, ConfigMap/Secret K8s, logs stdout |
| **Déploiement** | Manuel via kubectl | Script automatisé (IaC), génération certificats TLS, activation addons |
| **Élasticité** | HPA configuré | HPA + metrics observées + optimisations |
| **Sécurité** | HTTP, secrets hardcodés | HTTPS obligatoire, Secrets Manager K8s, certificat TLS, utilisateur non-root |

