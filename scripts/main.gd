extends Node2D

#sistema de login
#subir servidor
#

var cartas := []

signal end_get_cards

func _ready() -> void:
	update_hud()
	if Global.user == '':
		return
	await get_cards()
	update_hud()
	load_carta()

func get_cards():
	$requests.listar_cartas()
	await $requests.request_end
	cartas = $requests.cartas
	cartas = cartas.filter(func(carta): return !carta['emissario'] == Global.user)
	emit_signal('end_get_cards')


func load_carta():
	if cartas.is_empty() or Global.user == '':
		return
	$cards.load_carta(cartas[0]['texto'])
	$requests.deletar_carta(int(cartas[0]['id']))
	cartas.remove_at(0)


func update_hud():
	if Global.user == '':
		$login.show()
		$cards.hide()
		$digitar.hide()
		$nocards/mensagem.hide()
		return
	else:
		$login.hide()
	if cartas.is_empty():
		$cards.hide()
		$digitar.show()
		$nocards/mensagem.show()
		
	else:
		$cards.show()
		$digitar.hide()
		$nocards/mensagem.hide()



func _on_update_timer_timeout() -> void:
	if $nocards/mensagem.visible == false:
		return
	await get_cards()
	update_hud()
	load_carta()


func _on_card_on_close() -> void:
	await get_cards()
	if cartas.is_empty():
		await get_tree().create_timer(.5).timeout
	update_hud()
	load_carta()
