extends Node2D
class_name PipeSpawner

@export var spawnTimer : float = 5
@export var spawnDecrease : float = 0.5
@export var speed : int = 100
@export var speedIncrease : int = 20
@export var gap : int = 150
@export var gapDecrease: int = 20 
@export var PipeScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.GameEnd.connect(stop)
	Events.IncreaseDifficulty.connect(increase_difficulty)
	%Timer.start(spawnTimer)
	%Timer.timeout.connect(spawnPipe)

func stop():
	%Timer.stop()

func spawnPipe():
	print("NEW PIPE")
	var pipe : Pipes = PipeScene.instantiate()
	pipe.speed = speed
	pipe.gap = gap
	add_child(pipe)
	%Timer.start(spawnTimer)

func increase_difficulty():
	speed +=	 speedIncrease
	gap = max(50, gap-gapDecrease)
	spawnTimer = maxf(0.5, spawnTimer-spawnDecrease)
	print("difficulty: speed - %d,  gap - %s, time - %spawnTimer" % [speed, gap, spawnTimer])
	
