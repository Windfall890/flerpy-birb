extends Node2D
class_name Game

var accumulator: float = 0
var score: int = 0
var difficulty: int = 0
@export var difficultyTime:float = 20 

# Called when the node enters the scene tree for the first time.
func _ready():
	%GameTime.timeout.connect(clockTick)
	%GameTime.start(0.01)
	
	%DifficultyTime.timeout.connect(increaseDifficulty)
	%DifficultyTime.start(difficultyTime)
	
	Events.PointScored.connect(countScore)
	Events.GameEnd.connect(gameOver)
	Events.GameStart.emit()

func clockTick():
	accumulator += %GameTime.wait_time
	Events.Tick.emit(accumulator)

	
func countScore():
	score += 1
	await get_tree().create_timer(0.25).timeout
	Events.ScoreChanged.emit(score)
	AudioEvents.Point.emit()
	
func gameOver():
	var highscore= SaveData.get_setting("highScore")
	if highscore == null:
		highscore = 0
		
	if score > highscore:
		SaveData.set_setting("highScore", score)
	
	SaveData.set_setting("last_score", score)
	%GameTime.stop()
	%DifficultyTime.stop()

func reset()-> void:
	get_tree().reload_current_scene()
		
func increaseDifficulty()->void:
	difficulty+=1 
	Events.IncreaseDifficulty.emit(difficulty)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Difficulty"):
		increaseDifficulty()
	if Input.is_action_just_pressed("Reset"):
		reset()


func _on_reset_button_pressed():
	reset()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Title.tscn")
