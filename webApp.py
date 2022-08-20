from flask import Flask, request, render_template
import sqlite3

app = Flask(__name__, template_folder='.')

@app.route('/')
def index():
	return render_template('index.html')


@app.route("/api/getAll")
def db():
	datenbank = sqlite3.connect("datenbank.db")
	cursor = datenbank.cursor()
	res = cursor.execute("SELECT * FROM toDoList")
	#print(res.fetchone()
	return res.fetchall()


@app.route('/api/modify', methods = ['POST'])
def modify():
	data = request.json
	datenbank = sqlite3.connect("datenbank.db")
	cursor = datenbank.cursor()
	print("UPDATE toDoList SET Erledigt = \"" + str(data["Erledigt"]) + "\" where ID = " + str(data["ID"]))
	cursor.execute("UPDATE toDoList SET Erledigt = \"" + str(data["Erledigt"]) + "\" where ID = " + str(data["ID"]))
	datenbank.commit()
	return "OK"

@app.route('/api/create', methods = ['POST'])
def create():
	data = request.json
	datenbank = sqlite3.connect("datenbank.db")
	cursor = datenbank.cursor()
	cursor.execute("INSERT INTO toDoList (\"Aufgabe\",\"Erledigt\") VALUES(\"" + data["Aufgabe"] + "\",0)")
	datenbank.commit()
	return "OK"

@app.route('/api/delete', methods = ['DELETE'])
def delete():
	data = request.json
	datenbank = sqlite3.connect("datenbank.db")
	cursor = datenbank.cursor()
	cursor.execute("DELETE FROM toDoList where ID = " + str(data["ID"]))
	datenbank.commit()
	return "OK"