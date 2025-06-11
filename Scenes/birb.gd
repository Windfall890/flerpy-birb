class_name Birb
extends CharacterBody2D

const TERMINAL_VELOCITY : float= 600
const NEUTRAL_ANGLE_RANGE : float= 10

@export var gravity : float = 100
@export var jumpPower : float = 100
@export var jumpCD : float = 0.07
@export var maxSpeed : float = 100
@export var player : bool = true

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
		
	if Input.is_action_just_pressed("Jump") && player:
		do_jump()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.get_collider().name)
		
	if collided:
		AudioEvents.Hit.emit()
		die()

func die() -> void:
	print("DEAD")
	velocity.y = 0 
	%Sprite.play("xdead")
	dead = true
	Events.GameEnd.emit()
	
	await %Sprite.animation_finished
	AudioEvents.Die.emit()

func do_jump():
	if %JumpTimer.is_stopped() :
		if velocity.y > 0:
			velocity.y = 0
		if velocity.y > -maxSpeed :
			velocity.y = velocity.y - jumpPower 
		%Sprite.play("flerp")
		AudioEvents.Flap.emit()
		#print("JUMP: %f" % velocity.y)
		%JumpTimer.start(jumpCD)
		
func disableCollider() -> void :
	$CollisionShape2D.disabled = true
	
	
	
