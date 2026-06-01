class_name SoundButton
extends Button

@export var hover_sound: AudioStream = preload(
	"res://assets/audio/sfx/SFX_UI_MenuSelections.mp3"
)

@export var click_sound: AudioStream = preload(
	"res://assets/audio/sfx/SFX_UI_Confirm.mp3"
)


func _ready():

	mouse_entered.connect(_play_hover_sound)
	pressed.connect(_play_click_sound)


func _play_hover_sound():

	if hover_sound:
		AudioManager.play_sfx(hover_sound)


func _play_click_sound():

	if click_sound:
		AudioManager.play_sfx(click_sound)
