extends Control

signal decision_continue_pressed
signal situation_continue_pressed
signal result_continue_pressed

@onready var body = $Panel/PanelContainer/Body
@onready var title = $Panel/Label
@onready var continue_button = $Panel/Button

var _type= ""

func _ready():
	continue_button.pressed.connect(_on_continue_button_pressed)

func show_screen(text: String, type: String):
	_type = type
	if _type == "decision":
		title.text = "Te has encontrado con un problema..."
	if _type == "situation":
		title.text = "Te has encontrado con un suceso..."
	if _type == "result":
		title.text = "Resultado..."
	body.text = text
	visible = true

func _on_continue_button_pressed():
	visible = false
	if _type == "decision": 
		emit_signal("decision_continue_pressed")
	if _type == "situation":
		emit_signal("situation_continue_pressed")
	if _type == "result":
		emit_signal("result_continue_pressed")
