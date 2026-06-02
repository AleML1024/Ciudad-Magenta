extends Node

var sfx_player: AudioStreamPlayer
var music_player: AudioStreamPlayer


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Crear reproductor de SFX
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.bus = "SFX"

	# Crear reproductor de música
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"

	apply_saved_volumes()

func play_sfx(sound: AudioStream):

	sfx_player.stream = sound
	sfx_player.play()


func play_music(sound: AudioStream):

	if music_player.stream == sound:
		return

	music_player.stream = sound
	music_player.play()

func set_bus_volume(bus_name: String, linear_value: float):

	var bus_index = AudioServer.get_bus_index(bus_name)

	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(linear_value)
	)
	
func apply_saved_volumes():

	set_bus_volume(
		"Master",
		SettingsManager.settings.master_volume
	)

	set_bus_volume(
		"Music",
		SettingsManager.settings.music_volume
	)

	set_bus_volume(
		"SFX",
		SettingsManager.settings.sfx_volume
	)
