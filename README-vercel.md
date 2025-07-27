# Configuration Vercel pour LeZelote-WebAI

## Variables d'environnement à configurer sur Vercel

### Production
```bash
# Frontend
REACT_APP_BACKEND_URL=https://votre-domain.vercel.app
REACT_APP_API_URL=https://votre-domain.vercel.app/api
REACT_APP_APP_NAME="AI Website Generator"
REACT_APP_VERSION=1.0.0
REACT_APP_ENVIRONMENT=production

# Backend - Base de données PostgreSQL
DATABASE_URL=postgresql://username:password@host:port/database

# JWT Configuration
SECRET_KEY=your-super-secure-secret-key-here-change-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# API Configuration
PROJECT_NAME="AI Website Generator"
BACKEND_CORS_ORIGINS=["https://votre-domain.vercel.app"]
ENVIRONMENT=production
DEBUG=False

# OAuth2 Configuration (optionnel)
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
GITHUB_CLIENT_ID=your-github-client-id
GITHUB_CLIENT_SECRET=your-github-client-secret

# External APIs (Phase 2)
OPENAI_API_KEY=your-openai-api-key
ANTHROPIC_API_KEY=your-anthropic-api-key
SENDGRID_API_KEY=your-sendgrid-api-key
```

## Base de données recommandée

Pour un déploiement sur Vercel, nous recommandons :

1. **Supabase** (PostgreSQL gratuit) - https://supabase.com
2. **PlanetScale** (MySQL serverless) - https://planetscale.com  
3. **Neon** (PostgreSQL serverless) - https://neon.tech

## Configuration Supabase (Recommandé)

1. Créer un projet sur https://supabase.com
2. Récupérer l'URL de connexion PostgreSQL
3. Exporter le schéma existant et l'importer
4. Configurer les variables d'environnement

## Commandes de déploiement

```bash
# Installation Vercel CLI
npm i -g vercel

# Login
vercel login

# Déploiement
vercel --prod

# Configuration des variables d'environnement
vercel env add REACT_APP_BACKEND_URL
vercel env add DATABASE_URL
vercel env add SECRET_KEY
```

## Structure des dossiers pour Vercel

```
/
├── frontend/          # React app
├── backend/           # FastAPI (adapté pour Vercel Functions)
├── vercel.json        # Configuration Vercel
└── README-vercel.md   # Ce fichier
```