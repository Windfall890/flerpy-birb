extends Node
class_name SaveManager


var save_path = "user://flerpy.cfg"
var config = ConfigFile.new()

func _ready():
	load_config()

func load_config():
	# Load data from a file.
	var err = config.load(save_path)

	# If the file didn't load, ignore it.
	if err != OK:
		print("file not found")
	else:
		print("loaded config!")
	
	print(config.encode_to_text())

func save():
	config.save(save_path)
	
func set_setting(setting,value):
	config.set_value("settings", setting, value)
	
func get_setting(setting):
	return config.get_value("settings", setting)
