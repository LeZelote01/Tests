# 🚀 Déploiement Vercel pour LeZelote-WebAI

## Configuration terminée ✅

Le projet LeZelote-WebAI est maintenant configuré pour Vercel avec :

- ✅ **Backend FastAPI** adapté pour Vercel Functions
- ✅ **Frontend React** optimisé pour Vercel
- ✅ **Base de données** configurée pour PostgreSQL
- ✅ **Variables d'environnement** organisées
- ✅ **Export de sites** fonctionnel sur Vercel

## 📋 Étapes de déploiement

### 1. Base de données PostgreSQL

**Option A - Supabase (Recommandé)**
```bash
# 1. Créer un projet sur https://supabase.com
# 2. Récupérer l'URL de connexion PostgreSQL
# 3. Copier l'URL dans DATABASE_URL
```

**Option B - PlanetScale**
```bash
# 1. Créer une base sur https://planetscale.com  
# 2. Récupérer l'URL de connexion
# 3. Configurer DATABASE_URL
```

**Option C - Neon**
```bash
# 1. Créer un projet sur https://neon.tech
# 2. Copier l'URL PostgreSQL
# 3. Mettre à jour DATABASE_URL
```

### 2. Déploiement sur Vercel

```bash
# Installation Vercel CLI
npm i -g vercel

# Login
vercel login

# Déploiement depuis le dossier /app
cd /app
vercel --prod
```

### 3. Variables d'environnement sur Vercel

**Via CLI :**
```bash
vercel env add DATABASE_URL
vercel env add SECRET_KEY  
vercel env add REACT_APP_BACKEND_URL
vercel env add REACT_APP_API_URL
```

**Via Dashboard :**
1. Allez sur https://vercel.com/dashboard
2. Sélectionnez votre projet
3. Settings > Environment Variables
4. Ajoutez toutes les variables de production

### 4. Variables requises

```bash
# Base de données
DATABASE_URL=postgresql://user:pass@host:port/db

# JWT (IMPORTANT: Changez cette clé)
SECRET_KEY=your-super-secure-production-key-32-chars-min

# Frontend  
REACT_APP_BACKEND_URL=https://your-project.vercel.app
REACT_APP_API_URL=https://your-project.vercel.app/api
REACT_APP_ENVIRONMENT=production

# Optionnel - OAuth
GOOGLE_CLIENT_ID=your-google-client-id
GITHUB_CLIENT_ID=your-github-client-id

# Optionnel - APIs externes (Phase 2)
OPENAI_API_KEY=your-openai-key
SENDGRID_API_KEY=your-sendgrid-key
```

## 🔧 Fonctionnalités adaptées pour Vercel

### ✅ Fonctionnalités disponibles
- **Authentification complète** (JWT, OAuth)
- **Génération de sites** (5 templates)
- **Éditeur visuel** (interface React)
- **Export de code** (HTML/CSS/JS)
- **Base de données** (PostgreSQL)
- **APIs RESTful** (FastAPI)

### ⚠️ Limitations Vercel
- **Hébergement intégré** : Remplacé par export + déploiement manuel
- **Stockage de fichiers** : Environnement serverless, pas de stockage persistant
- **Serveur dédié** : Pas de serveur sur port fixe

### 🚀 Solutions alternatives
- **Export de sites** : Téléchargement ZIP pour déploiement externe
- **Fichiers** : Utiliser Cloudinary/AWS S3 pour les uploads
- **Hébergement** : Guide pour déployer les sites exportés

## 📊 Architecture finale

```
Frontend (React) → Vercel Static Hosting
      ↓
Backend (FastAPI) → Vercel Functions (/api/*)
      ↓  
PostgreSQL → Supabase/PlanetScale/Neon
```

## 🧪 Test du déploiement

Après déploiement, testez :

1. **Homepage** : https://your-project.vercel.app
2. **API Health** : https://your-project.vercel.app/api/health
3. **Auth** : Inscription/connexion
4. **Templates** : Affichage des modèles
5. **Export** : Téléchargement de sites

## 🔍 Dépannage

**Erreur de base de données :**
```bash
# Vérifier la connexion PostgreSQL
# Vérifier que DATABASE_URL est bien configuré
```

**Erreur CORS :**
```bash
# Vérifier que REACT_APP_BACKEND_URL pointe vers le bon domaine
# Vérifier la configuration CORS dans server.py
```

**Erreur 500 :**
```bash
# Vérifier les logs Vercel Functions
# Vérifier que toutes les variables d'environnement sont configurées
```

## 📚 Resources

- [Documentation Vercel](https://vercel.com/docs)
- [FastAPI + Vercel](https://vercel.com/docs/functions/serverless-functions/runtimes/python)
- [React + Vercel](https://vercel.com/docs/concepts/deployments/build-step)
- [Supabase Setup](https://supabase.com/docs)

## 🎯 Prochaines étapes

Après déploiement réussi :

1. **Domaine personnalisé** : Configurer votre domaine
2. **Analytics** : Activer Vercel Analytics  
3. **Phase 2** : Intégrer les APIs IA (OpenAI, etc.)
4. **Optimisations** : Performance et SEO
5. **Monitoring** : Sentry pour les erreurs

---

**✅ Configuration Vercel terminée - Prêt pour le déploiement !**