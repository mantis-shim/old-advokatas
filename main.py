# KAD susikurt venv: į bash
#   python -m venv venv
#   .venv\Scripts\activate
#   pip install -r requirements.txt
# kad paleavint venv: deactivate

from flask import Flask, url_for, redirect, render_template, request, session, flash, jsonify, send_file
from flask_mail import Mail, Message
from config import ProductionConfig
from datetime import timedelta, datetime
import re, email_validator, bleach
from flask_caching import Cache
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, EmailField, PasswordField
from wtforms.validators import DataRequired, Email
from database import db_blueprint, cache_instance
from werkzeug.security import check_password_hash, generate_password_hash

app= Flask(__name__)
app.config.from_object(ProductionConfig)
cache = Cache(app)
app.register_blueprint(db_blueprint)
cache_instance.cache = cache
mail = Mail(app)
from database import queries
from database import models
from database import get_db_connection
from database import google_auth 
import base64
from pathlib import Path
import os


SITEMAP_FILE = "sitemap.xml"
### Raktas su kuriuo pasiraso sesijas
app.secret_key = app.config['SECRET_KEY']
###Laikas kiek saugomas admin prisijungimas
app.permanent_session_lifetime = timedelta(days=1)
###Inicijuoja visas sesijas kaip ne admin iki kol prisijungia
@app.before_request
def set_admin_default():
  if 'admin' not in session:
    session['admin'] = False
    session['loginAttempts'] = 0 ###Padaryti funkcionalu fail2ban



class ContactForm(FlaskForm):
  name=StringField("* Jūsų Vardas:", validators=[DataRequired()])
  last_name=StringField("* Jūsų Pavardė:", validators=[DataRequired()])
  phone_number=StringField("* Jūsų telefono numeris:")
  email= EmailField("* Jūsų el. paštas:", validators=[DataRequired(), Email()])
  message=TextAreaField("* Žinutė:", validators=[DataRequired()])
  submit=SubmitField("PATEIKTI")

admin_password_hash='scrypt:32768:8:1$az2qCFoP2X4gr7tm$f15f2db8311487a3d16b6f34b452ed0fe6aa6fcba8fa2ca2d9369d8a73bd94f0eaad9c31665fa8594f68d2f76514d3762ea9e97683d3bcacccfdc5a9e5364906'
class LoginForm(FlaskForm):
  password=PasswordField("Slaptažodis:", validators=[DataRequired()])
  submit=SubmitField("Prisijungti")


@app.errorhandler(404)
def not_found(error):
   return render_template("404.html")

@app.errorhandler(500)
def internal_server_error(error):
   return "Internal server error", 500


@app.route('/favicon.ico')
def favicon():
  return redirect(url_for('static', filename='images/favicon.ico'))

@app.route('/', methods=["POST", "GET"])
def home():
  form = ContactForm()
  articles_lawyer = queries.get_lawyer_articles()
  articles_info = queries.get_latest_info_articles()
  name=None
  last_name=None
  phone_number=None
  email=None
  message=None
  if form.validate_on_submit() and request.method=="POST":
    name=bleach.clean(form.name.data, tags=[], strip=True)
    last_name=bleach.clean(form.last_name.data, tags=[], strip=True)
    phone_number=bleach.clean(form.phone_number.data, tags=[], strip=True)
    email=bleach.clean(form.email.data, tags=[], strip=True)
    message=bleach.clean(form.message.data, tags=[], strip=True)
    regex_phone = r'^[+-]?[0-9]{9,11}$'
    if not (re.fullmatch(regex_phone, phone_number)):
      flash("Blogai įvėdėte telefono numerį!", "error")
      return redirect("/")
    try:
      msg = Message(
        subject='advokato tinklapis',
        sender=app.config['MAIL_USERNAME'],
        recipients=app.config['MAIL_FORM_RECIPIENTS'],
        body=name+ " " + last_name +"\n" + phone_number + "\n" + email + "\nŽinutė: " + message
      )
      mail.send(msg)
      flash("Sėkmingai išsiuntėte laišką!", "success")
      return redirect("/")
    except Exception as e:
      print(e)
      flash("Klaida siunčiant laišką. Bandykite dar kartą", "error")
      return redirect("/")
  elif (request.method == "GET"):
    return render_template("index.html", articles=articles_info, articles_l = articles_lawyer, form=form)
  else:
    flash("Klaida: Patikrinkite ar visi laukai užpildyti teisingai.", "error")
    return redirect("/")

