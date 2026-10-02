from flask import request, jsonify 
from google.oauth2 import id_token
from google.auth.transport import requests


def verify_google_id_token(id_token_string, client_id):
  try:
    payload = id_token.verify_oauth2_token( ### is front-end priemam auth tokena ir verifyinam
        id_token_string, 
        requests.Request(), 
        client_id 
    )

    user_id = payload['sub']
    user_email = payload.get('email')
    user_name = payload.get('name')
    
    print(f"Successfully verified ID Token for user: {user_email} (ID: {user_id})")

    return {
        "message": "ID Token verified successfully!",
        "user_data": {
            "google_id": user_id,
            "email": user_email,
            "name": user_name,
        }
    }, 200
  except ValueError as e:
    print(f"ID Token verification failed: {e}")
    return {"error": f"Invalid ID Token: {e}"}, 401
  except Exception as e:
    print(f"An unexpected error occurred: {e}")
    return {"error": f"An unexpected server error occurred: {e}"}, 500
