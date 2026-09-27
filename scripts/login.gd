extends Node2D

var editing := 'user'

var username_value := ''

var password_value := ''
var password_hide := ''
var teclado_on := false

func _ready() -> void:
	$username/value.text = ''
	$password/value.text = ''
	$username/value.reload()
	$password/value.reload()
	$username/bar.hide()
	$password/bar.hide()

func show_teclado():
	if teclado_on:
		return
	teclado_on = true
	$teclado_anim.play("in")

func hide_teclado():
	if !teclado_on:
		return
	teclado_on = false
	$teclado_anim.play_backwards("in")

func _on_username_range_on_pressed() -> void:
	editing = 'user'
	$teclado.value = username_value
	$username/bar.show()
	$password/bar.hide()
	show_teclado()

func _on_password_range_on_pressed() -> void:
	editing = 'password'
	$teclado.value = password_value
	$username/bar.hide()
	$password/bar.show()
	show_teclado()

func _on_teclado_update(value: String) -> void:
	match editing:
		'user':
			username_value = value
		'password':
			password_hide = ''
			password_value = value
			for i in value.length():
				password_hide += '.'
	$username/value.text = username_value
	$password/value.text = password_hide
	$username/value.reload()
	$password/value.reload()


func _on_buttons_on_pressed() -> void:
	$"../requests".login(username_value, password_value)
	hide_teclado()


func _on_requests_login_end(dados) -> void:
	if dados['erro'] == 'OK':
		Global.user = dados['usuario']
		await get_tree().create_timer(.5).timeout
		get_parent().update_hud()
	else:
		print(dados['erro'])
