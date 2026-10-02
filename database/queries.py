from flask_caching import Cache
from flask import current_app, flash, redirect, url_for
from . import get_db_connection
from .models import Article
from database.cache_instance import cache


def check_lawyer_article_count():
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT COUNT(id) FROM article WHERE type='lawyer';")
    data=cursor.fetchone()
    count: int = data[0]
    print("LAWYER ARTICLE COUNT: ", data[0])
    return count


def post_article(header, type, date, content, description, photosrc):
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("INSERT INTO article (name, type, date, html, description, photosrc) VALUES (%s, %s, %s, %s, %s, %s)", (header, type, date, content, description, photosrc))
    cache.clear()
    db.commit()
    cursor.close()
    db.close()

    return "Inserted", 200

def post_article_noimage(header, type, date, content, description):
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("INSERT INTO article (name, type, date, html, description) VALUES (%s, %s, %s, %s, %s)", (header, type, date, content, description))
    cache.clear()
    db.commit()
    cursor.close()
    db.close()

    return "Inserted", 200


@cache.cached(timeout=600, key_prefix="latest_articles")
def get_latest_info_articles():
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT id, name, date, description,photosrc FROM article WHERE type = 'info' ORDER BY date DESC LIMIT 3")
    rows = cursor.fetchall()
    articles = [Article(
        id= row[0], 
        header= row[1], 
        date= row[2].strftime("%Y-%m-%d"), 
        description= row[3], photosrc=row[4])
        for row in rows]
    return articles
  
@cache.cached(timeout=600, key_prefix="all_articles")
def get_all_info_articles():
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT id, name, date, description, photosrc FROM article WHERE type='info' ORDER BY date DESC")
    rows=cursor.fetchall()
    articles= [
      Article(
        id=row[0], header=row[1], date=row[2].strftime("%Y-%m-%d"), description=row[3], photosrc=row[4])
      for row in rows]
  return articles

@cache.cached(timeout=600, key_prefix="lawyer_articles")
def get_lawyer_articles():
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT id, name FROM article WHERE type='lawyer'")
    rows = cursor.fetchall()
    articles= [
      Article( id=row[0], header=row[1]) for row in rows]
  return articles


@cache.memoize(timeout=600)
def get_article_info(id):
  
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT name, date, html, description FROM article WHERE id=%s", (id,))
    data=cursor.fetchone()
    if data:
      return Article(header=data[0], date=data[1].strftime("%Y-%m-%d"), content=data[2], description=data[3])
    else:
      return print("ERROR")

def get_article_info_full(id):
  with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT name, date, html, description, type, photosrc FROM article WHERE id=%s;", (id,))
    data=cursor.fetchone()
    if data:
      return Article(header=data[0], date=data[1].strftime("%Y-%m-%d"), content=data[2], description=data[3], type=data[4], id=id, photosrc=data[5])
    else:
      return print("ERROR RETRIEVING FULL ARTICLE INFO")

def update_article(header, type, content, description, id, photosrc):
  with get_db_connection() as db, db.cursor() as cursor:
    try:
      cursor.execute("UPDATE article SET name=%s, type=%s, html=%s, description=%s, photosrc=%s WHERE id=%s;", (header, type, content, description, photosrc, id))

      cache.clear()
      db.commit()
      cursor.close()
      db.close()
    except:
      return print("ERROR UPDATING ARTICLE") 
    print("ARTICLE SUCCESSFULLY UPDATED") 
    return "Updated", "200"

def update_article_noimage(header, type, content, description, id, ):
  with get_db_connection() as db, db.cursor() as cursor:
    try:
      cursor.execute("UPDATE article SET name=%s, type=%s, html=%s, description=%s WHERE id=%s;", (header, type, content, description, id))

      cache.clear()
      db.commit()
      cursor.close()
      db.close()
    except:
      return print("ERROR UPDATING ARTICLE") 
    print("ARTICLE SUCCESSFULLY UPDATED") 
    return "Updated", "200"



def delete_article(articleID):
  with get_db_connection() as db, db.cursor() as cursor:
    try:
      cursor.execute("DELETE FROM article WHERE id=%s;", (str(articleID),))

      cache.clear()
      db.commit()
      cursor.close()
      db.close()
    except:
      return print("ERROR DELETING ARTICLE") 
    print("ARTICLE SUCCESSFULLY DELETED") 
    return "DELETED", "200"

    
def get_photosrc(id):
   with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT photosrc FROM article WHERE id=%s;", (id,))
    data=cursor.fetchone()
    cursor.close()
    db.close()
    
    if data:
      return data[0]
    else:
      return None, print("ERROR RETRIEVING FULL ARTICLE INFO")

def get_list_of_article_ids():
   with get_db_connection() as db, db.cursor() as cursor:
    cursor.execute("SELECT id FROM article")
    data_unfiltered=cursor.fetchall()
    cursor.close()
    db.close()
    
    if data_unfiltered: # fetchal grazina tuple, reik konvertuoti i gryna id
      data = [row[0] for row in data_unfiltered]
      return data
    else:
      return None, print("ERROR RETRIEVING ARTICLE IDS")
