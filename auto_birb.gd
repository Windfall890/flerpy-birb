extends Node2D

@export var centerOffset = 10

@onready var birb = %Birb
@onready var bounceThreshold = get_viewport_rect().get_center().y - centerOffset

var jitter:float 

func _ready():
	birb.player = false;
	print(bounceThreshold)
	birb.disableCollider()
	calcJitter()
	
func calcJitter():
	jitter = randf_range(-10,10)
	_draw()

func _physics_process(delta):
	if birb.position.y + jitter > (get_viewport_rect().get_center().y - centerOffset) :
		birb.do_jump()
		calcJitter()
