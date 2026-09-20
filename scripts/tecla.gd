extends Node2D

@export var letter := true
@export var value = 'A'
@export var input := true

signal pressed

@export var scale_anim := Vector2(1.8, 1.8)

func _ready() -> void:
	if letter:
		$"alfabet-letter".display = value
		$"alfabet-letter".reload()

func anim_in():
	var tween := create_tween()
	tween.tween_property(self, 'scale', scale_anim, 0.05)

func anim_out():
	var tween := create_tween()
	tween.tween_property(self, 'scale', Vector2(1.0, 1.0), 0.1)


func _on_button_button_down() -> void:
	anim_in()


func _on_button_button_up() -> void:
	anim_out()


func _on_button_pressed() -> void:
	pressed.emit(value, input)
