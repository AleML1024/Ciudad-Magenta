extends Control

signal continue_pressed

@onready var problem_text = $Panel/ColorRect/Label
@onready var continue_button = $Panel/Button

func _ready():
	continue_button.pressed.connect(_on_continue_button_pressed)

func show_problem(text: String):
	problem_text.text = text
	visible = true

func _on_continue_button_pressed():
	visible = false
	emit_signal("continue_pressed")
