"""
Configuration Vercel pour FastAPI
Ce fichier adapte le serveur FastAPI pour fonctionner avec Vercel Functions
"""
import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from mangum import Mangum

# Import the main app from server.py
from server import app

# Configure CORS for Vercel
origins = [
    "https://lezelote-webai.vercel.app",
    "https://*.vercel.app",
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

# Update CORS origins for production
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Create handler for Vercel
handler = Mangum(app)

# For Vercel, we need to export the handler
def api_handler(request, context):
    return handler(request, context)