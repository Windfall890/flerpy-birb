extends CanvasLayer

@onready var score_label = $GameOver/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.Tick.connect(updateClock)
	Events.ScoreChanged.connect(updateScore)
	Events.GameEnd.connect(gameOver)
	%GameOver.hide()

func updateClock(accum:float) -> void :
	%Clock.text = "TIME %.2f" % accum
	
func updateScore(score:int) -> void :
	%Score.text = "SCORE %03d" % score

func gameOver() :
	await get_tree().process_frame
	var highscore = SaveData.get_setting("highScore")
	if highscore == null :
		score_label.visible = false
	else :
		score_label.text = ("High Score: %5d" % highscore)
	%GameOver.show()
