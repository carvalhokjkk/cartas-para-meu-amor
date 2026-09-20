extends Control
class_name buttons

var mouse_in := false

signal on_hover
signal on_hover_out
signal on_pressed
signal on_released

@export var anim := true
@export var texture: Node2D

@onready var default_scale := texture.scale if texture else Vector2(0, 0)

func _ready() -> void:
	set_configs()


func set_configs():
	offset_transform_enabled = true
	offset_transform_pivot_ratio = Vector2(0, 0)
	connect('mouse_entered', hover)
	connect('mouse_exited', hoverOut)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('mouse_click') && mouse_in:
		pressed()
	elif event.is_action_released('mouse_click') && mouse_in:
		released()




func hover():
	mouse_in = true
	emit_signal('on_hover')
	if anim:
		anim_in()

func hoverOut():
	mouse_in = false
	emit_signal('on_hover_out')
	released()
	anim_out()

func pressed():
	if anim:
		anim_click()
	emit_signal('on_pressed')

func released():
	if mouse_in:
		anim_click_out()
	else:
		anim_out()
	emit_signal('on_released')


func anim_in():
	if !texture:
		return
	var tween = create_tween()
	tween.tween_property(texture, 'scale', default_scale + Vector2(.2, .2), 0.1)
	tween.tween_callback(
		func(): tween.kill()
	)

func anim_click():
	if !texture:
		return
	var tween = create_tween()
	tween.tween_property(texture, 'scale', default_scale + Vector2(.4, .4), 0.1)
	tween.tween_callback(
		func(): tween.kill()
	)

func anim_click_out():
	if !texture:
		return
	var tween = create_tween()
	tween.tween_property(texture, 'scale', default_scale + Vector2(.2, .2), 0.1)
	tween.tween_callback(
		func(): tween.kill()
	)


func anim_out():
	if !texture:
		return
	var tween = create_tween()
	tween.tween_property(texture, 'scale', default_scale, 0.1)
	tween.tween_callback(
		func(): tween.kill()
	)
