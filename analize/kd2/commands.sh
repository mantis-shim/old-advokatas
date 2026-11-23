# KD2 3.3 and 3.4 commands. Git Bash, repo root, copy-paste one line at a time.
. venv/Scripts/activate
mkdir -p ./analize/kd2/results


# ===== 3.3 Saugumas: autentiskumas =====

# TA1 Bandit
bandit -r main.py config.py database/ | tee ./analize/kd2/results/bandit.txt

# TA2 curl without login. Start MySQL in the XAMPP Control Panel, then in a second terminal:
. venv/Scripts/activate
python main.py

curl -i http://127.0.0.1:5000/editor
curl -i -X POST http://127.0.0.1:5000/editor/submitArticle -H "Content-Type: application/json" -d '{"articleHeader":"KD2 curl testas","articleContent":"<p>Sukurta be prisijungimo</p>","articleDescription":"curl testas","articleType":"info","articleImageData":null,"articleImageName":null}'
# 71 = id of the article just created (first link on /straipsniai)
curl -s http://127.0.0.1:5000/straipsniai/71 | grep -o "KD2 curl testas"
curl -i -X PUT http://127.0.0.1:5000/editor/submitArticle -H "Content-Type: application/json" -d '{"articleID":"71","articleHeader":"KD2 curl testas PAKEISTA","articleContent":"<p>Pakeista be prisijungimo</p>","articleDescription":"curl testas","articleType":"info","articleImageData":null,"articleImageName":null}'
curl -s http://127.0.0.1:5000/straipsniai/71 | grep -o "KD2 curl testas PAKEISTA"
curl -i -X DELETE http://127.0.0.1:5000/editor/deleteArticle -H "Content-Type: application/json" -d '{"articleID":"71"}'
curl -i http://127.0.0.1:5000/straipsniai/71


# ===== 3.4 Palaikomumas: modifikuojamumas =====
# TA1 
radon mi -s main.py config.py database/ | tee ./analize/kd2/results/radon-mi.txt
radon cc -s main.py | tee ./analize/kd2/results/radon-cc.txt
radon raw main.py | tee ./analize/kd2/results/radon-raw.txt
radon hal database/queries.py

# TODO TA2 after refactoring submitArticle in main.py 
radon mi -s main.py config.py database/ | tee ./analize/kd2/results/radon-mi-refactor.txt
radon cc -s main.py | tee ./analize/kd2/results/radon-cc-refactor.txt

