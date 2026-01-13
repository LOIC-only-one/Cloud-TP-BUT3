## MODULE 1 : FONDAMENTAUX DU CLOUD COMPUTING

## Support de Cours Étudiant – Licence 3 BUT R&T
**Date :** Janvier 2026  

---

## TABLE DES MATIÈRES

1. Qu'est-ce que le Cloud Computing ?
2. Les 5 Caractéristiques Essentielles (NIST)
3. Modèle de Responsabilité Partagée
4. Les Trois Modèles de Déploiement
5. Classification des Services Cloud
6. Tendances 2024-2026 : Edge, FinOps, Souveraineté
7. Matrice de Sélection Décisionnelle

---

## CHAPITRE 1 : QU'EST-CE QUE LE CLOUD COMPUTING ?

### 1.1 Définition Fondamentale

Le **cloud computing** (informatique en nuage) est un modèle révolutionnaire de fourniture de ressources informatiques — serveurs, stockage, bases de données, logiciels — à travers Internet, **sur demande et sans besoin de détenir physiquement l'infrastructure**.

**Définition NIST SP 800-145 (2011, actualisée 2024) :**
> Le cloud computing est un modèle permettant un accès à un ensemble partagé de ressources informatiques configurables (réseaux, serveurs, stockage, applications, services) qui peut être rapidement approvisionné et libéré avec un effort de gestion minimal ou une interaction du fournisseur de services.

### 1.2 Évolution Historique et Contexte

| Période       | Événement                                       | Impact                                 |
| ------------- | ----------------------------------------------- | -------------------------------------- |
| **2000-2005** | Virtualisation matérielle émerge                | Infrastructure décomposée              |
| **2006**      | AWS lance EC2                                   | Premier service IaaS commercial viable |
| **2008-2012** | Adoption massive SaaS (Salesforce, Google Apps) | Cloud devient mainstream               |
| **2015-2020** | Conteneurs (Docker) et Kubernetes               | Architecture cloud-native normalisée   |
| **2020-2024** | Multi-cloud courant ; FinOps émerge             | Optimisation coûts critique            |
| **2024-2026** | Edge Computing + IA distribuée                  | Calcul rapproché données essentielles  |

### 1.3 Pourquoi le Cloud ? Quatre Moteurs Économiques

#### 1️⃣ **Réduction des Coûts Initiaux (CAPEX → OPEX)**

**Avant (Datacenter On-Premise) :**
- Investissement initial : 500k€-2M€ pour serveurs
- Temps acquisition : 3-4 mois (achat, livraison, installation)
- Utilisation : souvent <30% capacité moyenne (surprovisionnement)
- Risque : Si demande < prévision, matériel inutilisé = perte

**Avec Cloud Public :**
- Investissement initial : 0€
- Temps acquisition : 5 minutes (interface web)
- Utilisation : scaling à la demande exactement
- Flexibilité : Augmenter/réduire selon pics réels

**Exemple Numérique :**
```
Startup Web 10 développeurs

Scénario On-Premise :
  • Serveurs : 200k€
  • Réseau : 30k€
  • Personnel IT : 50k€/an
  • Électricité : 12k€/an
  • 1ère année : 292k€ CAPEX + OPEX

Scénario Cloud :
  • Serveurs : 0€ CAPEX
  • Infrastructure : 3k€/mois OPEX = 36k€/an
  • Personnel IT : 0€ (moins d'ops)
  • 1ère année : 36k€
  
Économie : 256k€ (88% réduction coûts année 1)
```

#### 2️⃣ **Scalabilité Élastique**

| Situation | Datacenter | Cloud |
|-----------|-----------|-------|
| Charge normale (100 req/s) | 5 serveurs actifs | 3 instances = 300€/mois |
| Pic (500 req/s, 2h) | Impossible sans achat | 15 instances = 1500€ pour 2h |
| Après pic | Capacité inutile 4-5 serveurs | Zéro instances = 0€ |
| Gestion | Technique ET risque business | Automatisé par règles |

**Implication :** E-commerce peut gérer pics Noël sans investir dans matériel.

#### 3️⃣ **Agilité et Time-to-Market**

**Temps déploiement :**
- On-premise : 3-4 mois
- Cloud public : **5 minutes**

**Implication pour startup :** Valider hypothèse business en semaines, pas trimestres.

#### 4️⃣ **Accès à Expertise Globale**

En cloud public, vous utilisez services gérés (bases de données, machine learning, streaming temps réel) que petite équipe ne pourrait jamais construire et maintenir seule.

**Exemple :** Utiliser Google Cloud BigQuery pour analytics distribuées vs. recruter 5 data engineers.

---

## CHAPITRE 2 : LES 5 CARACTÉRISTIQUES ESSENTIELLES (NIST)

### 2.1 Self-Service à la Demande

**Définition :** L'utilisateur approvisionne ressources informatiques **24/7 sans intervention manuelle** du fournisseur, via interface web ou API.

**Caractéristiques :**
- ✅ Création instances, stockage, bases de données en minutes
- ✅ Modification/suppression sans processus administratif
- ✅ Accès 24/7 indépendant horaires support IT
- ✅ Automatisation par API (Infrastructure as Code)

**Exemple Concret :**
> Vous êtes développeur, 14h un samedi. Vous avez besoin de 3 serveurs web pour test charge. 
> - Datacenter : Appel hotline IT (fermée), attendre lundi, processus 2 jours
> - Cloud AWS : Console web → Click "Launch 3 instances" → 5 minutes → Online
> 
> Flexibilité = productivité

**Implication Pédagogique :** Étudiants deviennent **opérationnels immédiatement** sans dépendre de l’IT.

### 2.2 Accès Réseau Large

**Définition :** Les services cloud sont accessibles via **réseau standard (Internet)** sur **tous types appareils**.

**Appareils Supportés :**
- PC bureau (Windows, macOS, Linux)
- Tablettes (iPad, Android)
- Smartphones
- Objets IoT (capteurs, routeurs)
- Montres connectées

**Exemple — Google Workspace :**
```
09:00 - Paris, Bureau, PC Windows
       Edit Google Sheet "Budget Q1"

11:00 - Avion, iPad
       Continue edit = données synchro temps réel

17:00 - Métro, Smartphone
       Vérifier le sheet = données à jour

→ ZÉRO synchronisation manuelle, accès ubiquitaire
```

**Implication :** Mobilité complète, travail hybride transparent.

### 2.3 Mutualisation des Ressources (Resource Pooling)

**Définition :** Les ressources physiques **sont partagées entre plusieurs clients** (multi-tenancy), avec allocation dynamique selon la demande.

**Illustration Architecturale :**

```
Serveurs Physiques AWS eu-west-1 (Irlande)

Serveur Physique 1 (Intel Xeon, 64GB RAM)
├─ Client A : Instance VM_1 (2 vCPU, 8GB RAM)
├─ Client B : Instance VM_2 (4 vCPU, 16GB RAM)
├─ Client C : Instance VM_3 (2 vCPU, 8GB RAM)
└─ Slack disponible : 2 vCPU, 32GB RAM

↓ HEURE 14H (Pic pour Client B)

Serveur Physique 1
├─ Client A : Instance VM_1 (2 vCPU, 8GB RAM) — réduite
├─ Client B : Instance VM_2b (6 vCPU, 20GB RAM) — augmentée
├─ Client B : Instance VM_2c (2 vCPU, 4GB RAM) — NOUVELLE
├─ Client C : Instance VM_3 (2 vCPU, 8GB RAM)
└─ Slack : 0 vCPU
```

**Avantage Économique :** AWS peut facturer 1000 clients sur 100 serveurs, car **statistiquement jamais tous les clients simultanément au maximum**. Mathématique d'économies d'échelle.

**Implication Sécurité :** 
- ✅ Données Client A et Client B sur MÊME serveur physique
- ✅ Hyperviseur (Xen/KVM) isole cependant les machines virtuelles
- ⚠️ Théoriquement, failles hyperviseur (très rares) pourraient permettre saut inter-VM
- ✅ Mitigation : chiffrement données en transit + at-rest

**Concept Clé :** Resource pooling = profit margin AWS possible.

### 2.4 Élasticité Rapide

**Définition :** **Augmentation/réduction automatique** des capacités en fonction de la demande, par règles ou manuelle.

**Mécanisme (Auto-scaling):**
```
Règle définie : "Si average CPU > 70% pendant 2 min → +1 serveur"
                "Si average CPU < 20% pendant 5 min → -1 serveur"

Timeline:
09:00 - Charge normale
        ├─ 2 serveurs web
        ├─ CPU avg : 45%
        └─ Coût : 500€/mois

12:00 - Lunch peak
        ├─ CPU avg : 82% (DÉCLENCHE règle +1)
        ├─ 3 serveurs web (auto-add)
        └─ CPU retombe 65%

12:05 - Pic disparu
        ├─ CPU avg : 25% (DÉCLENCHE règle -1)
        ├─ 2 serveurs web (auto-remove)
        └─ Coût revient 500€/mois
```

**Cas d'Usage Réel : E-Commerce Pic Noël**

| Période | Serveurs | Coût Mensuel | Notes |
|---------|----------|-------------|-------|
| Janvier-Octobre | 5 serveurs | 1500€ | Load normal |
| Novembre-Décembre | Auto-scale à 30 | 9000€ | Pic shopping |
| Janvier | Retour à 5 | 1500€ | Automatic |

**Sans cloud :** Acheter 30 serveurs (300k€) pour 2 mois usage = bête.

**Avec cloud :** Payer 9000€ spot usage 2 mois = intelligent.

**Implication :** Pas de surprovisionnement, pas de sous-capacité → rentabilité maximale.

### 2.5 Mesure de la Consommation (Pay-as-You-Go)

**Définition :** **Facturation à l'usage** avec transparence totale sur ressources consommées.

**Modèles de Facturation Courants :**

| Ressource | Unité de Facturation | Exemple Prix |
|-----------|---------------------|--------------|
| **Calcul (EC2)** | Par heure/seconde | 0,012€/h (~11€/mois 24h) |
| **Stockage (S3)** | Par GB/mois | 0,023€/GB (~23€/TB/mois) |
| **Transfert Out** | Par GB sortant | 0,09€/GB |
| **Bases de données** | Par heure + stockage | 0,025€/h + 0,1€/GB |
| **Serverless (Lambda)** | Par 1M invocations + durée | 0,20€/M invocations + 0,0000166€/ms |

**Transparence Totale :**

```
Facture AWS Janvier 2026 :
├─ EC2 : 2 instances × 0,012€/h × 730h = 17,52€
├─ S3 : 500GB × 0,023€/GB = 11,50€
├─ CloudFront (CDN) : 50GB × 0,085€/GB = 4,25€
├─ RDS (Base données) : 0,025€/h × 730h = 18,25€
├─ Lambda : 10M appels × 0,20€/M = 2,00€
└─ **TOTAL : 53,52€/mois**

→ Chaque service visible, coûts traçables, responsabilité du client
```

**Avantage :** Vous ne payez que ce que vous consommez.

**Risque (Bill Shock) :** Si mal configuré, une requête infinie → facture explosive.

**Exemple de Danger :**
```
Oubli : Laisser instance large (16 vCPU) overnight
Coût : 0,85€/h × 8h = 6,80€ (benin)

Vrai danger : DDoS ou requête boucle infinie
→ 1000 requêtes/s × 100k appels Lambda overnight
→ Coût : 0,20€/M × 100M = 20,000€ FACTURE EN UNE NUIT

Mitigation : Alerte budget automatique
```

---

## CHAPITRE 3 : MODÈLE DE RESPONSABILITÉ PARTAGÉE

### 3.1 Concept Fondamental

En cloud, la **sécurité et conformité ne sont PLUS une responsabilité exclusive du client**. Elles sont **partagées entre client et fournisseur**, selon le modèle de service.

**Principe :** Plus le service monte l'échelle (IaaS → PaaS → SaaS), **moins le client contrôle**, mais **plus le fournisseur assume de responsabilités**.

### 3.2 Responsabilités par Modèle

#### **On-Premise (Datacenter Client)**

```
✋ CLIENT RESPONSABLE (100%) :
├─ Sécurité physique bâtiment (caméras, portes)
├─ Matériel serveurs, disques durs, réseau
├─ Virtualisation (hyperviseur Xen/KVM)
├─ Système d'exploitation (installation, patching)
├─ Middleware, bases de données
├─ Applications métier
├─ Données
├─ Chiffrement, authentification
├─ Sauvegardes, disaster recovery
└─ Conformité légale (RGPD, HDS, etc.)
```

**Implication :** Autonomie totale, MAIS responsabilité massive.

---

#### **IaaS — Infrastructure as a Service**
*Exemples : AWS EC2, Azure VMs, Google Compute Engine*

```
Client responsable :
├─ Système d'exploitation (patching sécurité)
├─ Applications métier
├─ Authentification utilisateurs
└─ Données

Fournisseur responsable :
├─ Sécurité physique datacenter
├─ Matériel serveurs
├─ Hyperviseur (virtualisation)
├─ Réseau physique
├─ Pare-feu core infrastructure
└─ Redondance stockage
```

**Risque Majeur Client :** Mal configurer groupe de sécurité AWS → EC2 exposée Internet = 60% breaches cloud.

**Mitigation :** Infrastructure as Code (Terraform) + audits automatisés.

---

#### **PaaS — Platform as a Service**
*Exemples : Google App Engine, AWS Elastic Beanstalk, Heroku, Cloud Run*

```
Client responsable :
├─ Code application
├─ Données métier
└─ Gestion authentification utilisateurs

Fournisseur responsable :
├─ OS (et patches sécurité)
├─ Runtime (Java, Python, Node.js)
├─ Middleware (serveurs app, cache)
├─ Bases de données gérées
├─ Scaling automatique
└─ Infrastructure complète
```

**Exemple Risque :** Injection SQL dans app → database PaaS hackée.

**Implication :** Fournisseur gère infrastructure, client gère sécurité applicative.

---

#### **SaaS — Software as a Service**
*Exemples : Salesforce, Gmail, Microsoft 365, Slack*

```
Client responsable :
├─ Données métier
├─ Configuration app (paramètres)
└─ Gestion des accès utilisateurs

Fournisseur responsable :
├─ Tout le reste (applications, serveurs, OS, sauvegardes, sécurité)
└─ Mises à jour automatiques
```

**Implication :** Client = utilisateur, fournisseur = administrateur complet.

**Avantage :** Zéro maintenance technique.

**Inconvénient :** Dépendance complète, données = propriété fournisseur (TOS).

---

### 3.3 Implications de Sécurité Approfondies

#### **Risques Spécifiques par Modèle**

| Modèle | Risque Majeur | Exemple | Mitigation |
|--------|-------------|---------|-----------|
| **IaaS** | Misconfiguration sécurité | Groupe sécurité permettant 0.0.0.0:22 | Audits automatisés (Prowler, etc.) |
| **PaaS** | Injection SQL, XSS | App non validée entrées | OWASP Top 10 secure coding |
| **SaaS** | Compromission compte admin | Phishing mot de passe admin | MFA mandatory, SSO |
| **Tous** | Chiffrement données | Données en clair stockage | Chiffrement at-rest + TLS |

#### **Données en Transit vs At-Rest**

**Données en Transit :** Informations circulant réseau (client → cloud).
- ✅ Chiffrement TLS 1.3 (HTTPS) standard aujourd'hui
- ⚠️ Risque : Certificat auto-signé, connexion non encryptée

