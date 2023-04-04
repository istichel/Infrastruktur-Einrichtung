from bottle import *
import subprocess


@get('/projekt/<name>')
def get_index(name):
    return template('index.tpl', p=name)

@post('/action')
def post_action():
	action = request.params.action
	projekt = request.params.projekt
	ergebnis = 'nohup bash /root/' + projekt + '.sh ' + action + ' ' + projekt
	subprocess.Popen(ergebnis.split())
	return template('index.tpl', p=projekt)


run(host='localhost', port=79)

