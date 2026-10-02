from flask import Blueprint, current_app
import mysql.connector


db_blueprint = Blueprint('db', __name__)

def get_db_connection ():
  conn=mysql.connector.connect(
    host=current_app.config['DB_HOST'],
    user=current_app.config['DB_USER'],
    password=current_app.config['DB_PASSWORD'],
    database=current_app.config['DB_NAME']
  )
  return conn
