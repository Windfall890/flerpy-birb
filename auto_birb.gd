extends Node2D

@export var centerOffset = 0

@onready var birb = $Birb
@onready var bounceThreshold = get_viewport_rect().get_center().y - centerOffset

func _ready():
	$Birb.player = false;
	print(bounceThreshold)
	$Birb.disableCollider()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Birb.position.y > (get_viewport_rect().get_center().y - centerOffset) :
		$Birb.do_jump()
