extends CanvasLayer

const GAME = preload("res://Scenes/game.tscn")

@onready var score_label = $ScoreLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.startBGM()
	var highscore = SaveData.get_setting("highScore")
	if highscore == null :
		score_label.visible = false
	else :
		score_label.text = ("High Score: %5d" % highscore)


func _on_button_pressed():
	get_tree().change_scene_to_packed(GAME)