**Données at-Rest :** Informations stockées disque.
- ✅ Cloud fournisseur chiffre généralement (AES-256)
- ⚠️ Clés gérées par fournisseur (vous n'avez pas le contrôle)
- ✅ Option : Client-side encryption (vous déchiffrez localement)

**Exemple Réel :** Slack chiffre données en transit (TLS), MAIS clés de chiffrement **détenus par Slack** (pas vous). Si Slack subpoenaed, données accessibles.

---

## CHAPITRE 4 : LES TROIS MODÈLES DE DÉPLOIEMENT

### 4.1 Cloud Public

**Définition :** Infrastructure cloud **partagée entre plusieurs organisations clients**, exploitée par fournisseur tiers commercial.

#### **Caractéristiques**

| Aspect | Description |
|--------|-------------|
| **Propriétaire** | Fournisseur tiers (AWS, Azure, GCP) |
| **Accès** | Via Internet, ouvert monde entier |
| **Coûts** | Pay-as-you-go OPEX (pas CAPEX) |
| **Scalabilité** | Pratiquement illimitée |
| **Sécurité** | Responsabilité partagée |
| **Conformité** | Dépend fournisseur (HDS, PCI-DSS) |
| **Contrôle** | Minimal sur infrastructure physique |

#### **Fournisseurs Majeurs (2024)**

```
Répartition marché IaaS+PaaS global :

AWS                32% - Leader incontesté, services les plus nombreux
  ├─ EC2 (VMs)
  ├─ S3 (stockage)
  ├─ RDS (bases de données)
  └─ Lambda (serverless)

Microsoft Azure    23% - Intégration forte Microsoft, forces enterprise
  ├─ VMs
  ├─ App Service (PaaS)
  ├─ SQL Database
  └─ Synapse (analytics)

Google Cloud       11% - Forces en data, AI, machine learning
  ├─ Compute Engine (VMs)
  ├─ App Engine (PaaS)
  ├─ BigQuery (analytics distribué)
  └─ Cloud AI Platform

Autres (Alibaba, IBM, Oracle, etc.) : 34%
```

#### **Analogie Pédagogique : Pizza-as-a-Service**

Pour comprendre les modèles rapidement :

| Niveau | Analogie | Cloud | Responsabilités Client |
|--------|----------|-------|----------------------|
| **On-Premise** | Cuisine maison | - | Acheter ingrédients, cuire, servir, nettoyer |
| **IaaS** | Take & Bake | EC2, GCE | Cuire pizza (acheter préparation), servir, nettoyer |
| **PaaS** | Livraison pizza | App Engine | Servir, manger (fournisseur cuit) |
| **SaaS** | Restaurant | Gmail, Salesforce | Manger (restaurant gère tout) |

**Détail du modèle IaaS (Take & Bake) :**
```
Fournisseur cloud fourni :
├─ Serveur physique (four)
├─ Hyperviseur (cuisson automatisée)
├─ Réseau (livraison ingrédients)
└─ Stockage disque (frigo)

Vous apportez :
├─ Système d'exploitation (recette base)
├─ Middleware, applications
├─ Données métier
└─ Sécurité applicative
```

#### **Avantages ✅**

- ✅ Coûts minimaux CAPEX (zéro investissement initial)
- ✅ Scalabilité à la demande sans limite technique
- ✅ Services gérés (mises à jour, patches, backups fournisseur)
- ✅ Accès global datacenters multiples (latence optimale)
- ✅ Modèle pay-as-you-go = flexibilité financière

#### **Inconvénients ❌**

- ❌ **Vendor Lock-in** : APIs propriétaires, migration coûteuse vers concurrent
- ❌ Sécurité partagée = responsabilité client importante (misconfiguration = breach)
- ❌ Performances variables (trafic réseau, partage ressources)
- ❌ Coûts imprédictibles si dimensionnement mauvais (runaway costs)
- ❌ Moins de contrôle configurations infrastructure

#### **Cas d'Usage Idéaux**

- 🎯 Startups, PME (budget IT limité)
- 🎯 Applications web scalables (SaaS, APIs)
- 🎯 Déploiement rapide prototypes (time-to-market critique)
- 🎯 Services B2C distribués (analytics, IoT)
- 🎯 Devops first : équipes DevOps réduites

---

### 4.2 Cloud Privé

**Définition :** Infrastructure cloud **dédiée à une seule organisation**, soit hébergée **datacenter interne** soit **loué en exclusivité** auprès fournisseur.

#### **Caractéristiques**

| Aspect | Description |
|--------|-------------|
| **Propriétaire** | Organisation elle-même ou loué exclusif |
| **Accès** | Réseau interne ou VPN sécurisé |
| **Coûts** | CAPEX (matériel) + OPEX (équipes IT) |
| **Scalabilité** | Limitée par capacité physique existante |
| **Sécurité** | Contrôle complet |
| **Conformité** | Maîtrisée 100% par organisation |
| **Contrôle** | Total sur pile complète |

#### **Solutions Cloud Privé Open-Source**

| Solution | Spécialité | Exemple |
|----------|-----------|---------|
| **OpenStack** | Standard industrie complet | Hyperviseur Nova, réseau Neutron, stockage Cinder |
| **Proxmox** | PME, KVM natif, interface intuitive | Web UI, VM/conteneurs, clustering |
| **OpenNebula** | Orchestration légère, multi-hyperviseur | Edge-friendly, portable |
| **CloudStack** | Enterprise-grade, AWS-like API | Monétisation possible |

#### **Avantages ✅**

- ✅ Contrôle sécurité total (pas de partage ressources)
- ✅ Conformité garantie (RGPD, HDS, données sensibles)
- ✅ Performance prévisible (pas de contention)
- ✅ Zéro vendor lock-in (open-source)
- ✅ Amortissement long terme (5+ ans = ROI positif)

#### **Inconvénients ❌**

- ❌ Coûts CAPEX énormes (serveurs : 50-100k€+)
- ❌ Scalabilité limitée par infrastructure physique
- ❌ Équipes IT internes requises (expertise élevée)
- ❌ Maintenance logicielle = responsabilité client
- ❌ ROI long terme (3-5 ans minimum avant profitabilité)

#### **Cas d'Usage Idéaux**

- 🎯 Données critiques, sensibles (santé, finance, gouvernement)
- 🎯 Conformité légale stricte (RGPD, HDS, cloud souverain)
- 🎯 Applications latence zéro (trading temps réel)
- 🎯 Grands groupes équipes IT existantes
- 🎯 Industries réglementées (énergie, défense, finance)

---

### 4.3 Cloud Hybride

**Définition :** **Combinaison cloud public + cloud privé** avec intégration seamless, partageant données et applications.

#### **Caractéristiques**

| Aspect | Description |
|--------|-------------|
| **Propriétaire** | Mixte (organisation + fournisseur public) |
| **Accès** | Réseau privé + Internet selon besoin |
| **Coûts** | CAPEX hybride + OPEX hybride |
| **Scalabilité** | Élastique (débordement public quand besoin) |
| **Sécurité** | Stratégies mixtes par type charge |
| **Conformité** | Données sensibles privé, autres public |
| **Contrôle** | Granulaire par ressource |

#### **Architectures Hybrides Courantes**

##### **1. Cloud Burst (Débordement Dynamique)**

```
Architecture :

Privé (On-Premise) : Infrastructure de base stable
├─ 5 serveurs permanents
├─ Capacité fixe = coûts fixes prévisibles
└─ Coût : 500k€ CAPEX + 50k€/an OPEX

Public (AWS) : Ressources élastiques
├─ 0 instances en charge normal
├─ N instances quand pics
└─ Coût : Variable selon demande

Cas d'Usage : E-commerce pics saisonniers
├─ Janvier-Octobre : 5 serveurs privé (500€/mois)
├─ Novembre-Décembre : +30 instances public (peak 9k€/mois)
├─ Janvier : Retour 5 serveurs privaté
└─ Total année : 6×500 + 2×9k + 4×500 = 25k€
```

**Avantage :** Données sensibles (client info) restent privé, scaling économe.

---

##### **2. Cloud Tiering (Stratification par Température Données)**

```
Données "Chaudes" (accès fréquent) :
├─ Base de données active (transactions)
├─ Cache applicatif
└─ Localisation : Cloud public (fast, AWS RDS)

Données "Tièdes" (accès occasionnel) :
├─ Données 6-12 mois anciennes
└─ Localisation : Cloud privé (coûts réduits)

Données "Froides" (archives) :
├─ Légales, compliance requises
├─ Accès rare
└─ Localisation : Stockage privé bon marché (Glacier, Nearline)
```

**Bénéfice :** Optimisation coûts — vous payez complexité selon température données.

---

#### **Avantages ✅**

- ✅ Flexibilité optimale (coûts, sécurité, scalabilité)
- ✅ Scalabilité à demande sans CAPEX énormes
- ✅ Données sensibles localisées, autres scalables
- ✅ Continuité service et failover rapide
- ✅ Mitigation vendor lock-in (diversification)

#### **Inconvénients ❌**

- ❌ Complexité accrue (2 infrastructures différentes)
- ❌ Coûts intégration élevés (middleware, outils)
- ❌ Compétences multiples requises
- ❌ Latence inter-cloud possible (données passent Internet)
- ❌ Conformité fragmentée (audit complexe)

#### **Cas d'Usage Idéaux**

- 🎯 Entreprises en migration progressive vers cloud
- 🎯 Applications legacy + modernes coexistent
- 🎯 Conformité partielle (données sensibles on-site, services public)
- 🎯 Haute disponibilité requise
- 🎯 Optimisation coûts (public variable + privé fixe)

---

### 4.4 Tableau Comparatif Synthétique

| Critère | **Cloud Public** | **Cloud Privé** | **Hybride** |
|---------|---|---|---|
| **Coûts CAPEX** | 0€ | 500k€+ | 300k€+ |
| **Coûts OPEX/mois** | 100-1k€ | 10k€ | 5k€ |
| **Scalabilité** | Illimitée ✅ | Limitée ⚠️ | Élastique ✅ |
| **Sécurité** | Partagée ⚠️ | Totale ✅ | Granulaire ✅ |
| **Conformité** | Fournisseur-dépendant | Totale ✅ | Configurable |
| **Vendor Lock-in** | Risque majeur ❌ | Zéro ✅ | Mitigé ✅ |
| **Time-to-Deploy** | 5 min | 2-3 mois | 2 semaines |
| **Expertise requise** | Moyenne | Élevée | Très élevée |

---

## CHAPITRE 5 : CLASSIFICATION DES SERVICES CLOUD

### 5.1 IaaS — Infrastructure as a Service

**Définition :** Client loue **infrastructure informatique virtualisée** (serveurs, stockage, réseau). Client gère OS et applications.

**Services Principaux :**
- Machines virtuelles (AWS EC2, Azure VMs, Google Compute Engine)
- Stockage objet (AWS S3, Azure Blob Storage)
- Bases de données (gérées) (AWS RDS, Azure SQL Database)
- Réseaux virtuels (VPCs, Security Groups)

**Responsabilités :**
- ✋ Client : OS, patchs sécurité, applications, données
- 🛡️ Fournisseur : Infrastructure, hyperviseur, réseau physique

**Cas d'Usage :** Applications web traditionnelles, serveurs web/appli, bases de données.

**Coût Exemple :** 0,012€/h instance t2.micro AWS (~11€/mois 24h).

---

### 5.2 PaaS — Platform as a Service

**Définition :** Fournisseur gère **infrastructure + OS + runtime**. Client déploie **code applicatif seulement**.

**Services Principaux :**
- Google App Engine (deploy automatique)
- AWS Elastic Beanstalk (PaaS sur EC2)
- Heroku (code → production, push git)
- Google Cloud Run (containers serverless)

**Responsabilités :**
- ✋ Client : Code, données, configuration
- 🛡️ Fournisseur : OS, runtime, scaling, déploiement, backups

**Avantages :**
- ✅ Zero ops (fournisseur gère infrastructure)
- ✅ Déploiement trivial (push code)
- ✅ Scaling automatique intégré
- ✅ Services gérés inclus (databases, caching)

**Inconvénients :**
- ❌ Moins de contrôle (customization limitée)
- ❌ Vendor lock-in (APIs propriétaires)
- ❌ Coûts moins prédictibles (scaling automatique)

**Cas d'Usage :** Startups web, APIs rapides, prototypes.

**Coût Exemple :** Cloud Run: 0,20€ par million invocations + 0,0000166€ par ms exécution.

---

### 5.3 SaaS — Software as a Service

**Définition :** Fournisseur gère **application complète**. Client = utilisateur uniquement.

**Services Courants :**
- Email (Gmail, Outlook)
- Collaboration (Google Workspace, Microsoft 365)
- CRM (Salesforce)
- Productivité (Slack, Figma, Notion)
- Analytics (Mixpanel, Amplitude)

**Responsabilités :**
- ✋ Client : Données métier, configuration, gestion accès utilisateurs
- 🛡️ Fournisseur : Tout (application, serveurs, sécurité, mises à jour)

**Avantages :**
- ✅ Zéro maintenance technique
- ✅ Mises à jour automatiques
- ✅ Accessibilité universelle (navigateur)
- ✅ Coûts prédictibles (abonnement fixe)

**Inconvénients :**
- ❌ Dépendance complète fournisseur
- ❌ Données = propriété fournisseur (TOS)
- ❌ Customization très limitée
- ❌ Lock-in maximum

**Cas d'Usage :** Outils productivité, CRM, communication.

**Coût Exemple :** Salesforce 100€/utilisateur/mois.

---

### 5.4 FaaS — Functions-as-a-Service (Serverless)

**Définition :** Modèle où client déploie **fonctions événementielles isolées** sans gérer serveurs. Scaling automatique, paiement milliseconde.

**Services :**
- AWS Lambda
- Google Cloud Functions
- Azure Functions
- IBM Cloud Functions

**Responsabilités :**
- ✋ Client : Code fonction seulement
- 🛡️ Fournisseur : Tout (serveurs, OS, scaling, infrastructure)

**Cas d'Usage Optimaux :**
- Webhooks (GitHub push → slack notification)
- Traitement asynchrone (upload image → redimensionnement)
- APIs REST légères et stateless
- Batch jobs événementiels

**Avantages :**
- ✅ Coûts minimaux (paiement milliseconde)
- ✅ Scaling instantané (0 → 1000 invocations/s)
- ✅ Zéro infrastructure management
- ✅ Déploiement trivial (upload code)

**Inconvénients :**
- ❌ Cold start (1-5 sec initialisation première invocation)
- ❌ Vendor lock-in extrême (APIs propriétaires)
- ❌ Limitations (timeout 15 min, mémoire max 10GB)
- ❌ Débuggage complexe (logs cloud-only)
- ❌ Coûts explosifs si trafic imprévisible

**Coût Exemple :** AWS Lambda 0,20€/million invocations + 0,0000166€/ms.

**Exemple Réel (Webhook GitHub) :**
```
Événement : Commit push à repository

Fonction Lambda (Node.js) :
  ├─ Reçoit webhook GitHub
  ├─ Appelle Slack API → post message
  ├─ Retourne HTTP 200
  └─ Exécution 50ms

Coûts mensuels :
  ├─ 1000 commits/mois = 1000 invocations
  ├─ Coût invocations : 1000 / 1M × 0,20€ = 0,0002€
  ├─ Coût exécution : 1000 × 50ms × 0,0000166€ = 0,0008€
  └─ TOTAL : 0,001€ (~négligeable)
```

---

## CHAPITRE 6 : TENDANCES 2024-2026

### 6.1 Edge Computing

**Définition :** Traitement des données **à la périphérie du réseau** plutôt qu'en datacenter distant, réduisant latence et bande passante.

**Exemples Edge Computing :**

| Cas d'Usage | Latence Cloud | Latence Edge | Implication |
|------------|--------------|------------|-------------|
| Voiture autonome (freinage) | 100-500ms | 5-10ms | **Impossible cloud** |
| Caméra surveillance + IA | 200-500ms | 10-50ms | Cloud = trop lent |
| Jeu multijoueur FPS | 50-100ms | 10-20ms | Cloud = unplayable |
| IoT capteurs industrie | 500ms+ | 10-50ms | OK cloud mais edge meilleur |

**Tendances 2024-2026 :**
1. **5G + Edge** : Opérateurs télécom déploient edge aux antennes 5G
2. **Kubernetes Edge** : K3s, MicroK8s (Kubernetes léger < 100MB)
3. **TinyML** : Modèles IA compressés pour exécution locale
4. **Zero Trust Security** : Authentification distribuée + chiffrement local

**Implication :** Cloud computing de demain = cloud central + edge distribué.

---

### 6.2 FinOps (Financial Operations)

**Définition :** Pratique où **ingénieurs prennent responsabilité coûts** de leurs architectures cloud.

**Problème :** Élasticité cloud crée **risque financier énorme**.

**Exemple de "Bill Shock" :**
```
Oubli : Laisser instance large (16 vCPU) activée Friday 18h
Retour lundi 9h = 63 heures oubliées
Coût : 0,85€/h × 63h = 53€ (pas dramatique)

MAIS : Vrai danger
DDoS attaque ou requête boucle infinie
→ 1000 requêtes/s Lambda × 72h = 259 Milliards invocations
→ 259M × 0,20€/M = 51,800€ FACTURE UNE NUIT

Mitigation : Alerte budget CloudFormation
```

**Pratiques FinOps :**
- Tagging ressources (projet, équipe, environnement)
- Alertes budget (arrêter si >X€/jour)
- Reserved instances (50% réduction annuel si prévu)
- Spot instances (70% réduc si flexible timing)
- Right-sizing (utiliser type instance juste assez)

**Enjeu Culture :** Ingénieur responsable coûts = ingénieur mature.

---

### 6.3 Souveraineté Numérique

**Contexte :** Tensions géopolitiques + RGPD → données **doit résider juridiction spécifique**.

**Définition :** Cloud souverain = données restent sous **contrôle légal État/région**.

**Problème Résolu :**
- ❌ Avant : Données EU stockées AWS USA → CLOUD Act américain s'applique
- ✅ Maintenant : Cloud EU (France, Allemagne) → RGPD s'applique

**Fournisseurs Cloud Souverain :**
- **France** : OVH, Scaleway, Outscale (ex-Inovalis)
- **Allemagne** : Deutsche Telekom T-Systems
- **Europe** : Gaia-X initiative (fédération clouds européens)

**Conformité SecNumCloud (France) :**
- Données sensibles (santé, gouvernement) doivent être hébergées infrastructure approuvée
- Exemple : Hôpital français doit utiliser cloud HDS certifié

**Implication :** 2026, souveraineté = exigence contractuelle, pas optionnel.

---

### 6.4 Cloud Native et 12-Factor App

**Concept :** Applications **architecturées pour le cloud**, pas simplement "migré vers cloud".

**12-Factor App (Heroku methodology) :**

| Factor | Concept | Exemple |
|--------|---------|---------|
| **1. Codebase** | Un repository git = plusieurs déploiements | Même code, configs différentes per env |
| **2. Dependencies** | Déclarer explicitement dépendances | package.json, requirements.txt, Gemfile |
| **3. Config** | Stocker configuration en environnement | process.env.DB_URL, pas hardcodé |
| **4. Backing Services** | Traiter BD/cache comme ressources attachables | Changer DB dev ↔ prod = changement config |
| **5. Build/Run** | Strict séparation build et run | Docker : build une fois, run anywhere |
| **6. Processes** | Stateless processes | Pas fichier session disque local |
| **7. Port Binding** | Service exporte port HTTP | App listen port 8080, pas hardcoded |
| **8. Concurrency** | Process model horizontal scaling | 10 instances identiques, pas 1 monstre |
| **9. Disposability** | Fast startup/graceful shutdown | App démarre <5s, arrêt propre (10s timeout) |
| **10. Dev/Prod Parity** | Environnements identiques | Docker = même image dev et prod |
| **11. Logs** | Logs → stdout, pas fichiers | App envoie stdout, fournisseur récolte |
| **12. Admin Tasks** | Admin tasks = one-off process | Migrations DB = conteneur séparé, pas manual SSH |

**Implication :** Bien architecturé = application survit dans une réalité cloud (instances éphémères).

---

## CHAPITRE 7 : MATRICE DE SÉLECTION DÉCISIONNELLE

### 7.1 Les 6 Critères Majeurs

#### **1. Sensibilité des Données**

| Niveau | Type Données | Cloud Recommandé |
|--------|------------|------------------|
| **CRITIQUE** | Données santé, juridiques, gouvernement | Cloud privé ou EU souverain |
| **SENSIBLE** | Données client, transactions financières | Hybride (données privé, services public) |
| **PUBLIC** | Analytics, contenus marketing | Cloud public (AWS, Azure, GCP) |

---

#### **2. Budget Disponible**

| Budget | Horizon | Recommandation |
|--------|---------|-----------------|
| < 100k€ | Startup | Cloud public (AWS Free tier, GCP Always Free) |
| 100k - 500k€ | PME | Cloud public ou hybrid burst |
| 500k - 2M€ | ETI | Cloud hybride (base privé + burst public) |
| > 2M€ | Groupe | Cloud privé souverain + hybrid public |

---

#### **3. Volume de Données**

| Volume | Nature | Recommandation |
|--------|--------|-----------------|
| < 1TB | Petit projet | Cloud public (coûts négligeables) |
| 1-10TB | Applicatif normal | Cloud public ou privé (coûts modérés) |
| 10-100TB | BigData light | Hybride (données froides privé, chaudes public) |
| > 100TB | BigData heavy | Cloud privé (bande passante inter-cloud très coûteuse) |

**Important :** Transfert données cloud public = 0,09€/GB sortant. Transférer 1TB = 90€.

---

#### **4. Conformité/Réglementation**

| Secteur | Exigences | Solution |
|---------|-----------|----------|
| **Finance** | PCI-DSS, Bâle III, MiFID | Cloud privé sécurisé ou AWS/Azure certifié |
| **Santé** | HDS, RGPD, HIPAA | Cloud privé ou cloud public certifié HDS |
| **Public** | RGPD, Cloud Act | Cloud EU souverain obligatoire |
| **Pas règles** | Données publiques | Cloud public flexible |

---

#### **5. Latence Tolérable**

| Application | Latence Cible | Recommandation |
|------------|-------------|-----------------|
| Web statique | < 1000ms | Cloud public multiregion |
| APIs REST | < 100ms | Cloud public region proche |
| Temps réel (chat) | < 50ms | Cloud public + edge processing |
| Voiture autonome | < 10ms | Edge local obligatoire |
| Trading HFT | < 5ms | Datacenter privé on-site |

---

#### **6. Compétences IT Disponibles**

| Compétences | Équipe | Recommandation |
|------------|--------|-----------------|
| **Aucun DevOps** | 0 ingénieur cloud | SaaS uniquement (Salesforce, Microsoft 365) |
| **Débutants** | 1-2 DevOps juniors | Cloud public + PaaS (gestion fournisseur) |
| **Expérimentés** | 3-5 DevOps seniors | Cloud public IaaS + orchestration custom |
| **Experts** | 5+ team members | Cloud privé + hybrid (besoin IT interne élevé) |

---

### 7.2 Matrice Décisionnelle Complète

Pour choisir, cotez votre situation sur 6 critères, puis consultez la matrice :

```
Cotation : 1 (très faible) à 5 (très élevé)

□ Sensibilité données (1-5) : ___
□ Budget (1-5) : ___
□ Volume données (1-5) : ___
□ Exigence conformité (1-5) : ___
□ Latence critique (1-5) : ___
□ Compétences IT (1-5) : ___
```

**Décision :**

| Profil | Score Sensibilité+Conformité | Score Budget+Compétences | Recommandation |
|--------|---------------------------|----------------------|-----------------|
| Startup, données publiques | 1-3 | 5 (budget faible, DevOps expert) | **AWS Public** |
| PME classique | 3 | 3-4 | **Cloud Hybride Burst** |
| Banque, données critiques | 5 | 5 (budget ∞, équipe IT) | **Cloud Privé + Public EU** |
| Gouvernement | 5 | 4 | **Cloud Souverain EU** |
| Scale-up croissance rapide | 2-3 | 3 | **AWS/Azure Public** |

---

## CONCLUSION

Le cloud computing transforme infrastructure IT moderne, mais **aucune solution universelle** n'existe. Succès dépend :

1. ✅ **Comprendre les 5 caractéristiques NIST** = fondations solides
2. ✅ **Clarifier modèle déploiement** (public/privé/hybride)
3. ✅ **Sélectionner services** (IaaS/PaaS/SaaS/FaaS)
4. ✅ **Évaluer matrice décisionnelle** = choix justifié
5. ✅ **Adopter culture FinOps** = maîtriser coûts

**Prochain chapitre (Module 2) :** Approfondir AWS, Azure, GCP et cas d'usage spécialisés.

**Prochain TP :** Déployer application sur Cloud Run (PaaS serverless) = mettre en pratique concepts.

---

## GLOSSAIRE

**CAPEX :** Dépenses d'investissement (capital expenditure) — achat matériel long terme.

**OPEX :** Dépenses de fonctionnement (operational expenditure) — coûts courants, factures mensuelles.

**Hyperviseur :** Logiciel virtualisation (Xen, KVM, Hyper-V) = gère machines virtuelles.

**Vendor Lock-in :** Dépendance fournisseur, migration difficile vers concurrent.

**RTO (Recovery Time Objective) :** Temps max acceptable arrêt service après panne.

**RPO (Recovery Point Objective) :** Volume données max acceptable perdre après panne.

**Multi-tenancy :** Partage ressources plusieurs clients (sécurité par isolation, pas séparation physique).

**Serverless :** Fournisseur gère serveurs invisiblement, client paie invocations.

**Stateless :** Application sans état = redémarrage n'impacte pas fonctionnement (pas données session disque).

**TLS :** Transport Layer Security — chiffrement réseau (HTTPS).

---


# MODULE 2 : PANORAMA DES SOLUTIONS CLOUD

## Support de Cours Étudiant – Licence 3 BUT R&T
**Date :** Janvier 2026  

---

## INTRODUCTION : LA GUERRE DES CLOUDS (2026)

En 2026, le marché cloud atteint **750 milliards €** de revenus globaux. Les trois géants (AWS, Azure, GCP) contrôlent **63%** du marché, mais **aucun ne domine 100%**. Pourquoi ? Parce que chaque fournisseur excelle dans des domaines différents :
- **AWS** : Généraliste, 30% marché, complexité/maturité
- **Azure** : Intégration Microsoft, 20% marché, Fortune 500
- **GCP** : IA générative 2025, 13% marché, data/ML leaders

Parallèlement, une **révolution souveraine** émerge en Europe : les données critiques exigent des garanties légales (SecNumCloud, RGPD, Cloud Act). Les acteurs locaux (OVHcloud, Scaleway, Bleu, S3NS) offrent une alternative aux Big Three américains.

**Objectif du Module 2** : Justifier le choix d'une plateforme cloud pour une organisation réelle en comparant forces/faiblesses, coûts et impacts réglementaires.

---

## CHAPITRE 1 : LES "HYPERSCALERS" (PUBLIC CLOUD)

### 1.1 Amazon Web Services (AWS) – Le Pionnier

#### **Historique & Positionnement**
- **Créé** : 2006 (première plateforme cloud commerciale)
- **Leader** : 30% marché global (Q2 2025, Synergy Research)
- **Spécialité** : Généraliste, "+200 services", standard de facto

#### **Forces Principales**
1. **Maturité & Ecosystème** : 20 ans d'itération, écosystème partenaire massif
2. **Catalogue incomparable** : EC2, S3, Lambda, RDS, DynamoDB, SageMaker, etc.
3. **Régions géographiques** : 33 régions, 105 zones de disponibilité (couverture mondiale)
4. **Marché de talents** : Plus grande demande d'expertise AWS sur le marché

#### **Faiblesses**
1. **Courbe d'apprentissage** : Interface complexe, centaines de services crée confusion
2. **Facturation opaque** : "AWS Pricing Calculus" nécessaire pour éviter factures surprises
3. **Risque vendor lock-in** : Services propriétaires (DynamoDB, SageMaker) difficiles à migrer

#### **Services Phares**

| Service | Type | Use Case |
|---------|------|----------|
| **EC2** | Compute | VMs on-demand, auto-scaling |
| **S3** | Stockage | Object storage, backups, CDN |
| **Lambda** | Serverless | Fonctions sans serveur, automatisation |
| **RDS** | Database | Managed SQL (PostgreSQL, MySQL) |
| **DynamoDB** | Database | NoSQL scalable, latency < 1ms |
| **SageMaker** | ML | Notebooks, training, deployment ML |

#### **Modèle Tarifaire 2025**

**AWS Free Tier (Révolution Juillet 15, 2025)**
```
AVANT (Pré-juillet 2025)  : 12 mois gratuits + services à limits
APRÈS (Post-juillet 2025) : 
  • FREE PLAN      : $100 crédits + $100 onboarding = $200 total
  • Durée          : 6 mois OU jusqu'épuisement crédits
  • Aucun risque   : Pas de carte bancaire requise au-delà des $200
```

**Impact pédagogique** : Étudiants DOIVENT choisir FREE PLAN au signup (zéro risque facturation). Budget d'environ **$200 = ~100h de t2.micro**.

**Tarification à la demande (Pay-as-you-go)**
- t2.micro : $0.0116/h (~€8.50/mois)
- m5.large : $0.096/h (~€70/mois)
- c5.2xlarge : $0.34/h (~€250/mois)
- Stockage S3 : $0.023/Go/mois

---

### 1.2 Microsoft Azure – L'Intégrateur

#### **Historique & Positionnement**
- **Créé** : 2010 (après AWS, rattrapage progressif)
- **Leader** : 20% marché global (Q2 2025)
- **Force** : Intégration écosystème Microsoft, hybrid cloud

#### **Forces Principales**
1. **Intégration Microsoft** : Office 365, Active Directory, Copilot, Dynamics natifs
2. **Hybrid Cloud Leader** : **Azure Arc** permet gérer ressources on-prem et multi-cloud
3. **Marché Entreprise** : 85% Fortune 500 utilisent Azure
4. **OpenAI First** : Accès prioritaire OpenAI/Copilot

#### **Faiblesses**
1. **Portal complexe** : Interface parfois lente, nécessite appétit technologie
2. **Licensing labyrinthique** : "Software Assurance" confus pour PME
3. **Moins de services spécialisés** : Galaxie d'options, moins intuitif qu'AWS

#### **Services Phares**

| Service | Type | Équivalent AWS |
|---------|------|-----------------|
| **Virtual Machines** | Compute | EC2 |
| **App Services** | PaaS | Elastic Beanstalk |
| **Azure SQL Database** | Database Managed | RDS (SQL) |
| **Cosmos DB** | NoSQL Global | DynamoDB |
| **Azure Arc** | Hybrid Cloud | N/A (différenciant) |
| **Copilot Enterprise** | AI/Productivity | SageMaker |

#### **Concept Clé : Resource Groups & Azure Arc**

**Resource Groups** = conteneurs logiques regroupant ressources d'un projet.
```
Exemple :
  Resource Group "E-Commerce-Prod"
    - Virtual Network (VNet)
    - App Services (3 instances)
    - SQL Database
    - Storage Account
  → Permet facturation/permissions par projet
```

**Azure Arc** = gestion centralisée pour ressources partout (cloud + on-prem).
```
Cas d'usage :
  - Serveur on-prem managé via Azure portal
  - Policies applicables uniformément
  - Cost tracking global
  → Unique point Azure vs AWS (pas d'équivalent direct)
```

---

### 1.3 Google Cloud Platform (GCP) – Le Spécialiste IA/Data

#### **Historique & Positionnement**
- **Créé** : 2008 (interne avant commercial)
- **Leader** : 13% marché global (Q3 2025, croissance +25% YoY)
- **Spécialité** : Data Analytics, Machine Learning, IA générative

#### **Forces Principales**
1. **Réseau backbone Google** : Latence ultra-faible (11 ms global vs 50+ concurrents)
2. **Kubernetes natif (GKE)** : Créé par Google, support enterprise premium
3. **IA générative leader 2025** : Vertex AI + stack complet (Gemini, Veo, Imagen, Lyria)
4. **BigQuery dominant** : Data warehouse + analytics $6.25/To (vs redshift $5)

#### **Faiblesses**
1. **Portfolio fragmenté** : Produits lancés/abandonnés régulièrement (ex: Fabric, Cloud SQL)
2. **Moins de services "legacy"** : Startup-oriented, moins COBOL/SAP
3. **Interface ergonomie** : Console pas aussi intuitive qu'AWS

#### **Services Phares**

| Service | Type | Force |
|---------|------|-------|
| **Compute Engine** | VM | Performance réseau |
| **GKE** | Kubernetes | Support natif, auto-scaling |
| **BigQuery** | Data Warehouse | Requêtes <1s sur pétabytes |
| **Vertex AI** | ML/LLM | Leader IA générative |
| **Cloud Functions** | Serverless | Go/Python optimisé latence |
| **Firestore** | NoSQL | Real-time, multi-region |

#### **GCP Vertex AI & IA Générative Stack (2025)**

**Gemini 2.5 Flash**
- Modèle par défaut, multi-modal (texte, image, audio, video)
- Latency <100ms, contexte 1M tokens
- Réduction coûts : 2x moins cher que GPT-4o

**Generative Capabilities Complètes**
```
Texte    → Gemini 2.5 Flash / Pro (LLM généraliste)
Image    → Imagen 3 (text-to-image haute qualité)
Video    → Veo 2 (video generation/editing)
Audio    → Chirp 3 (speech synthesis + custom voice)
Musique  → Lyria (text-to-music, NOUVEAU 2025)
Sécurité → SynthID (watermarking anti-deepfakes)
```

**Tarification Vertex AI (2025)**
- Gemini 2.5 Flash : $0.075/M input tokens, $0.30/M output tokens
- Imagen 3 : $0.025/image
- Veo 2 : $0.06/second video
- BigQuery : $6.25/To analysed

---

## CHAPITRE 2 : L'ALTERNATIVE SOUVERAINE & EUROPÉENNE

### 2.1 Le Problème : Cloud Act & Souveraineté des Données

**Cloud Act (2018, USA)** : Les autorités américaines peuvent accéder à TOUTE donnée stockée sur serveurs US, peu importe la juridiction du client. Légalement, votre "secret bancaire" français peut être lû par le FBI.

**Conséquences pour l'Europe** :
- Organisations critiques (banques, santé, défense) : interdites AWS/Azure/GCP
- Données personnelles : RGPD impose "déterminisme juridique" (données UE = loi UE)
- Entreprises stratégiques : gouvernements encouragent "cloud souverain"

### 2.2 Les Champions Européens

#### **OVHcloud – Le Géant Français**

**Profil**
- Créé : 1999, headquartered Roubaix, France
- Marché : 4% cloud public Europe, leader France
- USP : Performance/prix Bare Metal, données 100% UE

**Forces**
- Pricing ultra-compétitif : Bare Metal 32 CPU/256GB RAM = €350/mois (vs AWS €2000+)
- Infrastructures France/Allemagne/Pologne : Aucune donnée US
- Support français : Pas de "attendre Slack"
- Offre souveraine certifiée SecNumCloud

**Faiblesses**
- Catalogue services : <100 services (vs AWS 200+)
- Talent pool : Moins d'expertise France (vs AWS international)
- Support : 24/7 bon, pas "white glove" Fortune 500

#### **Scaleway – Le Challenger Moderne**

**Profil**
- Créé : 2010, Paris
- Marque : Developer-friendly, pricing transparent
- Spécialité : ARM instances éco-responsables, DevOps tools

**Forces**
- UX/Documentation : Exceptionnelle pour startups
- Eco-instances ARM64 : 70% moins cher que x86, -30% CO2
- Transparent pricing : Aucune "surprise" facturation
- Datacenter Europe : Strasbourg, Paris, Amsterdam

**Faiblesses**
- Services moins complets : <80 services
- Pas de hybrid cloud tool (vs Azure Arc)
- Scaling global : Moins de régions (5 vs 33 AWS)

---

### 2.3 Le "Cloud de Confiance" (SecNumCloud 3.2)

**SecNumCloud** = Label ANSSI (Agence Nationale de la Sécurité Informatique) délivré aux fournisseurs offrant :
- Données hébergées UE (RGPD)
- Encryption "known plaintext impossible" (clés client-side)
- Audit régulier sécurité
- Conformité loi Française/OTAN

**Fournisseurs Certifiés SecNumCloud 2025** :

#### **S3NS (Thales Digital Security + Google)**
- Technologie : GCP Vertex AI + Infrastructure
- Opération : Thales (français)
- Certification : SecNumCloud 3.2
- Use case : Données très sensibles + besoin IA générative
- Pricing : +30% vs GCP public (~$9.75/To BigQuery vs $6.25)

#### **Bleu (Orange + Capgemini + Microsoft)**
- Technologie : Azure
- Opération : Orange (français, opérateur telco)
- Certification : SecNumCloud 3.2
- Use case : Données très sensibles + écosystème Microsoft
- Pricing : +25% vs Azure public

**Cas d'Utilisation SecNumCloud** :
- Ministères, Armée
- Données patients santé
- Données clients banques
- Infrastructure critique (eau, électricité)

**Important** : Les données quittent JAMAIS serveurs européens. Microsoft/Google ne peuvent pas accéder.

---

## CHAPITRE 3 : LE CLOUD PRIVÉ (ON-PREMISE)

Quand vous possédez le matériel mais voulez l'agilité "cloud-like".

### 3.1 OpenStack – L'Industriel

**Définition** : OS complet pour datacenter. Équivalent de "construire votre propre AWS".

#### **Architecture**
```
OpenStack Stack (Modular)
├─ Nova        : Compute (VMs)
├─ Neutron     : Networking (VPC-like)
├─ Cinder      : Block Storage
├─ Glance      : Image Repository
├─ Keystone    : Identity (AD-like)
├─ Horizon     : Web Dashboard
└─ Swift       : Object Storage (S3-like)
```

#### **Pour Qui ?**
- **Telcos** (Vodafone, Orange) : Infrastructure > 100 nœuds
- **Big Tech** (eBay, Airbnb) : Coûts opératoires > $1M/an
- **Super-computers** (CERN, NERSC) : Contrôle total infrastructure

#### **Avantages**
- Contrôle complet : Données on-prem, aucun vendor lock-in
- Coût scaling : Coût marginal très bas après CAPEX initial
- Customization : Intégration AD, LDAP, firewall propre

#### **Inconvénients (CRITIQUES)**
- Installation : 6-12 mois intégration complète
- Équipe IT : Minimum 5-10 FTE dedicées (full-time)
- Maintenance "Day 2" : Patches, upgrades, troubleshooting constant
- ROI : Break-even 5-7 ans minimum
- Risque : Si équipe parts, infrastructure peut devenir "dark matter"

#### **Coûts Réalistes OpenStack**

| Élément | Coût |
|---------|------|
| Hardware (20 nœuds, 10TB storage) | €250k |
| Installation & intégration (6 mois) | €300k |
| Équipe IT (5 FTE × €50k/an) | €250k/an |
| Maintenance/support (Canonical, etc.) | €50k/an |
| **5-ans TCO** | **€1.8M** |

---

### 3.2 Proxmox VE – L'Accessible

**Définition** : Solution de virtualisation open-source basée Debian. "OpenStack pour les PME".

#### **Architecture Simple**
```
Proxmox
├─ Hypervisor KVM (VMs - Linux/Windows)
├─ Container LXC (lightweight, fast)
└─ Web UI (intuitive, manageable)
```

#### **Pour Qui ?**
- **PME** (<50 serveurs) : Budget < €100k
- **Universités** : Labos pédagogiques, coût étudiant friendly
- **Startups** : Contrôle infra propre, coûts variables
- **Homelabs** : Enthousiastes infrastructure

#### **Avantages (RÉELS)**
- Installation : 15-20 min ISO boot, setup complet
- Complexité : Interface web intuitive, Python/Bash pour scripts
- Coût marginal : Juste électricité + renouvellement hardware (5-7 ans)
- Ecosystem : Documentation excelente, communauté active
- Flexibilité : VMs + Containers dans même cluster

#### **Inconvénients**
- Pas de "cloud-native" automatisé : Pas Kubernetes natif (ajout manuel)
- Support : Communauté (gratuit) vs Proxmox Inc (€€ premium)
- Scaling réseau : Management 1-2 admins OK; 10+ admins = croissance management
- Single pane glass : Dashboard moins centralisé que cloud public

#### **Coûts Réalistes Proxmox**

| Élément | Coût |
|---------|------|
| Hardware (2 nœuds × €8k) | €16k |
| Installation & setup (1 week) | €3k |
| Équipe IT (0.5 FTE × €50k/an) | €25k/an |
| Maintenance (domaines, updates) | €5k/an |
| **5-ans TCO** | **€155k** |

**Break-even vs AWS** : 155k / (€60/mois AWS × 12) = ~22 mois. **Après 2 ans, Proxmox meilleur choix pour charges stables.**

---

### 3.3 Apache CloudStack

**Définition** : Alternative à OpenStack, "plus simple mais moins puissante".

**Positionnement**
- Cas d'usage : **Hébergeurs de taille moyenne** vendant VPS aux clients
- Complexité : Monolithique, moins flexible qu'OpenStack mais déploiement plus rapide
- Entreprises : Quelques MSPs françaises (rare)

**Comparaison OpenStack vs CloudStack vs Proxmox**

| Critère | OpenStack | CloudStack | Proxmox |
|---------|-----------|-----------|---------|
| Taille min cluster | 10+ nœuds | 3+ nœuds | 1 nœud |
| Complexité install | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐ |
| Services offerts | 10+ | 5 | 2 |
| Équipe IT requise | 5-10 FTE | 2-3 FTE | 0.5 FTE |
| Break-even | 5-7 ans | 2-3 ans | 1-2 ans |
| Community | Massive | Petite | Très active |
| Ídeal pour | Telcos | MSPs | PMEs |

---

## CHAPITRE 4 : MATRICE DE DÉCISION & CAS D'USAGE

### 4.1 Méthode C.L.O.U.D. (Decision Framework)

Quand vous devez choisir plateforme cloud, posez-vous :

**C – Coût (TCO 5 ans)**
- Cloud Public = OPEX (€/mois variable)
- Cloud Privé = CAPEX (investissement up-front) + OPEX (exploitation)
- Calcul : (€/mois × 12 × 5 ans) + migration costs
- Decision : Si scaling <2x = privé meilleur; >5x = public meilleur

**L – Légal (Conformité & Données Sensibles)**
- Données non-sensibles (marketing, analytics) → AWS/Azure/GCP OK
- Données sensibles (health, banking, PII) → Souverain ou Privé OBLIGATOIRE
- Compliance critère : RGPD, SecNumCloud, Cloud Act
- Decision : Si santé/défense/banque → Souverain (S3NS/Bleu) ou Privé

**O – Ops (Compétences IT)**
- Cloud Public = Faible management, AWS/Azure/GCP gère infrastructure
- Proxmox = 0.5 FTE admin, apprentissage 2-3 mois
- OpenStack = 5-10 FTE, apprentissage 6-12 mois
- Decision : Si <5 ingé → cloud public; 5-10 → Proxmox; >20 → OpenStack

**U – Usage (Patterns Utilisation)**
- Scalabilité extrême (1→1000 serveurs en 1h) → AWS/Azure/GCP MUST
- Charge stable (steady-state) → Proxmox optimal
- Bursts temporaires (peaks) → Hybrid (Proxmox base + cloud burst)
- Decision : Analyser courbes charge historiques

**D – Data Gravity (Coût Migration)**
- Données actuelles on-prem → cloud migration expensive (€/To transit)
- Données déjà cloud → multi-cloud feasible
- Calcul : (Data size × $/To) + retraining engineers
- Decision : Si données énormes on-prem → Proxmox/OpenStack; sinon flexibility

### 4.2 Cas d'Usage Réels (Profils Entreprise)

#### **Cas 1 : Startup SaaS (FastFood-AI)**

**Profil**
- Secteur : Application web IA (recommandations menu restaurants)
- Données : Non-sensibles (business metrics, usage logs)
- Scaling : Prévu 1000% an 1, "unicorn track"
- Budget : €50k infrastructure an1
- Équipe IT : 1 DevOps freelance

**Recommandation : AWS Public Cloud**

**Justification**
- **Usage** : Scaling extrême → AWS/Azure/GCP nécessaire
- **Coût** : OPEX variable aligne burn rate startup
- **Ops** : 1 DevOps suffit (AWS géra scaling)
- **Data** : Aucun problème données sensibles
- **C.L.O.U.D. Score** : C(OPEX bon), L(pas critique), O(expert unique), U(scaling fou), D(nulle)

**Architecture Recommandée**
```
AWS Region us-east-1
├─ Application : ECS on Fargate (containers auto-scaled)
├─ Database : RDS PostgreSQL (managed, backups auto)
├─ Cache : ElastiCache Redis (session, analytics)
├─ AI Model : SageMaker Endpoints (real-time inference)
└─ Analytics : S3 + Athena (data lake)
```

**Budget an 1** : €12k/mois (€500 app + €200 DB + €300 storage + €100 other)

---

#### **Cas 2 : Grande Banque (Crédit Français)**

**Profil**
- Secteur : Données clients ultra-sensibles (accounts, transactions, ID)
- Données : Critiques RGPD/DORA (Digital Operational Resilience Act)
- Scaling : Stable (transactions ≈ constant)
- Budget : Illimité pour conformité
- Équipe IT : 50+ ingés infrastructure
- Régulation : Banque Centrale Française (ACP), CSSF Luxembours

**Recommandation : Cloud de Confiance (Bleu/S3NS) + OpenStack On-Prem**

**Justification**
- **Légal** : Données clients NE QUITTENT JAMAIS France (SecNumCloud obligatoire)
- **Ops** : 50 ingés → OpenStack déploiement réaliste
- **Usage** : Charge stable → Privé optimisé coût long-terme
- **Data** : Données énormes (PB scale) → migrations coûteuses
- **C.L.O.U.D. Score** : C(CAPEX énorme justifié), L(LÉGAL = MUST), O(équipes énormes), U(stable), D(données énormes)

**Architecture Recommandée**
```
Bleu (SecNumCloud)
├─ Production workloads sensibles (compliance-critical)
├─ Hébergement : Paris, audit ANSSI

OpenStack On-Prem (Paris + Lyon)
├─ Développement/tests
├─ Données "moins sensibles" (marketing, analytics)
├─ Disaster recovery cluster (asynchrone)

Interconnect : MPLS sécurisé France
```

**Budget an 1** : €5M (CAPEX amortissable + €500k OPEX)

---

#### **Cas 3 : PME Télécom (Startup ISP)**

**Profil**
- Secteur : Infrastructure réseau (vpn, firewall as-a-service)
- Données : Données clients sensibles (logs, configurations)
- Scaling : Croissance 30% an (modérée)
- Budget : €200k infrastructure an1
- Équipe IT : 3 ingés (DevOps/Infra/Network)
- Compliance : RGPD, données UE

**Recommandation : Hybrid (Proxmox On-Prem + Scaleway Cloud)**

**Justification**
- **Coût** : Proxmox base stable (€3k setup) + Scaleway burst scaling flexible
- **Legal** : Données clients France (Proxmox) + éventuels backups Scaleway EU
- **Ops** : 3 ingés gèrent Proxmox facilement + Scaleway documentation excellent
- **Usage** : Charge base steady (Proxmox) + peaks saisonnières (Scaleway)
- **Data** : Données sensibles on-prem (Proxmox), backups cloud (Scaleway)
- **C.L.O.U.D. Score** : C(Hybrid=optimal), L(RGPD ok), O(équipe petite), U(burst), D(medium)

**Architecture Recommandée**
```
Proxmox Cluster (2 nœuds, Paris datacenter)
├─ Production VPN/Firewall (steady load)
├─ Database PostgreSQL principal
└─ Monitoring/Logging local

Scaleway (Backup + Burst)
├─ Hot standby VPN secondaire (basculement auto)
├─ Object storage (S3 API) pour logs archivés
└─ Kubernetes cluster (GKE-like) pour nouveaux projets

Synchronization : Rsync + Ansible (hourly)
```

**Budget an 1** : €150k (Proxmox hardware €80k + Scaleway €700/mois + 1 FTE extra)

---

#### **Cas 4 : Université Française (Labos Recherche)**

**Profil**
- Secteur : Recherche académique (simulations physique, genomique)
- Données : Données publiques (publications, datasets académiques)
- Scaling : Très variable (bursts calculs ~100 CPU, puis quiescent)
- Budget : €30k/an infrastructure
- Équipe IT : 1 admin temps partiel
- Compliance : Aucune réglementation sensible

**Recommandation : Proxmox Community + GCP BigQuery (Spot Pricing)**

**Justification**
- **Coût** : Proxmox ultra low-cost, GCP Spot ML cheap pour calculs
- **Ops** : 1 admin gère Proxmox; chercheurs utilisent GCP console
- **Usage** : Bursts calculs intensifs → GCP TPU/GPU spot pricing (-80% vs on-demand)
- **Legal** : Aucune restriction données publiques
- **Data** : Peu données persistantes (résultats publiés)
- **C.L.O.U.D. Score** : C(très bas), L(n/a), O(equipe minuscule), U(burst), D(nul)

**Architecture Recommandée**
```
Proxmox Cluster (Université, 2 nœuds)
├─ VMs chercheurs (accès via SSH)
├─ Logiciels open-source (GROMACS, BLAST, etc.)
└─ Données inputs/outputs stockage local

GCP Vertex AI (Spot Instances)
├─ ML training (GPUs T4/V100 spot : €0.14/h vs €0.35 on-demand)
├─ BigQuery (analytics)
└─ Cloud Storage (données partagées avec Google)

Integration : gsutil sync (chercheurs téléchargent résultats)
```

**Budget an 1** : €35k (Proxmox hardware €20k amortissable, GCP €500/mois)

---

### 4.3 Matrice Synthétique de Décision

```
                    │ Non-sensible │ Sensible RGPD      │ Ultra-critique │
                    │   Scalable   │   Scalable         │      Stable    │
────────────────────┼──────────────┼────────────────────┼────────────────┤
Small Budget        │ AWS Free     │ Scaleway           │ Proxmox        │
(<€50k/an)          │ GCP Free     │ (startup-friendly) │ (homelab)      │
────────────────────┼──────────────┼────────────────────┼────────────────┤
Medium Budget       │ AWS Standard │ OVHcloud           │ Proxmox        │
(€50k–500k/an)      │ Azure/GCP    │ Scaleway           │ Hybrid Proxmox │
────────────────────┼──────────────┼────────────────────┼────────────────┤
Large Budget        │ AWS/Azure    │ Bleu/S3NS          │ OpenStack      │
(>€500k/an)         │ Multi-region │ (compliance)       │ On-Prem        │
────────────────────┼──────────────┼────────────────────┼────────────────┤
```

---

## GLOSSAIRE

| Terme | Définition |
|-------|-----------|
| **CAPEX** | Capital Expenditure : investissement infrastructure (hardware) |
| **OPEX** | Operating Expenditure : coûts exploitation récurrents (€/mois) |
| **TCO** | Total Cost of Ownership : coût global 5 ans (CAPEX + OPEX) |
| **SLA** | Service Level Agreement : garantie uptime (ex: 99.99%) |
| **Vendor Lock-in** | Dépendance fournisseur rendant migration difficile/coûteuse |
| **Hybrid Cloud** | Combination cloud public + infrastructure on-prem |
| **SecNumCloud** | Label ANSSI "cloud de confiance" France (données sensibles) |
| **RGPD** | Regulation Générale Protection Données (UE) |
| **Cloud Act** | Loi US permettant autorités accéder données US servers |
| **IaaS** | Infrastructure as a Service (VMs, storage) |
| **PaaS** | Platform as a Service (App services, databases managées) |
| **SaaS** | Software as a Service (Salesforce, Office 365) |

---

## RESSOURCES & LIENS

**Cloud Publics Officiels**
- AWS : https://aws.amazon.com/fr/
- Azure : https://azure.microsoft.com/fr-fr/
- GCP : https://cloud.google.com/

**Acteurs Souverains**
- OVHcloud : https://www.ovhcloud.com/fr/
- Scaleway : https://www.scaleway.com/fr/
- Bleu (Cloud de Confiance) : https://www.bleu.fr/
- S3NS (Cloud de Confiance) : https://www.s3ns.eu/

**Open Source**
- Proxmox : https://pve.proxmox.com/wiki/
- OpenStack : https://www.openstack.org/

**Calculateurs Coûts**
- AWS Pricing Calculator : https://calculator.aws/
- Azure Pricing Calculator : https://azure.microsoft.com/fr-fr/pricing/calculator/
- GCP Pricing Calculator : https://cloud.google.com/products/calculator

**Tutoriels & Documentation**
- FreeCodeCamp AWS : https://www.youtube.com/freecodecamp (AWS course)
- Udemy Azure fundamentals : AZ-900 preparation
- Proxmox tutorials : https://pve.proxmox.com/wiki/Main_Page

---

## POINTS CLÉS À RETENIR

✅ **Les 3 Hyperscalers** :
- AWS = Généraliste dominant (30% marché), complexité haute
- Azure = Intégrateur Microsoft (20%), hybrid cloud champion
- GCP = Spécialiste IA 2025 (13%), data analytics superior

✅ **Souveraineté 2026** :
- Cloud Act = autorités US peuvent accéder données US servers
- SecNumCloud = label ANSSI pour données critiques France
- Bleu & S3NS = offres "cloud de confiance" opérées France

✅ **Open Source** :
- OpenStack = mastodonte puissant, 5-7 ans ROI, 10+ FTE
- Proxmox = sweet spot PME/labos, 1-2 ans ROI, 0.5 FTE ⭐
- CloudStack = niche MSP, rarement vu France

✅ **Formules Calcul** :
```
TCO 5 ans = (€/mois × 12 × 5) + migration + équipe
Break-even Proxmox = CAPEX / (cloud €/mois × 12)
Exemple : €120k ÷ (€600/mois × 12) = ~17 mois
```

✅ **Après ce module, vous devez** :
1. Justifier choix cloud pour organisation réelle
2. Estimer coûts 5 ans (CAPEX vs OPEX)
3. Identifier critères légaux (RGPD, SecNumCloud)
4. Comparer forces/faiblesses AWS/Azure/GCP
5. Décider public vs privé vs hybrid basé data gravity

---

## PROCHAINE ÉTAPE

**Module 3 : Architecture Cloud & Infrastructure as Code**
- Deep dive VPC (Virtual Private Cloud)
- Terraform & Ansible (automatisation)
- Haute Disponibilité & Disaster Recovery
- Kubernetes introduction
- Cost optimization

# SUPPORT DE TRAVAUX PRATIQUES (TP2)

**Durée :** 2 heures  
**Scénario :** "Duel d'Architectes"

---

## INTRODUCTION

Vous êtes **consultant junior en architecture cloud**. Un client hésite entre :
- **Option 1** : Déployer infrastructure chez Google Cloud (public cloud)
- **Option 2** : Monter serveur Proxmox on-prem (private cloud)

**Mission** : Prototyper LES DEUX en parallèle et rédiger rapport de comparaison.

**Objectif pédagogique** : 
- Expérimenter déploiement cloud public (AWS/GCP)
- Déployer infrastructure on-prem (Proxmox/VirtualBox)
- Comparer temps, coût, complexité, contrôle
- Rédiger justification architecturale

---

## TP2.1 : CLOUD PUBLIC (AWS/GCP)

### **Durée** : 1 heure
### **Pré-requis**
- Compte Google Cloud / AWS (FREE TIER)
- Terminal SSH client (PuTTY Windows / Terminal macOS-Linux)
- Navigateur web moderne
- Pair(e) pour travail 2 personnes recommandé

### **Scénario**
Vous devez déployer **serveur web Apache avec une page HTML** pour startup "FastFood-AI" (recommandations IA pour menus restaurants).

---

### **ÉTAPE 1 : Création Compte Cloud & Activation Free Tier**

#### **Option A : Google Cloud Platform**

**A.1 : Signup GCP**
1. Aller https://cloud.google.com/
2. Cliquer "Try for free" (coin haut-droit)
3. Remplir formulaire Google Account (ou créer nouveau)
   - Email étudiant (université) recommandé
   - Vérification par SMS/appel (Google sécurité)
4. Saisir carte bancaire (charge €0, jamais débité sans accord)
5. Approuver conditions : "$300 crédits gratuit, 12 mois"
6. Vous êtes maintenant sur **GCP Free Tier** ✓

**A.2 : Vérifier Quota Free Tier**
```
GCP Console → Billing → Budget
→ Vérifier $300 crédits visibles
→ Vérifier "Free Tier" reste 11 mois 20 jours
```

#### **Option B : Amazon AWS (Alternative)**

**B.1 : Signup AWS**
1. Aller https://aws.amazon.com/fr/
2. Cliquer "Créer un compte AWS"
3. Remplir formulaire standard + adresse France
4. **IMPORTANT (Juillet 2025+)** : Choisir **FREE PLAN** à signup
   ```
   Ancienne offre (obsolète) : 12 mois gratuits
   Nouvelle offre (juillet 2025+) : $200 crédits, 6 mois max
   → Choisir FREE PLAN = 0 risque facturation
   ```
5. Vérifier email confirmation
6. Vous êtes maintenant sur **AWS Free Tier** ✓

**B.2 : Vérifier Quota Free Tier**
```
AWS Console → Billing → Cost Management
→ Vérifier $200 crédits visibles
→ Vérifier "Free Plan" expire dans ~6 mois
```

---

### **ÉTAPE 2 : Lancer Instance Compute (Serveur Virtual Machine)**

#### **Option A : Google Cloud Compute Engine**

**A.1 : Naviguer Compute Engine**
```
GCP Console → menu hamburger (haut-gauche)
→ Compute Engine
→ Instances VM
```

**A.2 : Créer Instance**
1. Cliquer "Create Instance"
2. Remplir formulaire :
   ```
   Name                : webapp-fastfood-01
   Region              : europe-west1 (Belgique, proche France)
   Zone                : europe-west1-b
   Machine Type        : e2-micro (1 vCPU, 1GB RAM) ← FREE TIER
   Operating System    : Debian 12
   Firewall Rules      : ✅ Allow HTTP
                         ✅ Allow HTTPS
   ```
3. Cliquer "Create" (attendre 30-60 secondes)
4. Instance lancée ✓

**A.3 : Se Connecter SSH**
1. Dans liste instances, cliquer instance "webapp-fastfood-01"
2. Cliquer "SSH" (fenêtre terminal web s'ouvre)
3. Vérifier prompt `username@hostname:~$`

#### **Option B : Amazon AWS EC2**

**B.1 : Naviguer EC2**
```
AWS Console → Services → EC2
→ Instances (menu gauche)
```

**B.2 : Créer Instance**
1. Cliquer "Launch Instance"
2. Remplir AMI & Config :
   ```
   Name                : webapp-fastfood-01
   AMI                 : Ubuntu 22.04 LTS (Free Tier eligible)
   Instance Type       : t2.micro ← FREE TIER
   Region              : eu-west-1 (Irlande, proche France)
   Network             : Default VPC
   Security Group      : Create new
     - Allow SSH (port 22)
     - Allow HTTP (port 80)
   Key Pair            : Create "fastfood-key" (sauvegarder .pem)
   ```
3. Cliquer "Launch Instance"
4. Attendre status "running" (2-3 min)
5. Instance lancée ✓

**B.3 : Se Connecter SSH**
```bash
# Télécharger clé fastfood-key.pem
# Changer permissions (Linux/Mac) :
chmod 400 ~/Downloads/fastfood-key.pem

# Récupérer IP public instance (AWS Console)
# Ex : 52.18.123.45

# Se connecter :
ssh -i ~/Downloads/fastfood-key.pem ubuntu@52.18.123.45
```

---

### **ÉTAPE 3 : Installer Apache & Déployer Application**

#### **Méthode A : Installation Manuelle (pas Recommendé)**

**A.1 : Mettre à jour OS**
```bash
$ sudo apt update
$ sudo apt upgrade -y
```

**A.2 : Installer Apache**
```bash
$ sudo apt install -y apache2
$ sudo systemctl start apache2
$ sudo systemctl enable apache2  # Démarrage auto

# Vérifier status :
$ sudo systemctl status apache2
# Output : active (running) ✓
```

**A.3 : Créer Page HTML Personnalisée**
```bash
# Créer fichier HTML :
$ sudo nano /var/www/html/index.html
```

Copier-coller contenu HTML :
```html
<!DOCTYPE html>
<html>
<head>
    <title>FastFood-AI | Menu Recommendations</title>
    <style>
        body { font-family: Arial; margin: 40px; background: #f0f0f0; }
        .header { background: #ff6b6b; color: white; padding: 20px; border-radius: 5px; }
        .content { background: white; padding: 20px; margin-top: 20px; }
        .footer { text-align: center; color: #666; margin-top: 30px; font-size: 12px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🍔 FastFood-AI</h1>
        <p>Recommandations Intelligentes de Menu</p>
    </div>
    <div class="content">
        <h2>Bienvenue!</h2>
        <p>Cette application utilise l'IA pour recommander menus personnalisés.</p>
        <p><strong>Status :</strong> ✅ Serveur en ligne</p>
        <p><strong>Date :</strong> <script>document.write(new Date().toLocaleString('fr-FR'));</script></p>
    </div>
    <div class="footer">
        <p>Déployé sur Cloud Public (Google/AWS) - 2026</p>
    </div>
</body>
</html>
```

**A.4 : Valider Apache Fonctionne**
```bash
# Obtenir IP publique instance (depuis GCP/AWS Console)
# Ouvrir navigateur : http://[IP_PUBLIQUE]
# Vérifier page HTML affichée ✓
```

#### **Méthode B : Automatisation User Data (Recommandé)**

**B.1 : Créer Script de Démarrage**

Créer fichier `startup.sh` sur ordinateur local :
```bash
#!/bin/bash
# Mise à jour OS
apt update && apt upgrade -y

# Installer Apache
apt install -y apache2

# Démarrer Apache
systemctl start apache2
systemctl enable apache2

# Créer page HTML
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>FastFood-AI | Menu Recommendations</title>
    <style>
        body { font-family: Arial; margin: 40px; background: #f0f0f0; }
        .header { background: #ff6b6b; color: white; padding: 20px; }
        .content { background: white; padding: 20px; margin-top: 20px; }
        .footer { text-align: center; color: #666; margin-top: 30px; }
    </style>
</head>
<body>
    <div class="header"><h1>🍔 FastFood-AI</h1></div>
    <div class="content">
        <h2>✅ Serveur en ligne</h2>
        <p>Page servie automatiquement via User Data!</p>
    </div>
</body>
</html>
EOF
```

**B.2 : Utiliser User Data GCP**
1. Lors création instance "webapp-fastfood-01"
2. Dérouler "Advanced options"
3. Dans "Metadata" → ajouter clé "startup-script"
4. Coller contenu startup.sh
5. Créer instance
6. Apache démarre automatiquement! ✓

**B.3 : Utiliser User Data AWS**
1. Lors "Launch Instance" step 3 (Advanced Details)
2. Déplier "User data"
3. Coller contenu startup.sh (sans `#!/bin/bash`)
4. Lancer instance
5. Apache démarre automatiquement! ✓

---

### **ÉTAPE 4 : Tests & Validation Web**

**T.1 : Accéder Serveur Web**
```
Ouvrir navigateur : http://[IP_PUBLIQUE_INSTANCE]
Vérifier page HTML FastFood-AI s'affiche ✓
```

**T.2 : Tester Latence**
```bash
# Depuis terminal local :
$ curl -w "Temps réponse : %{time_total}s\n" http://[IP_PUBLIQUE]
# Output attendu : < 200ms (latence UE)
```

**T.3 : Vérifier Apache Logs**
```bash
# Depuis SSH instance :
$ sudo tail -20 /var/log/apache2/access.log
# Vérifier requête HTTP visible
```

---

### **ÉTAPE 5 : Gestion Ressources & Cleanup**

#### **CRITÈRE IMPORTANT : Éviter Facturation**

**Étape Obligatoire : Arrêter Instance**
```
GCP Console → Instances → webapp-fastfood-01
→ Arrêter (STOP button, pas DELETE)

AWS Console → Instances → webapp-fastfood-01
→ Instance State → Stop instance
```

**Vérifier Quota Restant**
```
GCP Billing → Budget → Vérifier $300 crédits - cout instance
AWS Billing → Cost Management → Vérifier $200 crédits
```

**Estimation Coût Horaire** :
```
GCP e2-micro  : $0.033/h = environ $0.03 × 1h = €0.03
AWS t2.micro  : $0.0116/h = environ €0.01 × 1h = €0.01

Ne pas oublier arrêter instance!
```

---

### **ÉTAPE 6 : Rapport TP2.1**

**Rédiger rapport (1-2 pages)**

**Section 1 : Setup & Prérequis (5 min)**
- Cloud utilisé (GCP / AWS)
- Région deployée
- Machine type
- Coûts Free Tier restants

**Section 2 : Installation & Déploiement (10 min)**
- Temps installation Apache (du clic "create" à page web visible)
- Problèmes rencontrés & solutions
- Étapes automatisation (User Data) vs manual
- Impact productivité automatisation

**Section 3 : Observations (10 min)**
- Latence mesurée page load (curl timing)
- Facilité dashboard cloud
- Gestion sécurité (firewall, clés SSH)
- Éléments positifs/négatifs

**Section 4 : Considérations Coûts (5 min)**
- Coût horaire machine utilisée
- Coût stockage données
- Coût transfert données (si applicable)
- Estimation coût 1 mois service steady-state

**Notation** : /10 points
- Setup correct ✓ : /3
- Rapport détaillé ✓ : /4
- Observations pertinentes ✓ : /3

---

## TP2.2 : CLOUD PRIVÉ (PROXMOX/VIRTUALBOX)

### **Durée** : 1 heure
### **Pré-requis**
- Ordinateur avec VirtualBox ou Proxmox installé
- 8GB RAM libre minimum
- ISO Debian 12 (~600MB)
- Accès réseau (téléchargement ISO)

### **Scénario**
Déployer **même serveur web Apache** mais sur infrastructure privée (Proxmox/VirtualBox), comparer expérience vs Cloud Public.

---

### **OPTION A : Proxmox VE (Infrastructure Dédiée)**

#### **Étape 1 : Accès Console Proxmox**

**A.1 : Localiser Proxmox**
- Si Proxmox hébergé sur serveur labo (cas université)
- Accéder via navigateur : `https://[IP_PROXMOX]:8006`
- Login : root / password fourni par admin

**A.2 : Interface Proxmox**
```
Haut gauche  : Sélection node (serveur physique)
Gauche panel : Resources (VMs, Containers, Storage)
Centre       : VM/Container details
Droite       : Console (terminal virtual)
```

#### **Étape 2 : Créer VM**

**A.2.1 : Créer VM Vide**
1. Haut-droit : "Create VM"
2. Formulaire :
   ```
   Node             : proxmox-node-01 (sélectionner)
   Name             : fastfood-webapp
   VMID             : 100 (auto-proposé)
   OS Type          : Linux
   System           : UEFI (moderne)
   Disk             : 20GB (suffisant pour Debian + Apache)
   RAM              : 2GB (minimum)
   Cores            : 2 vCPU
   Network          : Automatic (bridge vmbr0)
   ```
3. Cliquer "Finish"
4. VM créée (état "stopped") ✓

**A.2.2 : Attacher ISO Debian**
1. Sélectionner VM "fastfood-webapp"
2. Hardware → CD/DVD Drive
3. Cliquer "Edit" → sélectionner ISO Debian 12
4. VM maintenant peut booter ISO

#### **Étape 3 : Installer Debian**

**A.3.1 : Boot sur ISO**
1. Sélectionner VM "fastfood-webapp"
2. Cliquer "Console" (haut-droit)
3. Cliquer "Start" (boot VM)
4. Installer Debian 12 standard (installation graphique ~15 min)
   ```
   Language        : Français (ou English si lisibilité préférée)
   Disque          : /dev/vda (seul disque)
   Hostname        : fastfood-webapp
   Domain          : local.lan
   Root password   : [créer mot-de-passe]
   User            : student
   User password   : [créer mot-de-passe]
   Mirror           : Oui (installation packages)
   GRUB bootloader : /dev/vda
   ```
5. Installation complète ~15 min, reboot auto

**A.3.2 : Post-Installation**
```bash
# Login shell (root) :
$ sudo apt update
$ sudo apt upgrade -y
$ sudo apt install -y openssh-server

# Démarrer SSH :
$ sudo systemctl start ssh
$ sudo systemctl enable ssh

# Récupérer IP VM :
$ ip addr show eth0
# Vérifier adresse IP (ex: 192.168.100.50)
```

#### **Étape 4 : Installer Apache (SSH)**

**A.4.1 : Connexion SSH depuis ordinateur local**
```bash
# Terminal local :
$ ssh student@192.168.100.50
# Enter password
$ whoami
# Output : student
```

**A.4.2 : Installer Apache**
```bash
$ sudo apt install -y apache2
$ sudo systemctl start apache2
$ sudo systemctl enable apache2

# Vérifier :
$ sudo systemctl status apache2
# Output : active (running) ✓
```

**A.4.3 : Déployer Page HTML**
```bash
$ sudo nano /var/www/html/index.html
```

Copier même HTML que TP2.1 (FastFood-AI page).

**A.4.4 : Tester Accès Web**
```bash
# Depuis ordinateur local :
# Ouvrir navigateur : http://192.168.100.50
# Vérifier page HTML affichée ✓
```

---

### **OPTION B : VirtualBox (Ordinateur Personnel)**

#### **Étape 1 : Créer VM VirtualBox**

**B.1.1 : Créer Machine Virtuelle**
1. VirtualBox → "New" (haut-gauche)
2. Formulaire :
   ```
   Name        : fastfood-webapp
   OS          : Linux / Debian 64-bit
   RAM         : 2048 MB
   Disk        : 20GB (VDI, dynamique)
   ```
3. Cliquer "Create"

**B.1.2 : Attacher ISO Debian**
1. Sélectionner VM "fastfood-webapp"
2. Settings → Storage
3. CD/DVD Drive → sélectionner ISO Debian 12
4. Cliquer "OK"

#### **Étape 2 : Installer Debian (Identique A.3)**

Suivre **A.3.1 : Boot sur ISO** → **A.3.2 : Post-Installation**

#### **Étape 3 : Installer Apache (Identique A.4)**

Suivre **A.4.1 → A.4.4**

---

### **ÉTAPE 5 : Comparaison Cloud vs Privé**

**Remplir Tableau Comparatif** :

| Critère                            | Cloud Public (GCP/AWS)  | Cloud Privé (Proxmox/VBox) | Gagnant |
| ---------------------------------- | ----------------------- | -------------------------- | ------- |
| **Temps déploiement**              | [temps en min]          | [temps en min]             | ?       |
| **Complexité**                     | [simple/moyen/complexe] | [simple/moyen/complexe]    | ?       |
| **Contrôle infrastructure**        | [oui/non]               | [oui/non]                  | ?       |
| **Scalabilité (ajouter serveurs)** | [rapide/lent]           | [rapide/lent]              | ?       |
| **Support/Documentation**          | [Google/AWS]            | [Proxmox Forum]            | ?       |
| **Coût setup initial**             | $200 crédits            | €50-100 hardware           | ?       |
| **Coût exploitation**              | €20-50/mois             | €5-10/mois électricité     | ?       |
| **Facilité networking**            | [facile/difficile]      | [facile/difficile]         | ?       |
| **Backup/Disaster Recovery**       | [automatique/manuel]    | [automatique/manuel]       | ?       |
| **Temps rendre live en prod**      | [heure/jour/semaine]    | [heure/jour/semaine]       | ?       |

**Instructions Remplissage** :
1. Chaque binôme remplit tableau
2. Justifier chaque réponse (1-2 lignes)
3. Identifier forces/faiblesses chaque approche

---

### **ÉTAPE 6 : Rapport TP2.2**

**Rédiger rapport (2-3 pages)**

**Section 1 : Infrastructure Setup (10 min)**
- Plateforme utilisée (Proxmox vs VirtualBox)
- Configuration hardware (RAM, CPU, disque)
- Système exploitation déployé

**Section 2 : Processus Installation (15 min)**
- Étapes chronologiques (création VM → Apache live)
- Temps total (en minutes)
- Difficultés rencontrées
- Comparaison vs Cloud Public (TP2.1)

**Section 3 : Résultats Performance (10 min)**
- Latence page load (curl timing)
- Stabilité Apache
- Utilisations ressources VM (htop)
- Observation interface Proxmox/VBox

**Section 4 : Analyse Comparaison (15 min)**
- Tableau comparatif complet
- Cas d'usage optimal Cloud Public vs Privé
- Recommandation architecture startup "FastFood-AI"
  - Justifier choix (coûts 5 ans, scaling)

**Notation** : /10 points
- Infrastructure running ✓ : /3
- Rapport complet ✓ : /4
- Analyse comparaison ✓ : /3

---

## ÉVALUATION GLOBALE TP2.1 + TP2.2

**Grille Évaluation Enseignant** (/20 points total)

| Aspect | Points | Commentaires |
|--------|--------|--------------|
| **TP2.1 Exécution (Cloud)** | /5 | Instance web live, rapport détaillé |
| **TP2.2 Exécution (Privé)** | /5 | Proxmox/VBox fonctionnel, rapport complet |
| **Tableau Comparatif** | /5 | Tous critères remplis, justifications valides |
| **Recommandation Architecture** | /5 | Décision justifiée (Cloud vs Privé), CAPEX/OPEX cohérents |
| **TOTAL** | **/20** | |


---

## RESSOURCES ÉTUDIANTS

**Google Cloud Platform**
- Accès Free Tier : https://cloud.google.com/
- Documentation GCP : https://cloud.google.com/docs
- Tutoriel SSH GCP : https://cloud.google.com/compute/docs/instances/connecting-to-instance

**Amazon AWS**
- Accès Free Tier : https://aws.amazon.com/fr/
- Documentation EC2 : https://docs.aws.amazon.com/ec2/
- AWS Free Tier Alertes : https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/free-tier.html

**Proxmox**
- Documentation : https://pve.proxmox.com/wiki/
- Forum Support : https://forum.proxmox.com/
- Tutoriels Français : Disponibles université (demander admin)

**VirtualBox**
- Téléchargement : https://www.virtualbox.org/
- Manuel Utilisateur : https://www.virtualbox.org/manual/

**Debian Linux**
- Télécharger ISO : https://www.debian.org/releases/
- Documentation Debian : https://wiki.debian.org/

---

## CONSEILS SUCCÈS

✅ **Pour TP2.1 (Cloud)**
- Sauvegarder clés SSH (AWS) dans endroit sûr
- Arrêter instance IMMÉDIATEMENT après TP (éviter charges)
- Tester User Data script en local avant (syntax errors)
- Utiliser FREE PLAN AWS (zéro risque facturation)

✅ **Pour TP2.2 (Privé)**
- Télécharger ISO Debian avant TP (internet labo parfois lent)
- Proxmox admin : obtenir access credentials 1 jour avant
- VirtualBox : vérifier 8GB RAM libre (installer autres apps)
- Prendre screenshot topologie finale (preuve fonctionnement)

✅ **Rapport Comparatif**
- Être objectif (pas "cloud toujours meilleur")
- Chaque cas d'usage a réponse différente
- Quantifier métriques (temps en minutes, coûts en euros)
- Justifier recommandation avec données TP

---

## FAQ TP2.1 & TP2.2

**Q: Compte Google/AWS prend combien de temps approuver?**  
A: 5-10 min en général (vérification SMS/appel).

**Q: Comment retrouver IP publique instance?**  
A: GCP Console → Instances → colonne "External IP"  
AWS Console → Instances → colonne "Public IPv4 address"

**Q: User Data script ne s'exécute pas?**  
A: Vérifier logs : `/var/log/cloud-init-output.log` (GCP)  
AWS : `/var/log/cloud-init.log` → debug erreurs script

**Q: Proxmox pas accessible, "connexion refusée"?**  
A: Vérifier adresse IP node (demander admin)  
Vérifier firewall permet port 8006
Vérifier credentials correct

**Q: Page Apache n'affiche rien (erreur 403)?**  
A: Vérifier permissions fichier HTML  
`sudo chmod 644 /var/www/html/index.html`

**Q: Combien coûte un jour de serveur cloud?**  
A: GCP e2-micro : $0.033/h = ~€0.70/jour  
AWS t2.micro : $0.0116/h = ~€0.25/jour  
(IMPORTANT : arrêter instance après TP!)

**Q: Peut-on redéployer plusieurs fois même instance?**  
A: OUI. GCP/AWS permettent création/suppression illimitée dans Free Tier.  
Proxmox: créer nouvelle VM (même VM multiple fois = mauvaise pratique)

---

## POINTS CLÉS À RETENIR (TP)

✅ **Déploiement Cloud Public** :
- Point-and-click interface, lancement ~1 min
- Coûts transparents, scaling illimité
- Support massive (milliers tutorials)
- Vendor lock-in potentiel (services propriétaires)

✅ **Déploiement Cloud Privé** :
- Installation ~30 min (Proxmox) vs ~15 min (VirtualBox)
- Contrôle total infrastructure, données on-prem
- Coûts CAPEX initial, puis OPEX faible
- Équipe IT requise pour maintenance

✅ **Aucun n'est "meilleur"** :
- Startup : Cloud Public (scaling crucial, équipe réduite)
- PME stable : Proxmox (contrôle, coûts prévisibles)
- Banque critique : Privé (SecNumCloud, sécurité absolue)
- Université labos : Proxmox (budget, apprentissage)

# MODULE 3 : INFRASTRUCTURE AS CODE (IaC)
## Support de Cours Étudiant – Licence 3 BUT R&T
**Date :** Janvier 2026     
**Prérequis :** Modules 1-2 validés, Linux Bash, YAML, concepts réseau

---

## TABLE DES MATIÈRES

1. [Introduction : La fin du "ClickOps"](#introduction)
2. [Chapitre 1 : Concepts Fondamentaux IaC](#chapitre-1)
3. [Chapitre 2 : Terraform – Provisionning Infrastructure](#chapitre-2)
4. [Chapitre 3 : Ansible – Configuration Post-Déploiement](#chapitre-3)
5. [Chapitre 4 : Architecture Cloud Réseau](#chapitre-4)
6. [Chapitre 5 : Haute Disponibilité & Résilience](#chapitre-5)
7. [Cas d'Étude : TechNova Phase 2](#cas-detude)
8. [Glossaire & Ressources](#glossaire)

---

## INTRODUCTION : La fin du "ClickOps" 

Jusqu'à présent, vous avez créé des serveurs manuellement via la console AWS/GCP. C'est amusant pour **un seul serveur**. C'est un cauchemar pour **50**. Et c'est **impossible** pour **1000**.

Imaginez que votre entreprise doit redéployer son infrastructure en 15 minutes après une catastrophe. Comment feriez-vous manuellement ? Clicks, clics, clics... Pendant ce temps, vos clients attendent. Pendant ce temps, vous perdez de l'argent.

**L'Infrastructure as Code (IaC)** est la réponse.

### Définition

L'Infrastructure as Code est la **pratique consistant à gérer l'infrastructure informatique via des fichiers de définition**, plutôt que par la configuration manuelle via une interface graphique (IaC vs ClickOps).

**Analogie du BTP :**
- **ClickOps** = Un artisan qui construit maison après maison, chaque fois différente, sans plan.
- **Infrastructure as Code** = Un ingénieur qui crée un plan (Terraform), puis une usine le reproduit à l'identique 1000 fois.

### Pourquoi coder son infrastructure ?

| Bénéfice              | Explication                                                                                             |
| --------------------- | ------------------------------------------------------------------------------------------------------- |
| **Reproductibilité**  | Je détruis mon environnement et le recréé à l'identique en UNE commande.                                |
| **Versionning (Git)** | Qui a ouvert le port 22 hier ? → `git blame` nous donne la réponse. L'infrastructure devient auditable. |
| **Vitesse**           | Déployer 100 serveurs en 5 minutes au lieu de 5 jours manuellement (gain de **240x**).                  |
| **Idempotence**       | Peu importe combien de fois j'exécute le code, le résultat est le même.                                 |
| **Disaster Recovery** | Tout a brûlé ? `terraform apply` et c'est reparti.                                                      |
| **Collaboration**     | Plusieurs ingénieurs travaillent sur la même infrastructure via Git.                                    |

---

## CHAPITRE 1 : Concepts Fondamentaux IaC

### 1.1 Le Match : Déclaratif vs Impératif

C'est la **distinction philosophique majeure** en IaC. Ces deux approches répondent au même problème : *Automatiser la gestion de l'infrastructure.* Mais elles le font différemment.

#### Approche IMPÉRATIVE

**Philosophie :** *"Fais ceci, puis fais cela."*

**Outil Type :** Bash, Ansible, Chef

**Analogie GPS  :** "Tourne à droite, puis fais 500m, puis tourne à gauche, puis 200m..."

**Exemple Code (Bash) :**
```bash
# Script impératif : étapes à suivre rigidement
aws ec2 create-vpc --cidr-block 10.0.0.0/16
aws ec2 create-subnet --vpc-id vpc-123 --cidr-block 10.0.1.0/24
aws ec2 create-internet-gateway
# ... et des dizaines d'autres commandes
```

**Problèmes :**
- Si une étape échoue à mi-chemin, l'état est incohérent.
- Relancer le script 2 fois peut créer 2 ressources au lieu de 1.
- Difficile à déboguer.

#### Approche DÉCLARATIVE

**Philosophie :** *"Je veux cet état final."*

**Outil Type :** Terraform, Kubernetes, CloudFormation

**Analogie Taxi :** "Emmène-moi à la Tour Eiffel." (Le chauffeur gère le trajet, les embouteillages, etc.)

**Exemple Code (Terraform) :**
```hcl
# Code déclaratif : état final désiré
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
# C'est tout. Terraform gère les dépendances et l'ordre.
```

**Avantages :**
- **Idempotent** : Lancer `terraform apply` 10 fois = même résultat final.
- **Dépendances automatiques** : Terraform sait que le subnet dépend du VPC.
- **Drift detection** : `terraform plan` détecte les changements non autorisés.

### 1.2 Idempotence : Le Concept Clé

**Définition mathématique :** f(f(x)) = f(x). Si j'applique une fonction deux fois, le résultat est le même.

**En Infrastructure :** 
- J'ai 2 serveurs.
- Mon code déclare "je veux 3 serveurs".
- Terraform en ajoute 1, pas 3.
- Je relance mon code : il vérifie qu'il y a 3 serveurs, ne crée rien.

**Comparaison :**
```bash
# ❌ NON idempotent (Bash impératif)
echo "Server" >> /etc/hosts
# Exécuter 2 fois = 2 entrées dans /etc/hosts

# ✅ Idempotent (Ansible avec Terraform)
resource "aws_instance" "web" {
  count = 3
}
# Exécuter 2 fois = toujours 3 instances
```

### 1.3 Configuration Drift (Dérive)

**Définition :** La "dérive de configuration" survient quand l'infrastructure réelle diverge du code.

**Scenario Courant :**
1. Je déploie 2 serveurs avec Terraform.
2. Un opérateur va à la console AWS et désactive le monitoring sur un serveur.
3. Mon code dit "2 serveurs avec monitoring" mais la réalité en a qu'1.
4. C'est la **dérive**.

**Solution :**
```bash
# Détecte les dérives
terraform plan
# Output : "Resource 'aws_instance.web[0]' has drifted. Monitoring is OFF in reality."
```

### 1.4 Le Duo Gagnant : Terraform + Ansible

**Terraform = Provisioning (Infrastructure)**
- Crée les ressources cloud : VPC, Serveurs, Load Balancers, Bases de données.
- **Déclaratif** : "Je veux cet état."
- Temps : quelques secondes à quelques minutes.

**Ansible = Configuration (Software)**
- Configure l'intérieur des serveurs : installe Nginx, déploie code, crée users.
- **Impératif** : "Fais ces étapes."
- Temps : quelques secondes à quelques minutes.

**Workflow Complet :**
```
Terraform           Ansible
   ↓                  ↓
Crée VPC        →  Installe Nginx
Crée Subnet     →  Configure Nginx
Crée EC2        →  Déploie App
Crée SG         →  Redémarre Services
   ↓                  ↓
Infrastructure      Configurable
(Murs/Toit)        (Meubles/Peinture)
```

---

## CHAPITRE 2 : Terraform – Provisionning Infrastructure

### 2.1 Qu'est-ce que Terraform ?

Terraform est un **outil open-source** créé par HashiCorp qui permet de :
1. **Coder** votre infrastructure en HCL (langage lisible).
2. **Planifier** les changements avant de les appliquer.
3. **Appliquer** les changements de façon idempotente.
4. **Détruire** complètement une infrastructure.

### 2.2 Le Langage HCL (HashiCorp Configuration Language)

HCL est conçu pour être lisible par les humains. Il s'articule autour de **blocs**.

#### Les 4 Blocs Essentiels

```hcl
# 1. TERRAFORM : Meta-configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. PROVIDER : Qui est le fournisseur cloud ?
provider "aws" {
  region = "eu-west-3"  # Paris
}

# 3. RESOURCE : Quoi créer ?
resource "aws_instance" "mon_serveur" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04
  instance_type = "t3.micro"               # Type & puissance
  
  tags = {
    Name = "Mon-Serveur-Web"
  }
}

# 4. OUTPUT : Quoi afficher après création ?
output "instance_ip" {
  value       = aws_instance.mon_serveur.public_ip
  description = "L'IP publique de mon serveur"
}
```

#### Syntaxe Clé

| Élément | Exemple | Explication |
|---------|---------|-------------|
| **String** | `"eu-west-3"` | Chaîne de texte entre guillemets |
| **Number** | `3`, `80` | Nombre entier |
| **Boolean** | `true`, `false` | Vrai/faux |
| **List** | `["a", "b", "c"]` | Liste ordonnée |
| **Map** | `{ key1 = "val1" }` | Dictionnaire clé-valeur |
| **Reference** | `aws_vpc.main.id` | Référencer une ressource |
| **Interpolation** | `"Hello ${var.name}"` | Injecter variables dans texte |

### 2.3 Variables : Rendre le Code Réutilisable

**Sans variables :**
```hcl
resource "aws_instance" "web" {
  instance_type = "t3.micro"  # Codé en dur
}
# Problème : pour changer de type, il faut éditer le code
```

**Avec variables :**
```hcl
# variables.tf
variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type instance EC2"
}

# main.tf
resource "aws_instance" "web" {
  instance_type = var.instance_type  # Référencé
}

# terraform.tfvars (surcharge)
instance_type = "t3.small"  # Nouveau type sans toucher au code
```

### 2.4 Le Workflow Terraform (4 étapes sacro-saintes)

Tout ingénieur Terraform répète ce mantra :

#### ÉTAPE 1 : `terraform init`

**But :** Initialiser le projet, télécharger les plugins.

```bash
$ terraform init
Initializing the backend...
Downloading plugin: hashicorp/aws v5.0
...
Terraform has been successfully configured!
```

**Fichiers créés :**
- `.terraform/` : Dossier plugins (ne pas commiter sur Git)
- `.terraform.lock.hcl` : Versions précises des providers (à commiter)

#### ÉTAPE 2 : `terraform plan`

**But :** Simuler les changements. C'est votre **filet de sécurité**.

```bash
$ terraform plan
Plan: 8 to add, 0 to change, 0 to destroy.
```

**Signification :**
- `8 to add` : 8 ressources seront créées (VPC, Subnet, IGW, SG, Clé SSH, 2 instances, Route Table, etc.)
- `0 to change` : Aucun changement sur des ressources existantes.
- `0 to destroy` : Rien ne sera supprimé.

**À faire TOUJOURS avant `apply` :** Lire le plan et vérifier que tout est correct.

#### ÉTAPE 3 : `terraform apply`

**But :** Exécuter le plan et créer les ressources.

```bash
$ terraform apply
Do you want to perform these actions? (yes/no)
yes

aws_vpc.main: Creating...
aws_vpc.main: Creation complete after 2s [id=vpc-0123456789]
aws_subnet.public: Creating...
aws_subnet.public: Creation complete after 1s [id=subnet-0123456789]
...
Apply complete! Resources: 8 added.
```

**Fichier créé :** `terraform.tfstate` (voir section suivante)

#### ÉTAPE 4 : `terraform destroy`

**But :** Supprimer **TOUTES** les ressources créées par Terraform.

```bash
$ terraform destroy
Destroy: 8 resources?
yes

aws_instance.web[0]: Destroying...
aws_instance.web[1]: Destroying...
...
Destroy complete! Resources: 8 destroyed.
```

⚠️ **CRITIQUE POUR LES COÛTS :** Ne pas oublier de détruire après les TPs. Sinon, les serveurs continuent à tourner et vous facturent AWS !

### 2.5 L'État Terraform (.tfstate) : Le Cerveau

**Définition :** Terraform crée un fichier `terraform.tfstate`. C'est un **dictionnaire JSON** qui lie votre code à la réalité AWS.

**Contenu Simplifié :**
```json
{
  "resources": [
    {
      "type": "aws_vpc",
      "name": "main",
      "instances": [
        {
          "attributes": {
            "id": "vpc-0123456789",
            "cidr_block": "10.0.0.0/16"
          }
        }
      ]
    }
  ]
}
```

**Terraform utilise .tfstate pour :**
1. Savoir quelles ressources il gère.
2. Détecter les dérives : "En réalité, ce VPC a changé."
3. Planifier les changements : "Pour passer de 2 à 3 serveurs, je dois ajouter 1 instance."

### 2.6 ⚠️ DANGER : Règles d'Or pour .tfstate

| Règle | Explication |
|-------|-------------|
| **Ne JAMAIS modifier manuellement** | Vous risquez de corrompre Terraform. Il ne saura plus ses ressources. |
| **Ne JAMAIS supprimer** | Terraform pense qu'il ne gère rien. Il tente de recréer les ressources. |
| **Ne JAMAIS commiter sur Git** | Si le fichier contient des secrets (clés d'accès), elles sont publiques. |
| **Utiliser un Remote State** | En production, stocker .tfstate sur S3 avec versioning + chiffrement. |

**Configuration Remote State (Production) :**
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
    dynamodb_table = "terraform-locks"  # Locking pour travail collaboratif
  }
}
```

### 2.7 Exemple Complet : Déployer un VPC + Subnet + IGW + EC2 + SG

**Fichier : main.tf**
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

# Variables
variable "instance_type" {
  default = "t3.micro"
}

variable "instance_count" {
  default = 2
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  
  tags = { Name = "vpc-devcloud" }
}

# Subnet Public
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  
  tags = { Name = "subnet-public" }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = { Name = "igw-main" }
}

# Route Table (connecte subnet au IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.main.id
  }
  
  tags = { Name = "rt-public" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group (Pare-feu)
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id
  
  # Entrant
  ingress {
    from_port   = 22   # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ À restreindre en prod
  }
  
  ingress {
    from_port   = 80   # HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Sortant (tout autorisé)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = { Name = "sg-web" }
}

# Clé SSH
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Votre clé publique locale
}

# Instances EC2
resource "aws_instance" "web" {
  count              = var.instance_count
  ami                = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04 (eu-west-3)
  instance_type      = var.instance_type
  key_name           = aws_key_pair.deployer.key_name
  subnet_id          = aws_subnet.public.id
  security_groups    = [aws_security_group.web.id]
  
  tags = { Name = "web-server-${count.index + 1}" }
}

# Outputs
output "vpc_id" {
  value = aws_vpc.main.id
}

output "instance_ips" {
  value = {
    for i, instance in aws_instance.web :
    instance.tags["Name"] => instance.public_ip
  }
}
```

**Exécution :**
```bash
terraform init
terraform validate
terraform plan
terraform apply
# Output : IPs publiques affichées
terraform output instance_ips
# Output :
# {
#   "web-server-1" = "3.121.45.67"
#   "web-server-2" = "3.121.45.68"
# }

# SSH vers un serveur
ssh -i ~/.ssh/id_rsa ubuntu@3.121.45.67

# Nettoyer
terraform destroy
```

---

## CHAPITRE 3 : Ansible – Configuration Post-Déploiement

### 3.1 Ansible vs Terraform

| Aspect | Terraform | Ansible |
|--------|-----------|---------|
| **Rôle** | Créer infrastructure (VPC, serveurs) | Configurer l'intérieur des serveurs |
| **Approche** | Déclaratif | Impératif |
| **Agent** | Nécessite backend distant (S3) | Agentless (SSH seulement) |
| **Langage** | HCL | YAML |
| **Idempotent** | Oui (vérification d'état) | Oui (modules idempotents) |
| **Temps déploiement** | Minutes | Secondes |

### 3.2 Structure Ansible

**Troix éléments clés :**

#### 1. Inventory (Inventaire)

Liste des serveurs à configurer.

```ini
# hosts.ini
[webservers]
web-1 ansible_host=3.121.45.67 ansible_user=ubuntu
web-2 ansible_host=3.121.45.68 ansible_user=ubuntu

[webservers:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

#### 2. Playbook

Fichier YAML décrivant les tâches à exécuter.

```yaml
---
- name: Install Nginx
  hosts: webservers
  become: yes  # Utiliser sudo
  
  tasks:
    - name: Update APT
      apt:
        update_cache: yes
    
    - name: Install Nginx
      apt:
        name: nginx
        state: present
    
    - name: Start Nginx
      systemd:
        name: nginx
        state: started
        enabled: yes
```

#### 3. Roles (Optionnel)

Réutiliser des configurations.

```
roles/
├── nginx/
│   ├── tasks/main.yml
│   ├── handlers/main.yml
│   └── templates/nginx.conf.j2
├── mysql/
│   └── tasks/main.yml
└── app/
    └── tasks/main.yml
```

### 3.3 Modules Ansible Courants

| Module | But | Exemple |
|--------|-----|---------|
| `apt` / `yum` | Installer packages | `apt: name=nginx state=present` |
| `systemd` | Gérer services | `systemd: name=nginx state=started` |
| `copy` | Copier fichiers | `copy: src=app.conf dest=/etc/app.conf` |
| `template` | Déployer fichiers Jinja2 | `template: src=nginx.j2 dest=/etc/nginx.conf` |
| `command` / `shell` | Lancer commandes | `shell: systemctl reload nginx` |
| `file` | Créer/supprimer fichiers | `file: path=/tmp/test state=absent` |
| `git` | Cloner repos | `git: repo=https://github.com/app.git` |
| `docker_container` | Gérer conteneurs | `docker_container: name=web image=nginx` |
| `uri` | Tester endpoints HTTP | `uri: url=http://localhost/health status_code=200` |
| `debug` | Afficher messages | `debug: msg="Server {{ inventory_hostname }} ready"` |

### 3.4 Playbook Complet : Installer Nginx + Déployer Page

```yaml
---
- name: Configure web servers with Nginx
  hosts: webservers
  become: yes
  gather_facts: yes

  vars:
    nginx_port: 80
    app_dir: /var/www/devcloud

  tasks:
    # Mise à jour système
    - name: Update APT cache
      apt:
        update_cache: yes
        cache_valid_time: 3600

    # Installer Nginx
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    # Créer répertoire application
    - name: Create app directory
      file:
        path: "{{ app_dir }}"
        state: directory
        mode: '0755'

    # Déployer page HTML
    - name: Deploy index.html
      copy:
        content: |
          <!DOCTYPE html>
          <html>
          <head><title>DevCloud - Module 3</title></head>
          <body>
            <h1>Infrastructure as Code en action!</h1>
            <p>Serveur: {{ ansible_hostname }}</p>
            <p>IP: {{ ansible_default_ipv4.address }}</p>
          </body>
          </html>
        dest: "{{ app_dir }}/index.html"
      notify: restart nginx

    # Déployer configuration Nginx (template Jinja2)
    - name: Deploy Nginx config
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/devcloud
      notify: restart nginx

    # Activer site
    - name: Enable devcloud site
      file:
        src: /etc/nginx/sites-available/devcloud
        dest: /etc/nginx/sites-enabled/devcloud
        state: link
        force: yes
      notify: restart nginx

    # Démarrer Nginx
    - name: Start Nginx
      systemd:
        name: nginx
        state: started
        enabled: yes

    # Health check
    - name: Wait for Nginx
      wait_for:
        port: "{{ nginx_port }}"
        delay: 2

    - name: Test Nginx response
      uri:
        url: "http://localhost:{{ nginx_port }}/index.html"
        status_code: 200
      register: http_test

    - name: Success message
      debug:
        msg: "✓ Nginx is running (status {{ http_test.status }})"

  handlers:
    - name: restart nginx
      systemd:
        name: nginx
        state: restarted
```

### 3.5 Template Jinja2 : nginx.conf.j2

```jinja2
server {
    listen {{ nginx_port }} default_server;
    server_name _;
    
    root {{ app_dir }};
    index index.html;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # Health check endpoint
    location /health {
        access_log off;
        return 200 "healthy\n";
    }
    
    # Logging
    access_log /var/log/nginx/devcloud_access.log;
    error_log /var/log/nginx/devcloud_error.log;
}
```

### 3.6 Intégration Terraform → Ansible

**Problème :** Comment passer les IPs des instances Terraform à Ansible ?

**Solution :** Ansible Dynamic Inventory

**Script : terraform-to-ansible.sh**
```bash
#!/bin/bash
# Générer hosts.ini depuis Terraform outputs

terraform output -json instance_ips | jq -r 'to_entries[] | "\(.key) ansible_host=\(.value)"' > hosts.ini

# Ajouter variables
cat >> hosts.ini << 'EOF'

[webservers:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_user=ubuntu
EOF

# Tester connectivité
ansible -i hosts.ini all -m ping

# Exécuter playbook
ansible-playbook -i hosts.ini playbook.yml
```

---

## CHAPITRE 4 : Architecture Cloud Réseau

### 4.1 VPC : Votre Réseau Privé

**Virtual Private Cloud (VPC)** = Un réseau privé que vous louez dans le cloud.

```
┌─────────────────────────────────────┐
│     AWS (Région: eu-west-3)         │
│  ┌───────────────────────────────┐  │
│  │  VPC: 10.0.0.0/16             │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ Subnet Public           │  │  │
│  │  │ 10.0.1.0/24             │  │  │
│  │  │ [EC2-1] [EC2-2]         │  │  │
│  │  └────────────┬────────────┘  │  │
│  │               │               │  │
│  │       [Internet Gateway]      │  │
│  │               │               │  │
│  └───────────────┼───────────────┘  │
│                  │                  │
└──────────────────┼──────────────────┘
                   │
              [INTERNET]
```

**CIDR Notation :**
- `10.0.0.0/16` = Réseau de 65,536 IPs (10.0.0.0 à 10.0.255.255)
- `10.0.1.0/24` = Subnet de 256 IPs (10.0.1.0 à 10.0.1.255)
- Réservées : `.0` (réseau) et `.255` (broadcast)
- Utilisables : `.1` à `.254`

### 4.2 Subnets : Diviser le Réseau

**Subnet Public :** Instances ont une IP publique, peuvent recevoir Internet.

```hcl
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true  # IP publique automatique
}
```

**Subnet Privé :** Instances n'ont PAS d'IP publique, ne reçoivent pas Internet directement.

```hcl
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  # Pas de map_public_ip_on_launch
}
```

**Pourquoi privé ?** Pour protéger les bases de données. Elles ne doivent pas être accessibles directement depuis Internet.

### 4.3 Internet Gateway (IGW)

Permet au trafic de circuler entre VPC et Internet.

```hcl
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
```

### 4.4 NAT Gateway (Pour Subnets Privés)

Permet aux instances **privées** de sortir sur Internet (pour télécharger packages), mais pas de recevoir connexions entrantes.

```hcl
# NAT Gateway (coûts !!)
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id  # Doit être en subnet public
}

# Route table privée
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}
```

### 4.5 Security Groups : Pare-feu Instance

Contrôle quel trafic est autorisé **entrant** et **sortant**.

```hcl
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id
  
  # ENTRANT
  ingress {
    from_port   = 22    # Port SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Depuis anywhere
  }
  
  ingress {
    from_port   = 80    # Port HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # SORTANT (tout autorisé par défaut)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### 4.6 Load Balancer (ALB)

Distribue le trafic entre plusieurs instances.

```hcl
resource "aws_lb" "main" {
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id]
  
  enable_deletion_protection = false
}

# Target group (instances à equilibrer)
resource "aws_lb_target_group" "web" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }
}

# Listener (reçoit trafic)
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
```

### 4.7 Auto-Scaling Group (ASG)

Crée/détruit instances automatiquement selon la charge CPU.

```hcl
resource "aws_launch_template" "web" {
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  
  iam_instance_profile {
    name = aws_iam_instance_profile.web.name
  }
}

resource "aws_autoscaling_group" "web" {
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  
  min_size         = 2
  max_size         = 10
  desired_capacity = 3
  
  vpc_zone_identifier = [aws_subnet.public.id]
  target_group_arns   = [aws_lb_target_group.web.arn]
  
  health_check_type         = "ELB"
  health_check_grace_period = 300
}

# Scaling policy : ajouter instance si CPU > 70%
resource "aws_autoscaling_policy" "scale_up" {
  autoscaling_group_name = aws_autoscaling_group.web.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}
```

---

## CHAPITRE 5 : Haute Disponibilité & Résilience

### 5.1 RTO & RPO : Définitions Critiques

| Terme | Signification | Exemple |
|-------|--------------|---------|
| **RTO** | Recovery Time Objective | "Combien de temps avant la services est rétabli?" |
| **RPO** | Recovery Point Objective | "Combien de données peux-je perdre?" |

**Exemples Chiffrés :**

| Service | RTO | RPO | Stratégie |
|---------|-----|-----|-----------|
| **Blog personnel** | 1 jour | 1 jour | Backup quotidien |
| **Site e-commerce** | 1 heure | 15 min | Réplication SQL toutes les 15 min |
| **Banque** | < 1 minute | 0 (temps réel) | Réplication synchrone, multi-datacenter |
| **Hôpital** | < 1 minute | < 1 seconde | Infrastructure ultra-redondante |

### 5.2 Multi-AZ : Redondance Géographique

**AZ = Availability Zone** = Datacenter dans une région.

**AWS eu-west-3 (Paris) a 3 AZ :**
```
Paris (eu-west-3)
├── eu-west-3a (Nord)
├── eu-west-3b (Centre)
└── eu-west-3c (Sud)

Distance entre AZ : ~20km (même si l'une brûle, l'autre est OK)
```

**Architecture Simple-Zone (Risqué) :**
```
┌──────────────────────────────────┐
│    eu-west-3a (Single AZ)        │
│  ┌──────────────────────────┐    │
│  │ VPC: 10.0.0.0/16         │    │
│  │ [EC2-1] [EC2-2]          │    │
│  │ [RDS Database]           │    │
│  └──────────────────────────┘    │
└──────────────────────────────────┘

Problème : Un seul incendie = tout down
```

**Architecture Multi-AZ (Recommandé) :**
```
┌──────────────────────────────────────────────────────────────┐
│           AWS (Région: eu-west-3)                            │
│  ┌───────────────────┐        ┌───────────────────┐          │
│  │  AZ: eu-west-3a   │        │  AZ: eu-west-3b   │          │
│  │ [EC2-1]           │        │ [EC2-2]           │          │
│  │ [10.0.1.0/24]     │        │ [10.0.2.0/24]     │          │
│  └────────┬──────────┘        └────────┬──────────┘          │
│           │                            │                     │
│           └───────────────┬────────────┘                     │
│                 [Load Balancer]                              │
│                           │                                  │
│           [RDS Multi-AZ Database]  (Réplication)             │
│                                                              │
└──────────────────────────────────────────────────────────────┘

Avantage : Un AZ brûle ? L'autre prend le relais (failover auto)
```

### 5.3 Failover Automatique

**Health Check :** Le load balancer teste régulièrement les instances.

```
Load Balancer
    │
    ├─→ ping EC2-1 (port 80)   ✓ Sain
    ├─→ ping EC2-2 (port 80)   ✓ Sain
    └─→ Toutes routes vers EC2-1 et EC2-2

Si EC2-1 crash :
    │
    ├─→ ping EC2-1 (port 80)   ✗ Pas de réponse
    └─→ Tout trafic → EC2-2 (failover automatique)

Si EC2-1 revient :
    ├─→ ping EC2-1 (port 80)   ✓ Sain
    └─→ Répartition restored
```

**Code Terraform Multi-AZ :**
```hcl
variable "availability_zones" {
  default = ["eu-west-3a", "eu-west-3b"]
}

# Créer subnet pour chaque AZ
resource "aws_subnet" "public" {
  for_each              = toset(var.availability_zones)
  vpc_id                = aws_vpc.main.id
  cidr_block            = "10.0.${index(var.availability_zones, each.value) + 1}.0/24"
  availability_zone     = each.value
  map_public_ip_on_launch = true
}

# Créer instance pour chaque AZ
resource "aws_instance" "web" {
  for_each           = toset(var.availability_zones)
  ami                = "ami-0c55b159cbfafe1f0"
  instance_type      = "t3.micro"
  subnet_id          = aws_subnet.public[each.value].id
  security_groups    = [aws_security_group.web.id]
  
  tags = { Name = "web-${each.value}" }
}
```

---

## CAS D'ÉTUDE : TechNova Phase 2

### Contexte Scénario

**TechNova**, la startup SaaS qu'on accompagne depuis Module 1, valide sa stratégie cloud (Module 2). Ils passent maintenant en **production**.

**Problème :** Le stagiaire a effacé manuellement le serveur de production hier par erreur. Oups.

**Mission :** Créer une infrastructure **codifiée en Terraform** pour pouvoir la redéployer en moins de 5 minutes en cas de désastre.

### Architecture Simple (TP3.1)

```
┌────────────────────────────────────────────┐
│  TechNova - Phase 2 (Production Basique)   │
│                                            │
│  VPC: 10.0.0.0/16                          │
│  ├─ Subnet Public: 10.0.1.0/24             │
│  │   ├─ [Web Server 1] (3.121.45.67)       │
│  │   └─ [Web Server 2] (3.121.45.68)       │
│  │                                         │
│  ├─ Internet Gateway                       │
│  └─ Security Group                         │
│      ├─ SSH (port 22)                      │
│      ├─ HTTP (port 80)                     │
│      └─ HTTPS (port 443)                   │
└────────────────────────────────────────────┘
```

### Architecture Haute Disponibilité (Aller plus loin)

```
┌──────────────────────────────────────────────────────────┐
│     TechNova - Phase 2 (Production Avancée)              │
│                                                          │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Multi-AZ Failover                                 │  │
│  │                                                    │  │
│  │  ┌─────────────────┐    ┌─────────────────┐        │  │
│  │  │  AZ: eu-west-3a │    │  AZ: eu-west-3b │        │  │
│  │  │  [Web-1]        │    │  [Web-2]        │        │  │
│  │  │  [10.0.1.0/24]  │    │  [10.0.2.0/24]  │        │  │
│  │  └────────┬────────┘    └────────┬────────┘        │  │
│  │           │                      │                 │  │
│  │           └──────┬───────────────┘                 │  │
│  │                  │                                 │  │
│  │         [Load Balancer (ALB)]                      │  │
│  │                  │                                 │  │
│  │         Health Check (Health/30s)                  │  │
│  │                                                    │  │
│  │    [RDS Database - Multi-AZ Replication]           │  │
│  └────────────────────────────────────────────────────┘  │
│                                                          │
│  RTO: < 1 minute (failover automatique)                  │
│  RPO: 0 secondes (réplication synchrone)                 │
└──────────────────────────────────────────────────────────┘
```

### Points Clés pour TechNova

1. **Reproductibilité** : Terraform permet de recréer l'infra en 5 minutes.
2. **Versionning** : Git trace qui a changé quoi et quand.
3. **Scaling** : Avec Auto-Scaling Group, gérer 1000 utilisateurs ou 1 million, c'est pareil.
4. **Coûts** : Destroy après TP = zéro coûts.

---

## Glossaire & Ressources

### Termes Techniques

| Terme | Définition |
|-------|-----------|
| **HCL** | HashiCorp Configuration Language (langage Terraform) |
| **Provider** | Plugin Terraform pour une plateforme (AWS, Azure, etc.) |
| **Resource** | Une entité cloud (EC2, VPC, subnet, etc.) |
| **State** | Fichier `.tfstate` (mémoire Terraform) |
| **Idempotent** | Exécuter 2 fois = même résultat |
| **Drift** | Changements manuels non autorisés |
| **VPC** | Virtual Private Cloud (réseau privé) |
| **Subnet** | Segment de VPC avec son CIDR |
| **CIDR** | Notation pour notation plages IP (10.0.0.0/16) |
| **Security Group** | Pare-feu au niveau instance |
| **NAT Gateway** | Sortie anonyme pour subnets privés |
| **ALB** | Application Load Balancer |
| **ASG** | Auto-Scaling Group |
| **Playbook** | Fichier YAML Ansible décrivant tâches |
| **Inventory** | Liste des serveurs Ansible |
| **Handler** | Tâche spéciale qui s'exécute si notifiée |
| **Template** | Fichier dynamique (Jinja2) |
| **RTO** | Recovery Time Objective (temps pour rétablir) |
| **RPO** | Recovery Point Objective (données perdues max) |
| **Multi-AZ** | Redondance sur plusieurs datacenters |
| **Health Check** | Vérification régulière de l'état des services |

### Documentation Officielle

- **Terraform Registry :** https://registry.terraform.io/
- **Terraform AWS Provider :** https://registry.terraform.io/providers/hashicorp/aws/latest
- **Ansible Docs :** https://docs.ansible.com/
- **AWS VPC Documentation :** https://docs.aws.amazon.com/vpc/
- **Terraform Best Practices :** https://www.terraform.io/docs/cloud/guides/recommended-practices

### Tutoriels Recommandés

- **Terraform in 100 Seconds** (FreeCodeCamp YouTube)
- **Ansible Getting Started** (ansible.com docs)
- **AWS for Beginners** (various CloudAcademy courses)

### Outils Pratiques

```bash
# Formater code Terraform
terraform fmt

# Linter Terraform
tflint

# Ansible linter
ansible-lint playbook.yml

# Check Ansible syntax
ansible-playbook playbook.yml --syntax-check
```

---

## ✅ Checklist : Êtes-vous prêt pour les TPs ?

Avant de commencer les travaux pratiques, vérifiez que vous comprenez :

- [ ] Différence entre approche déclarative (Terraform) et impérative (Ansible)
- [ ] Les 4 étapes du workflow Terraform (init, plan, apply, destroy)
- [ ] Pourquoi le fichier `.tfstate` est critique
- [ ] Concept d'idempotence (pourquoi terraform apply 2 fois = même résultat)
- [ ] Configuration Drift et comment le détecter
- [ ] Structure VPC : VPC → Subnets → Internet Gateway → Routage
- [ ] Security Groups : ingress vs egress
- [ ] Ansible : inventory, playbooks, handlers, templates
- [ ] Comment passer les outputs Terraform à Ansible
- [ ] Multi-AZ et failover automatique (concept, pas obligatoire pour TP)

**Si vous cochez 8+ points : Vous êtes prêt ! 🚀**


# SUPPORT DE TRAVAUX PRATIQUES (TP3)

**Durée :** 3 heures  
**Outils :** Terraform, Ansible, AWS CLI, SSH  
**Scénario :** TechNova – Phase 2 (Redéploiement d'urgence)

---

## TABLE DES MATIÈRES

- [Préambule & Scénario](#preambule)
- [Pré-requis](#prequisite)
- [TP3.1 : Provisionning Infrastructure avec Terraform (1.5h)](#tp31)
- [TP3.2 : Configuration avec Ansible (1.5h)](#tp32)
- [Évaluation & Rubrics](#evaluation)
- [Dépannage Rapide](#depannage)

---

## PRÉAMBULE & SCÉNARIO

### Contexte

**TechNova** a validé sa stratégie cloud (Module 2). Ils passent maintenant en **production avec deux serveurs web**.

**Hier :** Le stagiaire a cliqué sur "Terminer instance" par erreur à 14h47.

**Aujourd'hui :** Vous devez redéployer l'infrastructure **identique** en moins de 5 minutes. Comment ? Avec du code.

### Objectifs Pédagogiques

À la fin des TPs, vous devrez être capable de :

1. ✅ Écrire un plan Terraform complet (provider, ressources, outputs)
2. ✅ Provisionner une infrastructure cloud (VPC, Subnet, IGW, EC2, SG)
3. ✅ Appliquer le workflow Terraform (init, plan, apply, destroy)
4. ✅ Générer un inventaire Ansible depuis Terraform outputs
5. ✅ Configurer des serveurs avec Ansible playbooks
6. ✅ Déployer une application avec templates Jinja2
7. ✅ Valider l'infrastructure (health checks, tests HTTP)
8. ✅ Nettoyer complètement les ressources (coûts)

### Timing Prévu

```
00:00-00:15 → Setup & validations
00:15-01:15 → TP3.1 Terraform (Créer infra)
01:15-01:30 → Pause
01:30-03:00 → TP3.2 Ansible (Configurer)
```

---

## ✅ PRÉ-REQUIS

Avant de commencer, vérifiez que vous avez :

### Logiciels à Installer

```bash
# 1. Vérifier Terraform
terraform version
# Output attendu : Terraform v1.5+ (au minimum v1.0)

# 2. Vérifier Ansible
ansible --version
# Output attendu : ansible 2.9+

# 3. Vérifier AWS CLI
aws --version
# Output attendu : aws-cli/2.x

# 4. Vérifier Git
git --version
# Output attendu : git version 2.x+

# 5. Vérifier clé SSH
ls ~/.ssh/id_rsa.pub
# Output attendu : afficher le chemin (ex: /home/user/.ssh/id_rsa.pub)
```

### Compte AWS

- [ ] Compte AWS avec crédits Free Tier disponibles
- [ ] Credentials configurées : `aws configure` (ou variables d'env)
- [ ] Région par défaut : `eu-west-3` (Paris)

### Dossier de Travail

```bash
# Créer dossier projet
mkdir -p ~/techNova-iac/terraform ~/techNova-iac/ansible
cd ~/techNova-iac

# Arborescence attendue
techNova-iac/
├── terraform/
│   ├── main.tf              # Configuration provider
│   ├── variables.tf         # Variables
│   ├── vpc.tf               # Réseau
│   ├── security.tf          # Sécurité
│   ├── instances.tf         # EC2
│   ├── outputs.tf           # Résultats
│   └── terraform.tfvars     # Valeurs
├── ansible/
│   ├── playbook.yml         # Playbook principal
│   ├── hosts.ini            # Inventaire (généré)
│   └── nginx.conf.j2        # Template
└── scripts/
    ├── terraform-to-ansible.sh  # Script intégration
    └── cleanup.sh               # Nettoyage
```

---

## TP3.1 : Provisionning Infrastructure avec Terraform

**Durée :** 1 heure 30 minutes  
**Livrable :** Infrastructure AWS fonctionnelle + captures d'écran

### Objectifs TP3.1

- [ ] Initialiser projet Terraform
- [ ] Configurer provider AWS
- [ ] Créer VPC + Subnet public + Internet Gateway
- [ ] Créer Security Group (SSH + HTTP)
- [ ] Lancer 2 instances EC2 (t3.micro)
- [ ] Générer outputs (IPs publiques)
- [ ] Valider avec terraform plan
- [ ] Appliquer avec terraform apply
- [ ] Tester SSH vers une instance
- [ ] Nettoyer avec terraform destroy

### Étape 1 : Initialiser le Projet (5 min)

```bash
cd ~/techNova-iac/terraform

# 1a. Créer fichier main.tf
cat > main.tf << 'EOF'
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"  # Paris
  
  default_tags {
    tags = {
      Project     = "TechNova-Phase2"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}
EOF

# 1b. Initialiser Terraform
terraform init

# Output attendu:
# Initializing the backend...
# Downloading aws v5.x.x...
# Terraform has been successfully configured!
```

**Checkpoint 1 ✓**
```bash
# Vérifier que tout est OK
ls -la
# Vérifier présence de .terraform/
```

### Étape 2 : Configurer Variables (5 min)

```bash
# 2a. Créer fichier variables.tf
cat > variables.tf << 'EOF'
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block du VPC"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type instance EC2 (free tier)"
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "Nombre d'instances à créer"
  
  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 5
    error_message = "Entre 1 et 5 instances."
  }
}
EOF

# 2b. Créer fichier terraform.tfvars (surcharge valeurs)
cat > terraform.tfvars << 'EOF'
vpc_cidr       = "10.0.0.0/16"
instance_type  = "t3.micro"
instance_count = 2
EOF
```

### Étape 3 : Créer Réseau VPC (15 min)

```bash
# 3a. Créer fichier vpc.tf
cat > vpc.tf << 'EOF'
# ==================== VPC ====================

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { Name = "vpc-technova" }
}

# ==================== SUBNET PUBLIC ====================

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = { Name = "subnet-public-technova" }
}

# ==================== INTERNET GATEWAY ====================

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "igw-technova" }
}

# ==================== ROUTE TABLE ====================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = { Name = "rt-public-technova" }

  depends_on = [aws_internet_gateway.main]
}

# ==================== ROUTE TABLE ASSOCIATION ====================

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
EOF

# 3b. Valider syntaxe
terraform validate

# Output attendu : Success! The configuration is valid.
```

**Checkpoint 2 ✓**
```bash
terraform plan | grep -E "(add|change|destroy)"
# Vérifier : "Plan: X to add, 0 to change, 0 to destroy"
```

### Étape 4 : Créer Sécurité & Clé SSH (10 min)

```bash
# 4a. Créer fichier security.tf
cat > security.tf << 'EOF'
# ==================== SECURITY GROUP ====================

resource "aws_security_group" "web" {
  name        = "sg-web-technova"
  description = "Security group pour serveurs web"
  vpc_id      = aws_vpc.main.id

  # ========== INBOUND ==========

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access"
  }

  # ========== OUTBOUND ==========

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = { Name = "sg-web-technova" }
}

