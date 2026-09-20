extends Node2D

@onready var card := $card as AnimatedSprite2D
@onready var close_button := $close_button

signal card_loaded

func _ready() -> void:
	close_button.hide()




func load_carta(content: String):
	$card.content = content
	$card.update()
	$anim.play("card_in")
	await $anim.animation_finished
	emit_signal('card_loaded')




func _on_close_button_on_pressed() -> void:
	$anim.play("card_out")
	card.close()
	await get_tree().create_timer(.15).timeout
	close_button.hide()

func _on_card_on_open() -> void:
	close_button.show()