@app.route('/straipsniai')
def articles():
  articles=queries.get_all_info_articles()
  return render_template("blog.html", articles=articles)

@app.route('/straipsniai/<id>')
def articleID(id):
  if not id.isdigit():
    return redirect(url_for("articles"))
  article=queries.get_article_info(id)
  if(article==None):
    return redirect(url_for("articles"))
  else:
    article.id=id
    return render_template("blogID.html", article=article)

@app.route('/editor', methods=["POST", "GET"])
def editor():
  if(session["admin"]==True):
    if request.method=="GET":
      return render_template("editor.html", article=models.Article())
  else:
    return redirect(url_for("home"))


@app.route('/paslaugos')
def services():
  return render_template("services.html")

@app.route('/admin', methods=[ "GET"]) # Removed POST from admin
def admin():
  if session['admin']== True:
    return redirect("/")
  form=LoginForm()

  # REMOVED LOGIN VIA PASSWORD ONLY GOOGLE LOGIN IS FUNCTIONAL

  # if request.method == "POST" and form.validate_on_submit():
  #   if( session['loginAttempts']>9): ### Silent Fail2ban
  #     print("BAD LOGIN F2B active: ", session['loginAttempts'])
  #     flash('Blogas slaptažodis.', "error")
  #     return render_template("login.html", form=form, GOOGLE_CLIENT_ID=app.config["GOOGLE_CLIENT_ID"])
  #   password=form.password.data
  #   if check_password_hash(admin_password_hash, password):
  #     session['loginAttempts']=0
  #     session.permanent=True
  #     session['admin']=True
  #     flash('Sėkmingai prisijungėte!', "success")
  #     return redirect(url_for("editor"))
  #   else:
  #     session['loginAttempts']+=1 ### Fail2ban
  #     print("BAD LOGIN: ", session['loginAttempts'])
  #     flash('Blogas slaptažodis.', "error")
  # elif request.method=="POST":
  #   session['loginAttempts']+=1 ### Fail2ban
  #   flash("Blogai įvedėte duomenis", "error")
  # return render_template("login.html", form=form, GOOGLE_CLIENT_ID=app.config["GOOGLE_CLIENT_ID"])
  return render_template("login.html", GOOGLE_CLIENT_ID=app.config["GOOGLE_CLIENT_ID"])
    
@app.route("/login/google", methods=["POST"])
def googleLogin():
  try:
    if(session['loginAttempts']>9): ### Fail2Ban gal istrint
      session.permanent=True
      return jsonify({"error": "YOU ARE BANNED."}), 403
    data = request.get_json()
    if not data or 'id_token' not in data:
        return jsonify({"error": "No ID Token provided in request body."}), 400
    id_token_from_frontend = data['id_token']
    google_client_id = app.config['GOOGLE_CLIENT_ID']

    response_data, status_code = google_auth.verify_google_id_token(id_token_from_frontend, google_client_id)
    if(status_code==200):
      print("Logged in:",response_data["user_data"]["email"])
      adminMails=app.config['ADMIN_MAILS']
      if(response_data["user_data"]["email"].lower() in adminMails ):
        session['loginAttempts']=0
        session.permanent=True
        session['admin']=True
      else:
        session['loginAttempts']+=1
        return jsonify({"error": "Jūsų Google paskyra neturi prieigos prie šio puslapio"}), 403
    else:
      session['loginAttempts']+=1
    return jsonify(response_data), status_code
  except:
    return jsonify({"error": "Unknown server error"}), 500

@app.route('/logout')
def logout():
  session.pop('admin') 
  return redirect(url_for("home"))



@app.route('/editor/<id>', methods=["POST", "GET"])
def editorArticleID(id):
  if(session['admin'] == True):
    article=queries.get_article_info_full(id)
    lawyerArticleCount=queries.check_lawyer_article_count
    return render_template("editor.html", article=article)
  else:
    return redirect(url_for("home"))


