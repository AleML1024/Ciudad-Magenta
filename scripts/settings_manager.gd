extends Node

const SETTINGS_PATH = "user://settings.cfg"

var settings := {
	"screen_mode": 0,
	"resolution": "1920x1080"
}


func _ready():
	load_settings()


# ==================================================
# SAVE
# ==================================================

func save_settings():

	var config = ConfigFile.new()

	config.set_value(
		"display",
		"screen_mode",
		settings.screen_mode
	)

	config.set_value(
		"display",
		"resolution",
		settings.resolution
	)

	config.save(SETTINGS_PATH)


# ==================================================
# LOAD
# ==================================================

func load_settings():

	var config = ConfigFile.new()

	var error = config.load(SETTINGS_PATH)

	if error != OK:
		save_settings()
		return

	settings.screen_mode = config.get_value(
		"display",
		"screen_mode",
		0
	)

	settings.resolution = config.get_value(
		"display",
		"resolution",
		"1920x1080"
	)
