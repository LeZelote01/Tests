# Schema SQL pour PostgreSQL
# Exécutez ces commandes dans votre base PostgreSQL (Supabase/PlanetScale/Neon)

-- Créer l'extension UUID si nécessaire (Supabase l'a par défaut)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table des utilisateurs
CREATE TABLE users (
    id VARCHAR PRIMARY KEY DEFAULT gen_random_uuid()::text,
    email VARCHAR UNIQUE NOT NULL,
    username VARCHAR UNIQUE NOT NULL,
    full_name VARCHAR,
    hashed_password VARCHAR NOT NULL,
    is_active BOOLEAN DEFAULT true,
    is_verified BOOLEAN DEFAULT false,
    
    -- OAuth fields
    google_id VARCHAR UNIQUE,
    github_id VARCHAR UNIQUE,
    
    -- Profile information
    avatar_url VARCHAR,
    bio TEXT,
    
    -- Subscription info
    subscription_plan VARCHAR DEFAULT 'free',
    subscription_status VARCHAR DEFAULT 'active',
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    last_login TIMESTAMP
);

-- Table des templates
CREATE TABLE templates (
    id VARCHAR PRIMARY KEY DEFAULT gen_random_uuid()::text,
    name VARCHAR NOT NULL,
    slug VARCHAR UNIQUE NOT NULL,
    description TEXT,
    category VARCHAR NOT NULL,
    
    -- Template content
    structure JSONB NOT NULL,
    default_content JSONB,
    preview_image VARCHAR,
    
    -- Template metadata
    is_premium BOOLEAN DEFAULT false,
    price INTEGER DEFAULT 0,
    tags JSONB,
    
    -- Statistics
    usage_count INTEGER DEFAULT 0,
    rating_avg INTEGER DEFAULT 5,
    rating_count INTEGER DEFAULT 0,
    
    -- Status
    creator_id VARCHAR REFERENCES users(id),
    is_active BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Table des sites web
CREATE TABLE websites (
    id VARCHAR PRIMARY KEY DEFAULT gen_random_uuid()::text,
    name VARCHAR NOT NULL,
    slug VARCHAR UNIQUE NOT NULL,
    description TEXT,
    
    -- Website content
    template_id VARCHAR REFERENCES templates(id),
    content JSONB,
    settings JSONB,
    custom_css TEXT,
    custom_js TEXT,
    
    -- Status
    status VARCHAR DEFAULT 'draft',
    is_public BOOLEAN DEFAULT false,
    domain VARCHAR,
    
    -- Hébergement (adapté pour Vercel)
    is_hosted BOOLEAN DEFAULT false,
    hosting_subdomain VARCHAR,
    hosting_url VARCHAR,
    ssl_enabled BOOLEAN DEFAULT true,
    deployed_at TIMESTAMP,
    
    -- SEO
    meta_title VARCHAR,
    meta_description TEXT,
    meta_keywords VARCHAR,
    
    -- Analytics
    view_count INTEGER DEFAULT 0,
    last_published TIMESTAMP,
    
    -- Ownership
    owner_id VARCHAR NOT NULL REFERENCES users(id),
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Table des clés API (Phase 2)
CREATE TABLE api_keys (
    id VARCHAR PRIMARY KEY DEFAULT gen_random_uuid()::text,
    user_id VARCHAR NOT NULL REFERENCES users(id),
    service VARCHAR NOT NULL,
    key_name VARCHAR NOT NULL,
    encrypted_key VARCHAR NOT NULL,
    is_active BOOLEAN DEFAULT true,
    
    -- Usage tracking
    usage_count INTEGER DEFAULT 0,
    last_used TIMESTAMP,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Table d'historique de génération (Phase 2)
CREATE TABLE generation_history (
    id VARCHAR PRIMARY KEY DEFAULT gen_random_uuid()::text,
    user_id VARCHAR NOT NULL REFERENCES users(id),
    website_id VARCHAR REFERENCES websites(id),
    
    generation_type VARCHAR NOT NULL,
    prompt TEXT NOT NULL,
    result JSONB,
    
    -- AI Service info
    ai_service VARCHAR NOT NULL,
    model_used VARCHAR,
    tokens_used INTEGER,
    cost INTEGER,
    
    -- Quality metrics
    user_rating INTEGER,
    was_used BOOLEAN DEFAULT false,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW()
);

-- Index pour les performances
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_websites_owner ON websites(owner_id);
CREATE INDEX idx_websites_slug ON websites(slug);
CREATE INDEX idx_templates_category ON templates(category);
CREATE INDEX idx_templates_is_active ON templates(is_active);

-- Insérer les templates par défaut
INSERT INTO templates (name, slug, description, category, structure, default_content, is_active, is_featured) VALUES 
('Portfolio Moderne', 'portfolio-moderne', 'Template portfolio professionnel et moderne', 'portfolio', 
 '{"sections": ["hero", "about", "portfolio", "contact"], "layout": "modern"}',
 '{"hero": {"title": "Mon Portfolio", "subtitle": "Développeur Web", "description": "Passionné par la création d''expériences web exceptionnelles"}, "about": {"title": "À propos", "content": "Je suis un développeur web avec une passion pour les technologies modernes..."}}',
 true, true),

('Site d''Entreprise', 'site-entreprise', 'Template professionnel pour entreprises', 'business',
 '{"sections": ["hero", "services", "about", "contact"], "layout": "corporate"}',
 '{"hero": {"title": "Notre Entreprise", "subtitle": "Excellence & Innovation", "description": "Nous proposons des solutions professionnelles adaptées à vos besoins"}, "about": {"title": "À propos", "content": "Notre entreprise accompagne ses clients depuis plus de 10 ans..."}}',
 true, true),

('Blog Personnel', 'blog-personnel', 'Template pour blog personnel ou professionnel', 'blog',
 '{"sections": ["hero", "posts", "about"], "layout": "blog"}',
 '{"hero": {"title": "Mon Blog", "subtitle": "Mes réflexions et découvertes", "description": "Bienvenue sur mon blog où je partage mes expériences et connaissances"}, "about": {"title": "À propos", "content": "Passionné par l''écriture et le partage de connaissances..."}}',
 true, false),

('Landing Page', 'landing-page', 'Page d''atterrissage optimisée pour la conversion', 'landing',
 '{"sections": ["hero", "features", "pricing", "cta"], "layout": "landing"}',
 '{"hero": {"title": "Votre Solution", "subtitle": "Simple, Rapide, Efficace", "description": "Découvrez notre solution innovante qui va transformer votre activité"}, "features": {"title": "Fonctionnalités"}}',
 true, true),

('E-commerce Simple', 'ecommerce-simple', 'Template e-commerce basique avec catalogue produits', 'ecommerce',
 '{"sections": ["hero", "products", "about", "contact"], "layout": "shop"}',
 '{"hero": {"title": "Notre Boutique", "subtitle": "Produits de qualité", "description": "Découvrez notre sélection de produits soigneusement choisis"}, "about": {"title": "À propos", "content": "Notre boutique propose des produits de qualité..."}}',
 true, false);

-- Message de confirmation
-- SELECT 'Base de données PostgreSQL configurée avec succès pour LeZelote-WebAI' as status;