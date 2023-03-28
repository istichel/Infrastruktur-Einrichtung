from bottle import *
import os

@get('/projekt/<name>')
def get_index(name):
    return template('index.tpl', p=name)

@post('/action')
def post_action():
	action = request.params.action
	projekt = request.params.projekt
	ergebnis = 'bash /root/' + projekt + '.sh ' + action + ' ' + projekt
	print(ergebnis)
	os.system(ergebnis)
	return template('index.tpl', p=projekt)


run(host='localhost', port=79)

