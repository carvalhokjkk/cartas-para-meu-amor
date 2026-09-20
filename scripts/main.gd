extends Node2D

var cartas = ['teste', 'segunda carta']

func _ready() -> void:
	get_cards()
	update_hud()
	load_carta()

func get_cards():
	pass


func load_carta():
	if cartas.is_empty():
		return
	$cards.load_carta(cartas[0])
	cartas.remove_at(0)




func update_hud():
	if cartas.is_empty():
		$cards.hide()
		$digitar.show()
		$nocards.show()
	else:
		$cards.show()
		$digitar.hide()
		$nocards.hide()



func _on_update_timer_timeout() -> void:
	pass


func _on_card_on_close() -> void:
	get_cards()
	if cartas.is_empty():
		await get_tree().create_timer(.5).timeout
	update_hud()
	load_carta()
