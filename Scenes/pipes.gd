extends Node2D
class_name Pipes

@export var spawnXOffset: int = 20
@export var despawnXOffset : int = -20
@export var speed :float = 5
@export var gap : int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	var jitter = randi_range(-75, 75)
	global_position.x = get_viewport_rect().size.x + spawnXOffset
	global_position.y = get_viewport_rect().size.y / 2.0 + jitter                  
	%Top.position.y -= gap/2
	%Bottom.position.y +=gap/2
	print("PIPE - X=%d, jitter=%d, gap=%d, speed=%d" % [global_position.x, jitter, gap, speed])
	Events.GameEnd.connect(stop)

func stop():
	speed = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x -= speed * delta
#	if global_position.x <= get_viewport_rect().position.x + despawnXOffset:
#		queue_free()


func _on_area_2d_body_entered(body):
	if body is Birb :
		Events.PointScored.emit()
		AudioEvents.Point.emit()
