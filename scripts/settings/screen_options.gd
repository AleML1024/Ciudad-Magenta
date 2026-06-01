extends Control

@onready var screen_mode = $ScreenMode/ScreenModeSelector
@onready var resolution = $ScreenResolution/ScreenResSelector


var resolutions := {
	"1280x720": Vector2i(1280, 720),
	"1600x900": Vector2i(1600, 900),
	"1920x1080": Vector2i(1920, 1080),
	"2560x1440": Vector2i(2560, 1440)
}


func _ready():

	setup_screen_modes()
	setup_resolutions()

	load_saved_settings()


func setup_screen_modes():

	screen_mode.clear()

	screen_mode.add_item("Ventana")
	screen_mode.add_item("Pantalla completa")


func setup_resolutions():

	resolution.clear()

	for res in resolutions.keys():
		resolution.add_item(res)


func load_saved_settings():

	var saved_mode = SettingsManager.settings.screen_mode
	var saved_resolution = SettingsManager.settings.resolution

	screen_mode.select(saved_mode)

	set_screen_mode(saved_mode)

	var index = 0

	for i in range(resolution.item_count):

		if resolution.get_item_text(i) == saved_resolution:
			index = i
			break

	resolution.select(index)

	set_resolution_from_index(index)

func _on_screen_mode_selected(index: int):
	print("Modo cambiado:", index)
	set_screen_mode(index)


func set_screen_mode(index: int):

	match index:

		# Ventana
		0:
			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_WINDOWED
			)

			DisplayServer.window_set_flag(
				DisplayServer.WINDOW_FLAG_BORDERLESS,
				false
			)

			resolution.disabled = false

		# Fullscreen
		1:
			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_FULLSCREEN
			)

			resolution.disabled = true

	center_window()
	SettingsManager.settings.screen_mode = index
	SettingsManager.save_settings()

func _on_resolution_selected(index: int):
	print("Resolución cambiada:", index)
	set_resolution_from_index(index)


func set_resolution_from_index(index: int):

	var selected_text = resolution.get_item_text(index)

	if resolutions.has(selected_text):

		var resolution_size = resolutions[selected_text]

		DisplayServer.window_set_size(resolution_size)

		center_window()
		SettingsManager.settings.resolution = selected_text
		SettingsManager.save_settings()

func center_window():

	var window = get_window()

	if window.mode == Window.MODE_FULLSCREEN:
		return

	window.move_to_center()
