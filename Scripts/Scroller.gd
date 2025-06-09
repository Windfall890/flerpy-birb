extends TextureRect
class_name Scroller

@export var direction: Vector2
@export var speed: float
@export var pausedAtStart: bool

const SCROLL = preload("res://shaders/Scroll.gdshader")

func _ready():
	if material == null:
		material = ShaderMaterial.new()
	material.shader = SCROLL.duplicate()
	
	if !pausedAtStart :
		setScroll(direction, speed)
		
	Events.GameStart.connect(func(): setScroll(direction, speed))
	Events.GameEnd.connect(func(): setScroll(direction, 0))

func setDifficultySpeed(d:int):
	setSpeed(speed + 0.1*d)

func setSpeed(s:float):
	var current = material.get_shader_parameter("speed")
	print("scroller speed: %s" % current)
	material.set_shader_parameter("speed", s)
	
func setScroll(d:Vector2, s:float):
	material.set_shader_parameter("direction", d)
	setSpeed(s)
