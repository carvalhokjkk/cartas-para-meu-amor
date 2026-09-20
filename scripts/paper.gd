extends AnimatedSprite2D

signal close_end

func _ready() -> void:
	hide()
	$alfabet.hide()


func open():
	show()
	play("open")
	await animation_finished
	play("default")
	$alfabet.show()

func close():
	$alfabet.hide()
	play_backwards("open")
	await get_tree().create_timer(.25).timeout
	hide()
	emit_signal('close_end')