# ==================== SSH KEY PAIR ====================

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-technova"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = { Name = "deployer-key" }
}
EOF

# 4b. Valider
terraform validate
```

**Checkpoint 3 ✓**
```bash
terraform plan | grep "aws_security_group\|aws_key_pair"
# Vérifier présence dans plan
```

### Étape 5 : Lancer Instances EC2 (10 min)

```bash
# 5a. Créer fichier instances.tf
cat > instances.tf << 'EOF'
# ==================== DATA : Trouver AMI Ubuntu ====================

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ==================== EC2 INSTANCES ====================

resource "aws_instance" "web" {
  count              = var.instance_count
  ami                = data.aws_ami.ubuntu.id
  instance_type      = var.instance_type
  key_name           = aws_key_pair.deployer.key_name
  subnet_id          = aws_subnet.public.id
  security_groups    = [aws_security_group.web.id]
  monitoring         = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name = "web-technova-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.main]

  lifecycle {
    create_before_destroy = true
  }
}
EOF

# 5b. Valider
terraform validate
```

### Étape 6 : Configurer Outputs (10 min)

```bash
# 6a. Créer fichier outputs.tf
cat > outputs.tf << 'EOF'
# ==================== VPC OUTPUTS ====================

output "vpc_id" {
  description = "ID du VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID du subnet public"
  value       = aws_subnet.public.id
}

