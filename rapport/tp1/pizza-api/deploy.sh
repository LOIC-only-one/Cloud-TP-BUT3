#!/bin/bash
#
# Script de déploiement automatisé Pizza-Tech API
# Utilisation: ./deploy.sh [build|deploy|all|cleanup]
#

set -e  # Arrête le script en cas d'erreur

# Couleurs pour les logs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="pizza-api"
IMAGE_TAG="v2.0"
NAMESPACE="default"

# Fonction d'affichage
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Fonction de build de l'image
build_image() {
    log_info "Construction de l'image Docker..."
    
    # Build de l'image
    eval $(minikube docker-env)
    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest .
    
    # Scan de sécurité (optionnel mais recommandé)
    log_info "Scan de sécurité avec docker scan (si disponible)..."
    docker scan ${IMAGE_NAME}:${IMAGE_TAG} || log_warn "Docker scan non disponible, installez Snyk pour le scan"
    
    # Audit npm (déjà dans le Dockerfile mais on peut le refaire)
    log_info "Audit des dépendances npm..."
    npm audit --production || log_warn "Vulnérabilités détectées, vérifiez npm audit"
    
    log_info "✓ Image construite avec succès: ${IMAGE_NAME}:${IMAGE_TAG}"
}

# Fonction de déploiement
deploy_k8s() {
    log_info "Déploiement sur Kubernetes/Minikube..."
    
    # Activation des addons nécessaires
    log_info "Vérification des addons Minikube..."
    minikube addons enable ingress
    minikube addons enable metrics-server
    
    # Application des ConfigMap et Secrets
    log_info "Application des ConfigMaps et Secrets..."
    kubectl apply -f deployment/configmap.yaml
    kubectl apply -f deployment/secret.yaml
    
    # Déploiement de l'application
    log_info "Déploiement de l'application..."
    kubectl apply -f deployment/pizza-deployment.yaml
    
    # Attendre que les pods soient prêts
    log_info "Attente du démarrage des pods..."
    kubectl wait --for=condition=ready pod -l app=pizza-api --timeout=120s
    
    # Génération du certificat TLS auto-signé pour le développement
    log_info "Génération du certificat TLS pour HTTPS..."
    generate_tls_cert
    
    # Application de l'Ingress
    log_info "Configuration de l'Ingress HTTPS..."
    kubectl apply -f deployment/ingress.yaml
    
    log_info "✓ Déploiement terminé avec succès!"
    
    # Affichage des informations de connexion
    show_access_info
}

# Fonction de génération de certificat TLS
generate_tls_cert() {
    if kubectl get secret pizza-tls-secret >/dev/null 2>&1; then
        log_info "Certificat TLS déjà existant"
        return
    fi
    
    log_info "Création d'un certificat auto-signé pour pizza-api.local..."
    
    # Génération du certificat auto-signé
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /tmp/tls.key -out /tmp/tls.crt \
        -subj "/CN=pizza-api.local/O=pizza-api" \
        -addext "subjectAltName = DNS:pizza-api.local" 2>/dev/null || {
            openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
                -keyout /tmp/tls.key -out /tmp/tls.crt \
                -subj "/CN=pizza-api.local/O=pizza-api"
        }
    
    # Création du secret Kubernetes
    kubectl create secret tls pizza-tls-secret \
        --key /tmp/tls.key \
        --cert /tmp/tls.crt
    
    # Nettoyage
    rm -f /tmp/tls.key /tmp/tls.crt
    
    log_info "✓ Certificat TLS créé"
}

# Fonction d'affichage des informations d'accès
show_access_info() {
    echo ""
    log_info "=========================================="
    log_info "INFORMATIONS D'ACCÈS"
    log_info "=========================================="
    
    MINIKUBE_IP=$(minikube ip)
    
    echo ""
    log_info "1. Ajouter cette ligne à /etc/hosts:"
    echo "   $MINIKUBE_IP pizza-api.local"
    echo ""
    log_info "2. Accéder à l'API via HTTPS:"
    echo "   https://pizza-api.local/"
    echo "   https://pizza-api.local/menu"
    echo ""
    log_warn "Note: Le certificat est auto-signé, votre navigateur affichera un avertissement"
    echo ""
    log_info "3. Tester avec curl (ignorer le certificat):"
    echo "   curl -k https://pizza-api.local/"
    echo "   curl -k https://pizza-api.local/menu"
    echo ""
    log_info "4. Vérifier le statut des pods:"
    echo "   kubectl get pods -l app=pizza-api"
    echo ""
    log_info "=========================================="
}

# Fonction de nettoyage
cleanup() {
    log_warn "Nettoyage des ressources..."
    
    kubectl delete -f deployment/ingress.yaml --ignore-not-found=true
    kubectl delete -f deployment/pizza-deployment.yaml --ignore-not-found=true
    kubectl delete -f deployment/configmap.yaml --ignore-not-found=true
    kubectl delete -f deployment/secret.yaml --ignore-not-found=true
    kubectl delete secret pizza-tls-secret --ignore-not-found=true
    
    log_info "✓ Nettoyage terminé"
}

# Fonction d'affichage de l'aide
show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     - Construire l'image Docker"
    echo "  deploy    - Déployer sur Kubernetes"
    echo "  all       - Build + Deploy (défaut)"
    echo "  cleanup   - Supprimer toutes les ressources"
    echo "  help      - Afficher cette aide"
    echo ""
}

# Main
case "${1:-all}" in
    build)
        build_image
        ;;
    deploy)
        deploy_k8s
        ;;
    all)
        build_image
        deploy_k8s
        ;;
    cleanup)
        cleanup
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        log_error "Commande inconnue: $1"
        show_help
        exit 1
        ;;
esac
