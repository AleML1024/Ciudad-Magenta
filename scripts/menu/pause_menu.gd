extends CanvasLayer

@onready var settings_screen = $"../SettingsScreen"
@export var open_sound: AudioStream
@export var close_sound: AudioStream

func _ready():

	visible = false

func input(event):

	if event.is_action_pressed("ui_cancel"):

		if visible:
			resume_game()
			 
func toggle_pause():

	if get_tree().paused:
		resume_game()
	else:
		pause_game()


func pause_game():

	visible = true
	if open_sound:
		AudioManager.play_sfx(open_sound)
	get_tree().paused = true


func resume_game():

	visible = false
	if close_sound:
		AudioManager.play_sfx(close_sound)
	get_tree().paused = false


func _on_continue_pressed():

	resume_game()


func _on_settings_pressed():
	visible = false
	settings_screen.visible = true


func _on_menu_pressed():

	get_tree().paused = false

	get_tree().change_scene_to_file(
		"res://scenes/MainMenu.tscn"
	)
