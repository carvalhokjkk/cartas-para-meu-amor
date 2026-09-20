extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('mouse_click'):
		spawn_effect()




func spawn_effect():
	var mouse_pos := get_global_mouse_position() 
	var new_effect = preload('res://vfx/heart_click.tscn').instantiate()
	new_effect.global_position = mouse_pos
	add_child(new_effect)
