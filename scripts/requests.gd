extends Node

var http := HTTPRequest.new()

var url := 'http://192.168.1.101:5000'
var url_cartas := url + "/cartas"
var url_login := url + "/login"

var cartas = []

signal request_end

func _ready():
	add_child(http)
	http.request_completed.connect(_on_request_completed)

func enviar_carta(texto: String, emissario: String):
	var dados = {
		"texto": texto,
		"emissario": emissario
	}
	http.request(
		url_cartas,
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(dados)
	)

func listar_cartas():
	http.request(
		url_cartas,
		[],
		HTTPClient.METHOD_GET
	)

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200 and response_code != 201:
		return
	var dados = JSON.parse_string(body.get_string_from_utf8())
	cartas = dados
	request_end.emit()

func _on_enviar_button_enviada(content) -> void:
	enviar_carta(content, Global.user)

func deletar_carta(id):
	http.request(
		url_cartas + "/" + str(id),
		[],
		HTTPClient.METHOD_DELETE
	)


func login(user, password):
	var request = HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(login_complete)
	request.request(
		url_login + "?user=" + user.uri_encode() +"&senha=" + password.uri_encode(),
		[],
		HTTPClient.METHOD_GET,
	)

signal login_end
func login_complete(result, response_code, headers, body):
	if response_code != 200 and response_code != 201:
		return
	var dados = JSON.parse_string(body.get_string_from_utf8())
	login_end.emit(dados)