@app.route("/editor/submitArticle", methods=["POST","PUT"])
def submitArticle():
  session.modified = True
  try:
    data = request.get_json()
    if(data):
      articleHeader = data.get("articleHeader")
      articleContent = data.get("articleContent")
      articleDescription = data.get("articleDescription")
      articleType = data.get("articleType")
      submitDate = data.get("submitDate")
      articleID = data.get("articleID")
      if(data['articleImageData']):
        articleImageData = base64.b64decode(data['articleImageData'])
        image_dir = "static/images/articleImages"
        base_name, ext = os.path.splitext(data['articleImageName'])
        final_name = data['articleImageName']
        count = 1
        while os.path.exists(os.path.join(image_dir, final_name)): ### if file exists rewrite as file(count).ext
            final_name = f"{base_name}({count}){ext}"
            count += 1
        articleImageSource = os.path.join(image_dir, final_name)
      else:
        articleImageData = None
        articleImageSource = None
      print("ARTICLE DATA RECEIVED") 
    else:
      print("ERROR ARTICLE DATA FETCH INCORRECT") 
      return jsonify({'success': False}), 400

    if(request.method=="PUT"): ### Updating existing
      if(data['articleImageData']==None and data['articleImageName']=="default"): ### For reseting img to default
        print("Executing reset img to default")
        photosrc=queries.get_photosrc(articleID)
        if(photosrc):
          if os.path.exists(photosrc):
            os.remove(photosrc)
        articleImageSource = None
        queries.update_article(articleHeader,articleType,articleContent,articleDescription, articleID, articleImageSource)

      elif(articleImageSource != None): ### With uploaded image
        print("Executing setting image")
        with open(articleImageSource, 'wb') as f:
          f.write(articleImageData)
          queries.update_article(articleHeader,articleType,articleContent,articleDescription, articleID, articleImageSource)

      else: ### Without uploaded image
        print("Executing imageless put")
        queries.update_article_noimage(articleHeader,articleType,articleContent,articleDescription, articleID)
      print("ARTICLE UPDATED") 
      return jsonify({'success': True}), 200

    else: ### New article
      submitDate = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
      if(articleImageSource != None):
        with open(articleImageSource, 'wb') as f:
          f.write(articleImageData)
          queries.post_article(articleHeader,articleType,submitDate,articleContent,articleDescription, articleImageSource)
      else:
        queries.post_article_noimage(articleHeader,articleType,submitDate,articleContent,articleDescription)
      print("ARTICLE INSERTED") 
      return jsonify({'success': True}), 200

  except:
    print("ERROR INSERTING INTO DATABASE") 
    return jsonify({'success': False}), 400
    print("SUBMISSION OK")

    return jsonify({'success': True}), 200

@app.route("/editor/deleteArticle", methods=["DELETE"])
def deleteArticle():
  session.modified = True
  try:
    data = request.get_json()
    articleID=data.get("articleID")
    photosrc=queries.get_photosrc(articleID)
    if(photosrc):
      if os.path.exists(photosrc):
          os.remove(photosrc)
    queries.delete_article(articleID)
  except:
    return "ERROR DELETING ARTICLE", 400
  return "OK", 200

@app.route("/robots.txt", methods=["GET"])
def getRobots():
  return send_file("robots.txt")


def generate_sitemap():
  today = datetime.now().date().isoformat()
  urls = []

  # static pages
  urls.append(url_for('home', _external=True))
  urls.append(url_for('services', _external=True))
  urls.append(url_for('articles', _external=True))

  # dynamic pages (articles)
  articleIDs = []
  articleIDs = queries.get_list_of_article_ids()

  for aid in articleIDs:
    urls.append(url_for('articleID', id=aid, _external=True))

  # build XML
  xml = ['<?xml version="1.0" encoding="UTF-8"?>',
          '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">']
  for u in urls:
      xml.append(f"""
      <url>
          <loc>{u}</loc>
      </url>""")
  xml.append('</urlset>')

  # write file
  with open(SITEMAP_FILE, "w", encoding="utf-8") as f:
    f.write("\n".join(xml))


@app.route('/sitemap.xml', methods=["GET"])
def sitemap():
  # Sitemap generuojamas viena kart per diena jei yra užklausiama, kitu atveju grazinamas esamas failas
  if os.path.exists(SITEMAP_FILE):
      mtime = datetime.fromtimestamp(os.path.getmtime(SITEMAP_FILE))
      if (datetime.now() - mtime) < timedelta(days=1):
        return send_file(SITEMAP_FILE, mimetype="application/xml")

  generate_sitemap()
  return send_file(SITEMAP_FILE, mimetype="application/xml")


@app.route("/editor/getLawyerArticleCount", methods=["GET"])
def getLawyerArticleCount():
  return jsonify({'lawyerArticleCount' : queries.check_lawyer_article_count()})

if __name__ == '__main__':
  app.run(debug=False)
