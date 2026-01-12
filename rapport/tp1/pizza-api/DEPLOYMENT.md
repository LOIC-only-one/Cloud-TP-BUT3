# Guide de Redéploiement - Pizza-Tech API v2.0

## Améliorations apportées

### 1. Configuration externalisée (12-Factor App - Facteur III)
- ✅ Toutes les configurations sont maintenant via variables d'environnement
- ✅ ConfigMap Kubernetes pour la configuration applicative
- ✅ Secret Kubernetes pour les données sensibles (API keys, DB credentials)

### 2. Sécurité renforcée
- ✅ HTTPS obligatoire via Ingress + TLS
- ✅ Secrets externalisés (plus de hardcoding)
- ✅ Image Docker avec utilisateur non-root
- ✅ Image alpine (surface d'attaque réduite)
- ✅ Scan de vulnérabilités intégré au build

### 3. Déploiement scripté/IaC
- ✅ Script `deploy.sh` pour automatiser le déploiement complet
- ✅ Génération automatique des certificats TLS
- ✅ Configuration automatique de l'Ingress

## Étapes de redéploiement

### Prérequis
```bash
# Vérifier que Minikube est démarré
minikube status

# Si arrêté, démarrer avec :
minikube start --driver=docker

# Installer openssl si nécessaire (pour les certificats)
sudo apt-get install openssl
```

### Option 1 : Déploiement automatisé (RECOMMANDÉ)

```bash
# Se placer dans le répertoire pizza-api
cd /home/id00l/Nextcloud/BUT3/Cloud/rapport/tp1/pizza-api

# Rendre le script exécutable
chmod +x deploy.sh

# Déploiement complet (build + deploy)
./deploy.sh all

# OU séparément :
# ./deploy.sh build   # Build de l'image uniquement
# ./deploy.sh deploy  # Déploiement uniquement
```

Le script va automatiquement :
1. Builder l'image Docker avec scan de sécurité
2. Activer les addons Minikube nécessaires (ingress, metrics-server)
3. Appliquer les ConfigMaps et Secrets
4. Déployer l'application avec HPA
5. Générer un certificat TLS auto-signé
6. Configurer l'Ingress HTTPS
7. Afficher les informations d'accès

### Option 2 : Déploiement manuel

```bash
# 1. Builder l'image
eval $(minikube docker-env)
docker build -t pizza-api:v2.0 -t pizza-api:latest .

# 2. Scan de sécurité (optionnel)
npm audit --production

# 3. Activer les addons Minikube
minikube addons enable ingress
minikube addons enable metrics-server

# 4. Appliquer les ressources Kubernetes
kubectl apply -f deployment/configmap.yaml
kubectl apply -f deployment/secret.yaml
kubectl apply -f deployment/pizza-deployment.yaml

# 5. Générer le certificat TLS
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /tmp/tls.key -out /tmp/tls.crt \
    -subj "/CN=pizza-api.local/O=pizza-api" \
    -addext "subjectAltName = DNS:pizza-api.local"

kubectl create secret tls pizza-tls-secret \
    --key /tmp/tls.key \
    --cert /tmp/tls.crt

rm -f /tmp/tls.key /tmp/tls.crt

# 6. Appliquer l'Ingress
kubectl apply -f deployment/ingress.yaml
```

## Configuration de l'accès HTTPS

### 1. Ajouter l'entrée DNS locale

```bash
# Récupérer l'IP de Minikube
MINIKUBE_IP=$(minikube ip)
echo $MINIKUBE_IP

# Ajouter à /etc/hosts (nécessite sudo)
echo "$MINIKUBE_IP pizza-api.local" | sudo tee -a /etc/hosts
```

### 2. Tester l'API en HTTPS

```bash
# Test healthcheck
curl -k https://pizza-api.local/

# Test menu
curl -k https://pizza-api.local/menu

# Test commande
curl -k -X POST https://pizza-api.local/order \
    -H "Content-Type: application/json" \
    -d '{"pizzaId":1,"quantity":2,"address":"123 Rue de la Paix"}'
```

**Note:** Le flag `-k` ignore la vérification du certificat auto-signé. En production, vous utiliseriez Let's Encrypt ou un certificat commercial.

## Vérification du déploiement

```bash
# Vérifier les pods
kubectl get pods -l app=pizza-api

# Vérifier les logs
kubectl logs -l app=pizza-api --tail=50

# Vérifier les ConfigMaps et Secrets
kubectl get configmap pizza-api-config -o yaml
kubectl get secret pizza-api-secret

# Vérifier l'Ingress
kubectl get ingress pizza-api-ingress
kubectl describe ingress pizza-api-ingress

# Vérifier l'HPA
kubectl get hpa pizza-api-hpa
```

## Test de charge pour vérifier l'élasticité

```bash
# Avec Apache Benchmark
ab -n 5000 -c 100 https://pizza-api.local/menu

# OU avec le script de charge
./script.sh

# Observer le scaling en temps réel
kubectl get hpa pizza-api-hpa -w
```

## Modification de la configuration

### Changer une variable d'environnement

```bash
# Éditer le ConfigMap
kubectl edit configmap pizza-api-config

# OU modifier le fichier et réappliquer
nano deployment/configmap.yaml
kubectl apply -f deployment/configmap.yaml

# Redémarrer les pods pour prendre en compte les changements
kubectl rollout restart deployment pizza-api-deployment
```

### Changer un secret

```bash
# Éditer le Secret (base64 encodé)
kubectl edit secret pizza-api-secret

# OU recréer le secret
kubectl delete secret pizza-api-secret
kubectl create secret generic pizza-api-secret \
    --from-literal=API_KEY="nouvelle-cle" \
    --from-literal=DB_CONNECTION_STRING="nouvelle-connection"

# Redémarrer les pods
kubectl rollout restart deployment pizza-api-deployment
```

## Nettoyage

```bash
# Avec le script
./deploy.sh cleanup

# OU manuellement
kubectl delete -f deployment/ingress.yaml
kubectl delete -f deployment/pizza-deployment.yaml
kubectl delete -f deployment/configmap.yaml
kubectl delete -f deployment/secret.yaml
kubectl delete secret pizza-tls-secret
```

## Troubleshooting

### L'Ingress ne fonctionne pas
```bash
# Vérifier que l'addon ingress est activé
minikube addons list | grep ingress

# Vérifier les logs du contrôleur ingress
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller

# Redémarrer l'ingress controller si nécessaire
kubectl delete pod -n ingress-nginx -l app.kubernetes.io/component=controller
```

### Les pods ne démarrent pas
```bash
# Vérifier les événements
kubectl describe pod -l app=pizza-api

# Vérifier les logs
kubectl logs -l app=pizza-api

# Vérifier que l'image est bien chargée
eval $(minikube docker-env)
docker images | grep pizza-api
```

### Le certificat TLS n'est pas accepté
C'est normal avec un certificat auto-signé. Pour l'accepter dans le navigateur :
1. Aller sur https://pizza-api.local/
2. Cliquer sur "Avancé" ou "Advanced"
3. Cliquer sur "Accepter le risque et continuer"

Pour curl, utiliser le flag `-k` ou `--insecure`