# ==================== INSTANCE OUTPUTS ====================

output "instance_ids" {
  description = "IDs des instances EC2"
  value       = aws_instance.web[*].id
}

output "instance_ips_public" {
  description = "IPs publiques (SSH/HTTP)"
  value       = aws_instance.web[*].public_ip
}

output "instance_ips_private" {
  description = "IPs privées"
  value       = aws_instance.web[*].private_ip
}

# ==================== ANSIBLE OUTPUTS ====================

output "instance_ips" {
  description = "IPs publiques formatées pour Ansible"
  value = {
    for i, instance in aws_instance.web :
    instance.tags["Name"] => instance.public_ip
  }
}

# Inventaire Ansible ready-to-use
output "ansible_inventory" {
  description = "Inventaire Ansible (copy-paste)"
  value = "[webservers]\n${join("\n", [
    for i, instance in aws_instance.web :
    "${instance.tags["Name"]} ansible_host=${instance.public_ip} ansible_user=ubuntu"
  ])}\n\n[webservers:vars]\nansible_ssh_private_key_file=~/.ssh/id_rsa"
}

# ==================== SUMMARY ====================

output "deployment_summary" {
  description = "Résumé du déploiement"
  value = {
    vpc_cidr       = aws_vpc.main.cidr_block
    subnet_cidr    = aws_subnet.public.cidr_block
    instances_count = var.instance_count
    instance_type  = var.instance_type
  }
}
EOF

