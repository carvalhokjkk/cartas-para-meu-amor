extends Node2D

var value := ''
signal update

func _ready() -> void:
	for coluna in get_children():
		for tecla in coluna.get_children():
			if !tecla.name.contains('tecla'):
				return
			tecla.pressed.connect(digitar)

func digitar(valor, valido: bool):
	if valido:
		if valor == 'back':
			value = value.substr(0, value.length() - 1)
			update.emit(value)
			return
		value += valor
		update.emit(value)
