extends Node2D
class_name PipeSpawner

@export var spawnTimer : float = 5
var baseTimer:float
@export var spawnDecrease : float = 0.25
@export var speed : int = 100
var baseSpeed:int
@export var speedIncrease : int = 20
@export var gap : int = 150
var baseGap:int
@export var gapDecrease: int = 10 
@export var PipeScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	baseTimer = spawnTimer
	baseSpeed = speed
	baseGap = gap
	
	Events.GameEnd.connect(stop)
	Events.IncreaseDifficulty.connect(setDifficulty)
	%Timer.start(spawnTimer)
	%Timer.timeout.connect(spawnPipe)

func stop():
	%Timer.stop()

func spawnPipe() -> void:
	print("NEW PIPE")
	printPipe()
	var pipe : Pipes = PipeScene.instantiate()
	pipe.speed = speed
	pipe.gap = gap
	add_child(pipe)
	%Timer.start(spawnTimer)

func setDifficulty(d:int) -> void:
	speed = baseSpeed + speedIncrease * d
	gap = max(50, baseGap-(gapDecrease*d))
	spawnTimer = maxf(0.5, baseTimer-(spawnDecrease*d))
	printPipe()
	
func printPipe() -> void:
	print("difficulty: speed - %d,  gap - %s, time - %spawnTimer" % [speed, gap, spawnTimer])	
