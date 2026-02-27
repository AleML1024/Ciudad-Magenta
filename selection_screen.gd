extends Control

var selected_player: TextureButton = null

signal confirmed(player_name)

@onready var confirm_button = $Panel/Button

func _ready():
	confirm_button.disabled = true
	
	for player_button in $Panel/Players/HBoxContainer.get_children():
		player_button.pressed.connect(_on_player_pressed.bind(player_button))

func setup(current_player):
	selected_player = null
	confirm_button.disabled = true
	
	for player_button in $Panel/Players/HBoxContainer.get_children():
		
		player_button.modulate = Color.WHITE
		player_button.scale = Vector2.ONE
		
		if player_button.name == current_player.name:
			player_button.disabled = true
			player_button.modulate = Color(1,1,1,0.4)
		else:
			player_button.disabled = false
			
func _on_player_pressed(player_button):
	if selected_player == player_button:
		return
	
	var tween = create_tween()
	
	if selected_player:
		selected_player.modulate = Color(1,1,1)
		tween.tween_property(selected_player, "scale", Vector2(1,1), 0.15)
	
	selected_player = player_button
	
	player_button.modulate = Color(1, 1, 0.6)
	tween.tween_property(player_button, "scale", Vector2(1.1,1.1), 0.15)

	confirm_button.disabled = false

func _on_button_pressed() -> void:
	if selected_player:
		emit_signal("confirmed", selected_player.name)
		hide()