# 6b. Valider
terraform validate

# Output attendu : Success!
```

**Checkpoint 4 ✓**
```bash
terraform validate
# Vérifier output
```

### Étape 7 : Terraform Plan (10 min)

```bash
# 7a. Vérifier le plan AVANT d'appliquer
terraform plan -out=tfplan

# Output attendu ressemble à :
# Plan: 8 to add, 0 to change, 0 to destroy.
#
# aws_vpc.main will be created
# aws_subnet.public will be created
# aws_internet_gateway.main will be created
# ... (autres ressources)

# Nombre exact peut varier, mais autour de 8 ressources
```

**IMPORTANT :** Lisez le plan entièrement ! Vérifiez :
- [ ] VPC CIDR : 10.0.0.0/16
- [ ] Subnet CIDR : 10.0.1.0/24
- [ ] 2 instances EC2 (count = 2)
- [ ] Security Group avec SSH (22) et HTTP (80)
- [ ] Aucune ressource ne sera supprimée (destroy = 0)

### Étape 8 : Terraform Apply (15 min)

```bash
# 8a. APPLIQUER LE PLAN (création réelle)
terraform apply tfplan

# Output attendu :
# aws_vpc.main: Creating...
# aws_vpc.main: Creation complete after 2s [id=vpc-0123456789]
# aws_internet_gateway.main: Creating...
# ...
# Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

