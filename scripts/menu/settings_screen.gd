extends Node

@onready var screen_settings = $PanelContainer/VBoxContainer/Content/ScreenOptions
@onready var audio_settings = $PanelContainer/VBoxContainer/Content/SoundOptions
@onready var tab_buttons = [
	$PanelContainer/VBoxContainer/Header/Options/Screen,
	$PanelContainer/VBoxContainer/Header/Options/Sound,
]
var current_content

signal settings_confirmed

func _ready():
	show_tab($PanelContainer/VBoxContainer/Content/ScreenOptions)
	set_active_button($PanelContainer/VBoxContainer/Header/Options/Screen)
	
func show_tab(tab:Control):

	for child in $PanelContainer/VBoxContainer/Content.get_children():
		child.visible = false
		child.modulate.a = 0

	tab.visible = true

	var tween = create_tween()

	tween.tween_property(
		tab,
		"modulate:a",
		1.0,
		0.15
	)
	
func set_active_button(active_button: Button):

	for button in tab_buttons:

		# estilo normal
		button.modulate = Color(0.7, 0.7, 0.7)
		button.scale = Vector2.ONE

	# estilo activo
	active_button.modulate = Color.WHITE
	active_button.scale = Vector2(1.05, 1.05)

func _on_screen_pressed() -> void:
	set_active_button($PanelContainer/VBoxContainer/Header/Options/Screen)
	show_tab($PanelContainer/VBoxContainer/Content/ScreenOptions)


func _on_sound_pressed() -> void:
	set_active_button($PanelContainer/VBoxContainer/Header/Options/Sound)
	show_tab($PanelContainer/VBoxContainer/Content/SoundOptions)

func _on_confirm_pressed() -> void:
	emit_signal("settings_confirmed")
	show_tab($PanelContainer/VBoxContainer/Content/ScreenOptions)
	set_active_button($PanelContainer/VBoxContainer/Header/Options/Screen)
