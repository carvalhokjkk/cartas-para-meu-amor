extends AnimatedSprite2D

@onready var paper = $paper as AnimatedSprite2D
@export var content = ''
var mouse_in := false
var opened := false

signal on_open
signal on_close

func _ready() -> void:
	play("love3")

func _input(event: InputEvent) -> void:
	if event.is_action_released("mouse_click") && mouse_in:
		get_viewport().set_input_as_handled()
		if !opened:
			open()


func _on_box_mouse_entered() -> void:
	mouse_in = true
	hover_in()
func _on_box_mouse_exited() -> void:
	mouse_in = false
	hover_out()

func open():
	if animation.contains('open'):
		return
	opened = true
	animation = animation + 'open'
	play(animation)
	await animation_finished
	animation = animation + 'static'
	play(animation)
	emit_signal('on_open')



func close():
	await paper.close()
	opened = false
	animation = animation.replace('static', '')
	play_backwards(animation)
	await get_tree().create_timer(0.2).timeout
	animation = animation.replace('open', '')
	play_backwards(animation)
	emit_signal('on_close')

func hover_in():
	var tween = create_tween()
	tween.tween_property(self, 'scale', Vector2(1.05, 1.05), 0.15)
	tween.tween_callback(func(): tween.kill())

func hover_out():
	var tween = create_tween()
	if !opened:
		tween.tween_property(self, 'scale', Vector2(1, 1), 0.1)
		tween.tween_callback(func(): tween.kill())


func _on_animation_finished() -> void:
	if animation.contains('open'):
		paper.open()


func update():
	$paper/alfabet.text = content
	$paper/alfabet.reload()