# ⏱️ Temps attendu : 3-5 minutes pour tout
```

**Checkpoint 5 ✓**
```bash
# Vérifier que tout est créé
terraform state list | wc -l
# Devrait afficher ~8 ressources
```

### Étape 9 : Afficher Outputs (5 min)

```bash
# 9a. Afficher outputs (IPs publiques)
terraform output instance_ips

# Output attendu :
# instance_ips = {
#   "web-technova-1" = "3.121.45.67"
#   "web-technova-2" = "3.121.45.68"
# }

# 9b. Afficher inventaire Ansible (utile pour TP3.2)
terraform output -raw ansible_inventory

# Output attendu :
# [webservers]
# web-technova-1 ansible_host=3.121.45.67 ansible_user=ubuntu
# web-technova-2 ansible_host=3.121.45.68 ansible_user=ubuntu
#
# [webservers:vars]
# ansible_ssh_private_key_file=~/.ssh/id_rsa

# 9c. Sauvegarder dans fichier
terraform output -raw ansible_inventory > ../ansible/hosts.ini
```

**Checkpoint 6 ✓**
```bash
cat ../ansible/hosts.ini
# Vérifier présence des IPs
```

### Étape 10 : Tester SSH (10 min)

```bash
# 10a. Récupérer une IP
IP=$(terraform output -json instance_ips | jq -r 'to_entries[0].value')
echo "IP de test : $IP"

