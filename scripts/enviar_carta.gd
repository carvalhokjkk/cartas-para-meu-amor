extends buttons


func _ready() -> void:
	hide()
	set_configs()

func _on_on_pressed() -> void:
	print($"../paper/alfabet".text)
	$"../paper/alfabet".text = ''
	$"../teclado".value = ''
	$"../teclado_anim".play_backwards("in")
	$"../paper".play("close")
	$"../paper/alfabet".hide()
	$"../envelope_anim".play('in')
	hide()
	await $"../envelope_anim".animation_finished
	$"../paper".hide()
	$"../envelope".play("letter_in")
	await $"../envelope".animation_finished
	$"../envelope".play("close")
	$"../envelope_anim".play("out")
	await $"../envelope_anim".animation_finished
	$"../escrever_button".show()
	$"../../nocards/mensagem".show()

func _on_teclado_update(value: String) -> void:
	$"../paper/alfabet".show()
	if value.length() > 0:
		show()
	if value.length() == 0:
		hide()
