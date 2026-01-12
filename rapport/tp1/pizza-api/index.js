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
    service: `${config.serviceName} v${config.serviceVersion}`,
    environment: config.nodeEnv,
    timestamp: new Date().toISOString()
  });
});

// Menu endpoint (données externalisables via ConfigMap en prod)
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
    estimatedDelivery: config.deliveryTime
  });
});

// Gestion erreurs 404
app.use((req, res) => {
  res.status(404).json({ error: 'Not found' });
});

// Démarrage serveur
app.listen(config.port, () => {
  console.log(`[STARTUP] ${config.serviceName} listening on port ${config.port}`);
  console.log(`[STARTUP] Health check: GET http://localhost:${config.port}/`);
});

// Graceful shutdown (Facteur IX 12-Factor)
process.on('SIGTERM', () => {
  console.log('[SHUTDOWN] SIGTERM received, closing gracefully...');
  process.exit(0);
});
