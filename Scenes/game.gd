extends Node2D


var accumulator: float = 0
var score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	%GameTime.timeout.connect(clockTick)
	%GameTime.start(0.01)
	Events.PointScored.connect(countScore)
	Events.GameEnd.connect(func () : %GameTime.stop())

func clockTick():
	accumulator += %GameTime.wait_time
	Events.Tick.emit(accumulator)
	
func countScore():
	score += 1
	Events.ScoreChanged.emit(score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Difficulty"):
		Events.IncreaseDifficulty.emit()
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
