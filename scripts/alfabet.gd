extends Node2D

#fazer regras de espaçamento - x_gap variável
@onready var letter = preload("res://scenes/alfabet/alfabet_letter.tscn")
var gap := 34
var y_gap := 60
var wrap_limit := 10
var wrap_y_limit = 10

var text := ''

func write():
	text = text.replace('? ', '?')
	text = text.replace('! ', '!')
	text = text.replace('. ', '.')
	text = text.replace(', ', ',')
	var palavras = text.split(' ')
	var line_index := 0
	var column_index := 0
	
	for i in range(palavras.size()):
		var palavra = palavras[i]
		if palavra.length() > wrap_limit:
			palavras.remove_at(i)
			var partes = []
			while palavra.length() > wrap_limit:
				partes.append(palavra.substr(0, wrap_limit))
				palavra = palavra.substr(wrap_limit)
			if palavra != '':
				partes.append(palavra)
			for j in range(partes.size()):
				palavras.insert(i + j, partes[j])

	for palavra in palavras:
		if column_index + palavra.length() > wrap_limit:
			line_index += 1
			column_index = 0
		for caracter in palavra:
			print_letter(caracter, Vector2(column_index * gap, line_index * y_gap))
			column_index += 1
		column_index += 1



func print_letter(caractere, pos: Vector2):
	var new_letter = letter.instantiate()
	new_letter.global_position = pos
	new_letter.display = caractere
	add_child(new_letter)


func _ready() -> void:
	write()


func reload():
	for i in get_children():
		i.queue_free()
	write()
