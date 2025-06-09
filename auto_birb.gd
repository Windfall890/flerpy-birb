extends Node2D

@export var centerOffset = 10

@onready var birb = $Birb
@onready var bounceThreshold = get_viewport_rect().get_center().y - centerOffset

var jitter:float 
func _ready():
	
	$Birb.player = false;
	print(bounceThreshold)
	$Birb.disableCollider()
	calcJitter()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func calcJitter():
	jitter = randf_range(-10,10)

func _process(delta):
	
	if $Birb.position.y + jitter > (get_viewport_rect().get_center().y - centerOffset) :
		$Birb.do_jump()
		calcJitter()
