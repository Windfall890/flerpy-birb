class_name Birb
extends CharacterBody2D

const TERMINAL_VELOCITY : float= 600
const NEUTRAL_ANGLE_RANGE : float= 10

@export var gravity : float = 100
@export var jumpPower : float = 100

var lookUp = Vector2(1,-1)
var lookDown = Vector2(1,1)
var dead : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	dead = false
	velocity = Vector2.ZERO
	
func _physics_process(delta):
	
	velocity.x = 0
	velocity.y = minf(TERMINAL_VELOCITY, velocity.y + gravity * delta)
	var collided = move_and_slide()
	position.y = clamp(position.y, 10, get_viewport_rect().size.y)
	
	#adjust angle of sprite based on velocity
	if velocity.y < -NEUTRAL_ANGLE_RANGE :
		%Sprite.rotation_degrees = -30
	elif velocity.y > NEUTRAL_ANGLE_RANGE : 
		%Sprite.rotation_degrees = 15
	else:
		%Sprite.rotation_degrees = 0
	
	if dead:
		return
	
	if velocity.y > 0 && !%Sprite.is_playing():
		%Sprite.play("default")
		
	if Input.is_action_pressed("Jump"):
		%Sprite.play("flerp")
		do_jump()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.get_collider().name)
		
	if collided:
		die()

func die() -> void:
	print("DEAD")
	velocity.y = 0 
	%Sprite.stop()
	dead = true
	Events.GameEnd.emit()

func do_jump():
	velocity.y = -jumpPower 
