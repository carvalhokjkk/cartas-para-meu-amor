extends AnimatedSprite2D

@export var textureassa: AtlasTexture
@onready var image := preload('res://assets/afabet/alfabet_spritesheet.png')
var letters := [
	'A',
	'a',
	'B',
	'b',
	'C',
	'c',
	'D',
	'd',
	'E',
	'e',
	'F',
	'f',
	'G',
	'g',
	'H',
	'h',
	'I',
	'i',
	'J',
	'j',
	'K',
	'k',
	'L',
	'l',
	'M',
	'm',
	'N',
	'n',
	'O',
	'o',
	'P',
	'p',
	'Q',
	'q',
	'R',
	'r',
	'S',
	's',
	'T',
	't',
	'U',
	'u',
	'V',
	'v',
	'W',
	'w',
	'X',
	'x',
	'Y',
	'y',
	'Z',
	'z',
	'.',
	',',
	'!',
	'?',
]

@export var display = '!'

func _ready() -> void:
	var new_sprite_frames = SpriteFrames.new()
	for i in letters.size():
		new_sprite_frames.add_animation(StringName(letters[i]))
		for j in 4:
			var texture = AtlasTexture.new()
			texture.atlas = image
			texture.region = Rect2(j * 64, i * 64, 64, 64)
			new_sprite_frames.add_frame(StringName(letters[i]), texture)
	if !new_sprite_frames.get_animation_names().has(display):
		queue_free()
	sprite_frames = new_sprite_frames
	play(display)

func reload():
	play(display)