# 10b. Attendre que l'instance soit prête
echo "⏳ Attente 30s pour que l'instance démarre..."
sleep 30

# 10c. Tester SSH
ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no ubuntu@$IP "whoami"

# Output attendu : ubuntu

# 10d. Tester depuis l'instance
ssh -i ~/.ssh/id_rsa ubuntu@$IP "uname -a"

# Output attendu : Linux web-technova-1 5.15.0-... Ubuntu...

# 10e. Afficher IPs publiques
echo "✓ Instances déployées avec succès !"
echo ""
echo "IPs publiques :"
terraform output instance_ips
```

**Checkpoint 7 ✓**
```bash
# Vous devriez pouvoir SSH sans erreurs
```

### Étape 11 : Capturer & Documenter (10 min)

```bash
# 11a. Capture terraform plan
terraform plan > ~/plan_screenshot.txt

# 11b. Capture terraform state
terraform show > ~/state_screenshot.txt

# 11c. Capture outputs
terraform output > ~/outputs_screenshot.txt

# 11d. Créer fichier README
cat > README.md << 'EOF'
# TechNova Phase 2 - Infrastructure as Code

## Déploiement Terraform réussi

**Date :** $(date)
**Ressources créées :** 8

### Instances EC2
- Instance 1 : web-technova-1
- Instance 2 : web-technova-2

