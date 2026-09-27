extends AnimatedSprite2D

var value := ''
@onready var initial_pos = position

func _process(_delta: float) -> void:
	value = $"../value".text
	position.x = initial_pos.x + (36 * value.length())
