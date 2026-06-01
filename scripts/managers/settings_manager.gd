extends Node

const SETTINGS_PATH = "user://settings.cfg"

var settings := {
	"screen_mode": 0,
	"resolution": "1920x1080",
	
	"master_volume": 1.0,
	"music_volume": 1.0,
	"sfx_volume": 1.0
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
	
	config.set_value(
		"audio",
		"master_volume",
		settings.master_volume
	)

	config.set_value(
		"audio",
		"music_volume",
		settings.music_volume
	)

	config.set_value(
		"audio",
		"sfx_volume",
		settings.sfx_volume
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
	
	settings.master_volume = config.get_value(
		"audio",
		"master_volume",
		1.0
	)

	settings.music_volume = config.get_value(
		"audio",
		"music_volume",
		1.0
	)

	settings.sfx_volume = config.get_value(
		"audio",
		"sfx_volume",
		1.0
	)
