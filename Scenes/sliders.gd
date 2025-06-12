extends VBoxContainer
class_name Sliders

@onready var sfx : HSlider = %SFX
@onready var music : HSlider = %Music

func _ready():
	var musicv = SoundManager.getMusicVolume()
	var sfxv = SoundManager.getSFXVolume()
	
	sfx.value = sfxv
	music.value = musicv

func _on_sfx_value_changed(value):
	SoundManager.setSFXVolume(value)


func _on_music_value_changed(value):
	SoundManager.setMusicVolume(value)
