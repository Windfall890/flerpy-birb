extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.Tick.connect(updateClock)
	Events.ScoreChanged.connect(updateScore)
	Events.GameEnd.connect(func () : %GameOver.show())
	%GameOver.hide()


func updateClock(accum:float) -> void :
	%Clock.text = "TIME %.2f" % accum
	
func updateScore(score:int) -> void :
	%Score.text = "SCORE %03d" % score
