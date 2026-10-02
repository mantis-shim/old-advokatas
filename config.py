import json
import os
from dotenv import load_dotenv

load_dotenv()
class Config:
    # SERVER_NAME = '' setinus tuscia buginasi nuorodos
    SECRET_KEY = os.getenv('SECRET_KEY')
    CACHE_TYPE = 'SimpleCache'

    DB_HOST = os.getenv("DB_HOST")
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = os.getenv('DB_PASSWORD')
    DB_NAME = os.getenv("DB_NAME")

    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
    MAIL_FORM_RECIPIENTS = ['danigint2@gmail.com']
    MAIL_USERNAME = 'fouraflow.mailer@gmail.com'
    MAIL_PASSWORD = os.getenv('MAIL_PASSWORD')
    ### ADMIN_MAILS - gmail paskyros, kurios gali prisijungti prie svetaines
    ADMIN_MAILS = ["vincentas.skolevicius@gmail.com","mantassimaitis37@gmail.com","danigint2@gmail.com"]
    ### Client ID nera privatus ir matomas js UI, bet del tvarkos sedi .env
    GOOGLE_CLIENT_ID = os.getenv('GOOGLE_CLIENT_ID')
    GOOGLE_CLIENT_SECRET = os.getenv('GOOGLE_CLIENT_SECRET')

class DevelopmentConfig(Config):
    DEBUG=True

class ProductionConfig(Config):
    DEBUG=False
