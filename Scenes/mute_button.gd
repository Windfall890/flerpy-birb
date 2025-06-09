extends CheckBox

@onready var sound_on = $SoundOn
@onready var sound_off = $SoundOff

# Called when the node enters the scene tree for the first time.
func _ready():
	var muted = SaveData.get_setting("mute")
	if muted == null:
		muted = false
	button_pressed = muted
	setIcon(muted)
	toggled.connect(setIcon)
	
func setIcon(muted) :
	SaveData.set_setting("mute", muted)
	SaveData.save()
	if muted :
		sound_on.visible = false
		sound_off.visible = true
	else :
		sound_on.visible = true
		sound_off.visible = false
		
	AudioServer.set_bus_mute(0,muted)	
		
