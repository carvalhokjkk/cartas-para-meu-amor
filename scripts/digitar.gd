extends Node2D


func _on_teclado_update(valor) -> void:
	$paper/alfabet.text = valor
	$paper/alfabet.reload()
