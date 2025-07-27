"""
Point d'entrée pour l'API Vercel
Ce fichier route toutes les requêtes API vers le serveur FastAPI
"""
import sys
import os

# Ajouter le dossier backend au path
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'backend'))

from mangum import Mangum
from server import app

# Créer le handler Vercel
handler = Mangum(app, lifespan="off")

def api_handler(request, context=None):
    """Handler principal pour les fonctions Vercel"""
    return handler(request, context)