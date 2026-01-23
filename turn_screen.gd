extends CanvasLayer

signal continue_pressed

@onready var label = $Control/Panel/Label

func show_turn(player_name: String):
	label.text = "¡Ahora es el turno de " + player_name + "!"
	visible = true

func _on_button_pressed() -> void:
	visible = false
	emit_signal("continue_pressed")
