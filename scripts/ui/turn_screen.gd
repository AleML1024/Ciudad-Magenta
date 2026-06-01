extends CanvasLayer

signal continue_pressed

@onready var label = $Control/Panel/Label
@onready var avatar = $Control/Panel/ColorRect

func show_turn(player):
	label.text = "¡Ahora es el turno de " + player.name + "!"
	avatar.texture = player.get_character_portrait()
	visible = true

func _on_button_pressed() -> void:
	visible = false
	emit_signal("continue_pressed")
