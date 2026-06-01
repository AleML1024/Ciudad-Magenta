extends VBoxContainer

@onready var master_slider = $"Master Volume/MasterSlider"
@onready var music_slider = $"SFX Volume/SFXSlider"
@onready var sfx_slider = $"Music Volume/MusicSlider"

func _ready():
	load_audio_settings()
	
func load_audio_settings():

	master_slider.value = SettingsManager.settings.master_volume
	music_slider.value = SettingsManager.settings.music_volume
	sfx_slider.value = SettingsManager.settings.sfx_volume

func _on_master_changed(value: float) -> void:
	AudioManager.set_bus_volume(
		"Master",
		value
	)

	SettingsManager.settings.master_volume = value
	SettingsManager.save_settings()


func _on_sfx_changed(value: float) -> void:
	AudioManager.set_bus_volume(
		"SFX",
		value
	)

	SettingsManager.settings.music_volume = value
	SettingsManager.save_settings()
	


func _on_music_changed(value: float) -> void:
	AudioManager.set_bus_volume(
		"Music",
		value
	)

	SettingsManager.settings.sfx_volume = value
	SettingsManager.save_settings()
