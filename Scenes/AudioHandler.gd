extends Node2D
class_name AudioHandler

func _ready():
	AudioEvents.Die.connect(die)
	AudioEvents.Flap.connect(flap)
	AudioEvents.Hit.connect(hit)
	AudioEvents.Point.connect(point)
	AudioEvents.MusicStart.connect(startBGM)
	AudioEvents.MusicStop.connect(stopBGM)
	AudioEvents.MusicSlow.connect(slowBGM)
	AudioEvents.VolumeChanged.connect(setVolume)
	Events.GameEnd.connect(slowBGM)
	Events.GameStart.connect(startBGM)
	initVolume()
	

func die():
	var pitch = randf_range(0.8,1.2)
	%DieSound.pitch_scale = pitch
	%DieSound.play()
	
func flap():
	var pitch = randf_range(1,1.4)
	%FlapSound.pitch_scale = pitch
	%FlapSound.play()
	
func hit():
	var pitch = randf_range(0.8,1.2)
	%HitSound.pitch_scale = pitch
	%HitSound.play()
	
func point():
	var pitch = randf_range(0.9,1.3)
	%WhooshSound.pitch_scale = pitch
	%WhooshSound.play()

func startBGM():
	%BGM.pitch_scale = 1
	%BGM.play()

func stopBGM():
	%BGM.stop()

func slowBGM():
	#a musical third down
	%BGM.pitch_scale = (1-0.3348)

func initVolume():
	var value = SaveData.get_setting("volume")
	if value == null:
		value = 1
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))

func setVolume(value:float):
	SaveData.set_setting("volume", value)
	SaveData.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))
		
