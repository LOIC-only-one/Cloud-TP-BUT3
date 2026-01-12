# Stage 1: Build & Audit
FROM node:18-alpine AS builder
WORKDIR /usr/src/app

# Copie des fichiers de dépendances
COPY package*.json ./

# Installation des dépendances et audit de sécurité
RUN npm ci --only=production \
    && npm audit --audit-level=high --production

# Copie du code source
COPY . .

# Stage 2: Production
FROM node:18-alpine AS production

# Ajout d'un utilisateur non-root pour la sécurité
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

WORKDIR /usr/src/app

# Copie des dépendances et du code depuis le builder
COPY --from=builder --chown=nodejs:nodejs /usr/src/app ./

# Nettoyage des fichiers inutiles
RUN rm -rf /usr/src/app/tests /usr/src/app/.git /usr/src/app/*.md

# Changement vers l'utilisateur non-root
USER nodejs

EXPOSE 8080

# Healthcheck intégré
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:8080', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

CMD [ "npm", "start" ]