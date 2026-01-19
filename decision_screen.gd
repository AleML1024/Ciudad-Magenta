extends CanvasLayer

signal continue_pressed

@onready var problem_text = $Root/Panel/ColorRect/Label

func show_problem(text: String):
	problem_text.text = text
	visible = true
	
func _on_continue_button_pressed():
	visible = false
	emit_signal("continue_pressed")