### VPC
- ID VPC : $(terraform output -raw vpc_id)
- CIDR : 10.0.0.0/16

### IPs Publiques
$(terraform output instance_ips)

## Prochaine étape
Lancer TP3.2 (Ansible) pour configurer les serveurs.
EOF

cat README.md
```

### ✅ Livrables TP3.1

Avant de passer à TP3.2, assurez-vous d'avoir :

- [ ] Fichiers Terraform créés (main.tf, variables.tf, vpc.tf, security.tf, instances.tf, outputs.tf)
- [ ] Exécution sans erreurs : `terraform validate` ✓
- [ ] Plan généré : `terraform plan` affiche "Plan: 8 to add..."
- [ ] Infrastructure créée : `terraform apply` réussi
- [ ] IPs publiques obtenues et affichées
- [ ] SSH fonctionnel vers au moins une instance
- [ ] Inventaire Ansible généré (hosts.ini)
- [ ] Captures d'écran ou fichiers logs

---

## TP3.2 : Configuration avec Ansible (1.5h) 

**Durée :** 1 heure 30 minutes  
**Prérequisite :** TP3.1 complété  
**Livrable :** Serveurs web fonctionnels avec Nginx

### Objectifs TP3.2

- [ ] Générer inventaire Ansible depuis Terraform
- [ ] Tester connectivité Ansible (ping)
- [ ] Écrire playbook Ansible (installer Nginx)
- [ ] Créer template Jinja2 (configuration Nginx)
- [ ] Déployer page HTML dynamique
- [ ] Configurer handlers (restart Nginx)
- [ ] Lancer playbook et vérifier
- [ ] Accéder à pages depuis navigateur
- [ ] Valider health checks

### Étape 1 : Générer Inventaire Ansible (5 min)

```bash
cd ~/techNova-iac/ansible

# 1a. Générer hosts.ini depuis Terraform outputs
terraform output -raw ansible_inventory > hosts.ini

# 1b. Vérifier contenu
cat hosts.ini

# Output attendu :
# [webservers]
# web-technova-1 ansible_host=3.121.45.67 ansible_user=ubuntu
# web-technova-2 ansible_host=3.121.45.68 ansible_user=ubuntu
#
# [webservers:vars]
# ansible_ssh_private_key_file=~/.ssh/id_rsa
```

**Checkpoint 1 ✓**
```bash
wc -l hosts.ini
# Devrait avoir au moins 5 lignes
```

### Étape 2 : Tester Connectivité Ansible (5 min)

```bash
# 2a. Vérifier que Ansible peut atteindre les instances
ansible -i hosts.ini all -m ping

# Output attendu :
# web-technova-1 | SUCCESS => {
#     "ping": "pong"
# }
# web-technova-2 | SUCCESS => {
#     "ping": "pong"
# }

# 2b. Si erreur "Unreachable" :
# → Attendre quelques secondes (instances en démarrage)
# → Vérifier Security Group (port 22 ouvert)
# → Vérifier clé SSH : ls -la ~/.ssh/id_rsa

sleep 30
ansible -i hosts.ini all -m ping
```

**Checkpoint 2 ✓**
```bash
# Devrait afficher SUCCESS sur les 2 instances
```

### Étape 3 : Créer Playbook Ansible (20 min)

```bash
# 3a. Créer playbook.yml
cat > playbook.yml << 'EOF'
---
- name: Configure web servers with Nginx
  hosts: webservers
  become: yes
  gather_facts: yes

  vars:
    nginx_port: 80
    app_dir: /var/www/devcloud
    app_user: www-data

  pre_tasks:
    - name: Display deployment info
      debug:
        msg: |
          Déploiement vers {{ inventory_hostname }}
          IP : {{ ansible_default_ipv4.address }}
          OS : {{ ansible_distribution }} {{ ansible_distribution_version }}

  tasks:
    # ========== SYSTEM ==========

    - name: Update APT cache
      apt:
        update_cache: yes
        cache_valid_time: 3600

    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Install curl (for health checks)
      apt:
        name: curl
        state: present

    # ========== DIRECTORIES ==========

    - name: Create application directory
      file:
        path: "{{ app_dir }}"
        state: directory
        owner: "{{ app_user }}"
        group: "{{ app_user }}"
        mode: '0755'

    # ========== DEPLOY APPLICATION ==========

    - name: Deploy index.html
      copy:
        content: |
          <!DOCTYPE html>
          <html lang="fr">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>TechNova - Phase 2</title>
            <style>
              * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
              }
              body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
              }
              .container {
                background: white;
                border-radius: 10px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                padding: 40px;
                max-width: 600px;
                text-align: center;
              }
              h1 {
                color: #333;
                margin-bottom: 20px;
              }
              .info-box {
                background: #f8f9fa;
                border-left: 4px solid #667eea;
                padding: 20px;
                margin: 20px 0;
                text-align: left;
                border-radius: 5px;
              }
              .label {
                font-weight: bold;
                color: #667eea;
              }
              .badge {
                display: inline-block;
                background: #667eea;
                color: white;
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 0.9em;
                margin-top: 20px;
              }
            </style>
          </head>
          <body>
            <div class="container">
              <h1>🚀 TechNova Phase 2</h1>
              <h2 style="color: #666; font-size: 1.1em; margin-bottom: 30px;">Infrastructure as Code</h2>
              
              <div class="info-box">
                <p><span class="label">Serveur :</span> {{ ansible_hostname }}</p>
                <p><span class="label">IP Privée :</span> {{ ansible_default_ipv4.address }}</p>
                <p><span class="label">OS :</span> {{ ansible_distribution }} {{ ansible_distribution_version }}</p>
              </div>

              <p style="margin-top: 30px; color: #666;">
                Cette page a été déployée automatiquement avec Terraform + Ansible
              </p>
              <span class="badge">✓ Nginx est opérationnel</span>
            </div>
          </body>
          </html>
        dest: "{{ app_dir }}/index.html"
        owner: "{{ app_user }}"
        group: "{{ app_user }}"
        mode: '0644'
      notify: restart nginx

    # ========== NGINX CONFIG ==========

    - name: Deploy Nginx configuration
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/devcloud
        owner: root
        group: root
        mode: '0644'
        backup: yes
      notify: restart nginx

    - name: Enable devcloud site
      file:
        src: /etc/nginx/sites-available/devcloud
        dest: /etc/nginx/sites-enabled/devcloud
        state: link
        force: yes
      notify: restart nginx

    - name: Disable default site
      file:
        path: /etc/nginx/sites-enabled/default
        state: absent
      notify: restart nginx

    # ========== SERVICES ==========

    - name: Start and enable Nginx
      systemd:
        name: nginx
        state: started
        enabled: yes
        daemon_reload: yes

    # ========== HEALTH CHECKS ==========

    - name: Wait for Nginx to be ready
      wait_for:
        port: "{{ nginx_port }}"
        delay: 2
        timeout: 10

    - name: Test HTTP response
      uri:
        url: "http://localhost:{{ nginx_port }}/index.html"
        status_code: 200
      register: http_test
      retries: 3
      delay: 2

    - name: Display health check result
      debug:
        msg: |
          ✓ Health check PASSED
          Status: {{ http_test.status }}
          URL: http://{{ inventory_hostname }}/index.html

  handlers:
    - name: restart nginx
      systemd:
        name: nginx
        state: restarted
        daemon_reload: yes

  post_tasks:
    - name: Deployment summary
      debug:
        msg: |
          ✅ Déploiement réussi !
          
          Accédez à : http://{{ ansible_default_ipv4.address }}/index.html
          SSH : ssh -i ~/.ssh/id_rsa ubuntu@{{ ansible_default_ipv4.address }}
EOF

# 3b. Vérifier syntaxe
ansible-playbook -i hosts.ini playbook.yml --syntax-check

# Output attendu : playbook.yml is valid
```

**Checkpoint 3 ✓**
```bash
# Syntaxe correcte
```

### Étape 4 : Créer Template Jinja2 (10 min)

```bash
# 4a. Créer nginx.conf.j2
cat > nginx.conf.j2 << 'EOF'
# Nginx configuration for TechNova
# Generated by Ansible

server {
    listen {{ nginx_port }} default_server;
    listen [::]:{{ nginx_port }} default_server;

    server_name _;

    # Compression
    gzip on;
    gzip_types text/plain text/css text/javascript application/json;
    gzip_vary on;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Root directory
    root {{ app_dir }};
    index index.html;

    # Main location
    location / {
        try_files $uri $uri/ =404;
    }

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }

    # Deny hidden files
    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }

    # Logging
    access_log /var/log/nginx/devcloud_access.log combined buffer=32k;
    error_log /var/log/nginx/devcloud_error.log warn;
}
EOF

# 4b. Vérifier fichier
cat nginx.conf.j2
```

**Checkpoint 4 ✓**
```bash
# Vérifier présence du fichier
ls -la nginx.conf.j2
```

### Étape 5 : Dry-Run (Test sans Modifier) (5 min)

```bash
# 5a. Tester le playbook en mode check (dry-run)
ansible-playbook -i hosts.ini playbook.yml --check

# Output attendu :
# TASK [Update APT cache] *****
# changed: [web-technova-1]
# changed: [web-technova-2]
# ...
#
# PLAY RECAP *******************
# web-technova-1 : ok=X changed=Y unreachable=0 failed=0
# web-technova-2 : ok=X changed=Y unreachable=0 failed=0

# Remarque : "changed" car c'est un dry-run. En réel, ça sera different.
```

### Étape 6 : Exécuter le Playbook (25 min)

```bash
# 6a. EXÉCUTER POUR VRAI
ansible-playbook -i hosts.ini playbook.yml -v

# Output attendu :
# PLAY [Configure web servers with Nginx] ***
# TASK [Display deployment info] *****
# ok: [web-technova-1] => {
#     "msg": "Déploiement vers web-technova-1..."
# }
# TASK [Update APT cache] *****
# changed: [web-technova-1]
# changed: [web-technova-2]
# ...
# TASK [Test HTTP response] *****
# ok: [web-technova-1]
# ok: [web-technova-2]
# ...
# PLAY RECAP ***
# web-technova-1 : ok=13 changed=4 unreachable=0 failed=0
# web-technova-2 : ok=13 changed=4 unreachable=0 failed=0

# ⏱️ Temps attendu : 10-15 minutes

# Sauvegardez ce résultat !
ansible-playbook -i hosts.ini playbook.yml -v > playbook_execution.log 2>&1
```

**Checkpoint 6 ✓**
```bash
# Vérifier succès
grep "unreachable=0 failed=0" playbook_execution.log
```

### Étape 7 : Valider Infrastructure (15 min)

```bash
# 7a. Obtenir IPs
cd ../terraform
WEB1=$(terraform output -json instance_ips | jq -r 'to_entries[0].value')
WEB2=$(terraform output -json instance_ips | jq -r 'to_entries[1].value')

echo "Web 1 : $WEB1"
echo "Web 2 : $WEB2"

# 7b. Tester avec curl
echo "Test serveur 1 :"
curl -s http://$WEB1/index.html | head -20

echo ""
echo "Test serveur 2 :"
curl -s http://$WEB2/index.html | head -20

# 7c. Tester health check
echo ""
echo "Health checks :"
curl -s http://$WEB1/health
curl -s http://$WEB2/health

# 7d. Depuis navigateur (optionnel)
echo ""
echo "Ouvrez dans votre navigateur :"
echo "  - http://$WEB1"
echo "  - http://$WEB2"
```

### Étape 8 : Capturer Résultats (5 min)

```bash
# 8a. Logs de déploiement
ansible-playbook -i ../ansible/hosts.ini ../ansible/playbook.yml > deployment_log.txt 2>&1

# 8b. Test de connectivité
ansible -i ../ansible/hosts.ini all -m command -a "nginx -v" > nginx_versions.txt

# 8c. Vérifier pages HTML
curl http://$WEB1 > server1.html
curl http://$WEB2 > server2.html

# 8d. Résumé
cat > ../DEPLOYMENT_SUMMARY.md << 'EOF'
# TechNova Phase 2 - Déploiement Réussi ✅

## Infrastructure (Terraform)
- VPC : vpc-XXXXX (10.0.0.0/16)
- Instances : 2 x t3.micro (Free Tier)
- Security Group : SSH (22) + HTTP (80)

## Configuration (Ansible)
- Nginx installé et démarré
- Pages HTML déployées
- Health checks fonctionnels

## IPs Publiques
- Web 1 : $(echo $WEB1)
- Web 2 : $(echo $WEB2)

## Vérification
- SSH : ✓ Fonctionnel
- HTTP : ✓ Pages accessible
- Health : ✓ Réponses positives

## Prochaines étapes
1. Nettoyer avec `terraform destroy`
2. Archiver logs
3. Valider pour Module 4
EOF

cat ../DEPLOYMENT_SUMMARY.md
```

### ✅ Livrables TP3.2

- [ ] Playbook Ansible créé (playbook.yml)
- [ ] Template Nginx créé (nginx.conf.j2)
- [ ] Inventaire Ansible généré (hosts.ini)
- [ ] Exécution sans erreurs (logs capturés)
- [ ] 2 serveurs avec Nginx en cours d'exécution
- [ ] Pages HTML accessibles depuis navigateur
- [ ] Health checks réussis
- [ ] Captures d'écran ou fichiers logs

---

## ÉVALUATION & RUBRICS 

### Grille d'Évaluation TP3.1 : Terraform (/20)

| Critère | Points | Validation |
|---------|--------|------------|
| **Code Terraform syntaxiquement correct** | 3 | `terraform validate` = Success |
| **VPC + Subnet créés** | 2 | Terraform state contient aws_vpc + aws_subnet |
| **Internet Gateway + Route Table** | 2 | IGW attaché, routes configurées |
| **Security Group (SSH + HTTP)** | 2 | Ports 22 et 80 autorisés |
| **2 instances EC2 t3.micro** | 3 | Instances créées avec count=2 |
| **Outputs configurés** | 2 | terraform output affiche IPs publiques |
| **SSH fonctionnel** | 2 | Connexion SSH réussie vers une instance |
| **Destruction complète** | 2 | `terraform destroy` supprime tout sans erreurs |
| **Documentation / Commentaires** | 1 | Code commenté et lisible |
| **Gestion d'erreurs** | 1 | Handling validations + depends_on |

**Total TP3.1 : /20**  

---

### Grille d'Évaluation TP3.2 : Ansible (/20)

| Critère                             | Points | Validation                               |
| ----------------------------------- | ------ | ---------------------------------------- |
| **Inventaire généré correctement**  | 2      | hosts.ini contient IPs et variables      |
| **Connectivité Ansible (ping)**     | 2      | `ansible all -m ping` = SUCCESS          |
| **Playbook syntaxiquement correct** | 2      | `--syntax-check` = valid                 |
| **Nginx installé + démarré**        | 3      | `systemctl status nginx` = active        |
| **Pages HTML déployées**            | 2      | Pages accessibles avec curl              |
| **Template Jinja2 fonctionnel**     | 2      | Configuration Nginx générée correctement |
| **Health checks réussis**           | 2      | `uri` module retourne 200 OK             |
| **Handlers fonctionnels**           | 2      | Nginx redémarré lors des changements     |
| **Logs + Documentation**            | 2      | Logs de déploiement capturés             |
| **Tests finaux**                    | 1      | Pages HTML accessibles depuis navigateur |

**Total TP3.2 : /20**  

---
## DÉPANNAGE RAPIDE 

### Erreurs Terraform Courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Provider hashicorp/aws not found` | Init non complétée | Lancer `terraform init` |
| `state locked` | TP précédent non nettoyé | `terraform force-unlock <ID>` ou attendre |
| `CIDR already in use` | VPC avec même CIDR existe | Changer CIDR (ex: 10.1.0.0/16) |
| `Key not found` | Chemin clé SSH incorrect | Vérifier : `ls ~/.ssh/id_rsa.pub` |
| `instance unreachable` | SG bloque port 22 | Vérifier Security Group (SSH=22) |
| `invalid resource name` | Caractères invalides (-) | Utiliser _ (ex: sg_web au lieu de sg-web) |

### Erreurs Ansible Courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `unreachable` | SSH échoue | Vérifier SG, clé SSH, instances démarrées |
| `permission denied` | Besoin sudo | Ajouter `become: yes` dans playbook |
| `host not found` | Inventory incorrect | Vérifier hosts.ini (IPs, user) |
| `module not found` | Module Ansible manquant | Vérifier spelling (apt vs aptget) |
| `template not found` | Path relatif incorrect | Vérifier chemin (nginx.conf.j2 au même niveau) |

### Commandes Debug Utiles

```bash
# ========== TERRAFORM ==========

# Lister toutes ressources
terraform state list

# Afficher détails d'une ressource
terraform state show aws_instance.web[0]

# Formater automatiquement le code
terraform fmt -recursive

# Générer graphe dépendances (PNG)
terraform graph | dot -Tpng > graph.png

# ========== ANSIBLE ==========

# Afficher inventory détaillé
ansible-inventory -i hosts.ini --list | jq .

# Récupérer informations système
ansible all -i hosts.ini -m setup | head -100

# Ultra verbose pour déboguer
ansible-playbook -i hosts.ini playbook.yml -vvv

# Exécuter ad-hoc (commande unique)
ansible all -i hosts.ini -m command -a "systemctl status nginx"

# Tester template avant déploiement
ansible all -i hosts.ini -m template -a "src=nginx.conf.j2 dest=/tmp/test.conf" --check
```

### Problèmes Courants & Solutions

**Problème : Instances sont créées mais pas accessibles en SSH**

```bash
# Causes possibles :
# 1. Instance encore en démarrage (attendre 30s)
# 2. Security Group bloque port 22
# 3. Clé SSH locale n'existe pas

# Solutions :
sleep 30  # Attendre
terraform show | grep "security_groups"  # Vérifier SG
ls -la ~/.ssh/id_rsa  # Vérifier clé

# Test manuel SSH avec verbose
ssh -v -i ~/.ssh/id_rsa ubuntu@IP
```

**Problème : Ansible pas de ping réponse**

```bash
# Cause : Instances pas totalement démarrées
sleep 60
ansible -i hosts.ini all -m ping

# Alternative : tester SSH directement
ssh -i ~/.ssh/id_rsa ubuntu@IP "echo 'OK'"
```

**Problème : Nginx n'accépte pas la configuration**

```bash
# Valider syntaxe Nginx
nginx -t  # À lancer dans l'instance

# Via Ansible
ansible all -i hosts.ini -b -m command -a "nginx -t"

# Voir logs
ansible all -i hosts.ini -b -m command -a "tail -20 /var/log/nginx/error.log"
```

**Problème : Pages HTML ne s'affichent pas**

```bash
# Vérifier permissions fichiers
ansible all -i hosts.ini -b -m command -a "ls -la /var/www/devcloud"

# Vérifier logs Nginx
ansible all -i hosts.ini -b -m command -a "tail /var/log/nginx/access.log"

# Tester depuis l'instance
ansible all -i hosts.ini -m command -a "curl -s http://localhost/index.html"
```

---

## Checklist Finale Avant Validation

### Avant TP3.1

- [ ] Terraform installé (version >= 1.0)
- [ ] Clé SSH générée (~/.ssh/id_rsa.pub existe)
- [ ] AWS credentials configurées
- [ ] Compte AWS avec free tier disponible

### Après TP3.1

- [ ] 8 ressources créées (terraform state list)
- [ ] SSH fonctionnel vers au moins une instance
- [ ] Outputs affichés (IPs publiques)
- [ ] hosts.ini généré

### Après TP3.2

- [ ] Playbook exécuté sans erreurs
- [ ] Nginx actif (systemctl status = active)
- [ ] Pages HTML accessibles (curl 200 OK)
- [ ] Health checks réussis

### Avant Nettoyage

- [ ] Logs de déploiement sauvegardés
- [ ] Screenshots capturées
- [ ] README.md documenté
- [ ] terraform destroy prêt

