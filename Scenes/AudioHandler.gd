extends Node2D
class_name AudioHandler

func _ready():
	AudioEvents.Die.connect(die)
	AudioEvents.Flap.connect(flap)
	AudioEvents.Hit.connect(hit)
	AudioEvents.Point.connect(point)
	AudioEvents.Whoosh.connect(whoosh)
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
	
func whoosh():
	var pitch = randf_range(0.9,1.3)
	%WhooshSound.pitch_scale = pitch
	%WhooshSound.play()
	
func point():
	var pitch = randf_range(1.1,1.2)
	%PointSound.pitch_scale = pitch
	%PointSound.play()

func startBGM():
	%BGM.pitch_scale = 1
	%BGM.finished.connect(func() : $BGM.play())
	%BGM.play()

func stopBGM():
	%BGM.stop()

func slowBGM():
	#a musical third down
	%BGM.pitch_scale = (1-0.3348)
	%BGM.finished.connect(func() : $"%BGM".stop())

func initVolume():
	var value = SaveData.get_setting("volume", 1)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))

	value = getSFXVolume()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))

	value = getMusicVolume()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))


func setVolume(value:float):
	SaveData.set_setting("volume", value)
	SaveData.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))

func setSFXVolume(value:float):
	SaveData.set_setting("sfxvolume", value)
	SaveData.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))
			
func setMusicVolume(value:float):
	SaveData.set_setting("musicvolume", value)
	SaveData.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
				
func getMusicVolume():
	return SaveData.get_setting("musicvolume", 0.8)
	
func getSFXVolume():
	return SaveData.get_setting("sfxvolume", 0.8)	
