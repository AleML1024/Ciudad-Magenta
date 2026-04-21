extends Control

signal option_selected(result: Dictionary)
signal time_out

@onready var timer_label = $Timer/Label

@onready var option_containers = [
	$Panel/HBoxContainer/Option1,
	$Panel/HBoxContainer/Option2,
	$Panel/HBoxContainer/Option3
]

@onready var buttons = [
	$Panel/HBoxContainer/Option1/VBoxContainer/Panel/Button1,
	$Panel/HBoxContainer/Option2/VBoxContainer/Panel/Button1,
	$Panel/HBoxContainer/Option3/VBoxContainer/Panel/Button1
]
@onready var options_labels = [
	$Panel/HBoxContainer/Option1/VBoxContainer/PanelContainer/Label,
	$Panel/HBoxContainer/Option2/VBoxContainer/PanelContainer/Label,
	$Panel/HBoxContainer/Option3/VBoxContainer/PanelContainer/Label
]

var time_left = 60
var decision_data := {}
var decision_active = false
		
func show_decision(data: Dictionary):
	visible = true
	timer_label.visible = true
	decision_data = data
	time_left = 60
	decision_active = true
	var options = data["options"]
	
	for i in range(buttons.size()):
		
		if i < options.size():
			var option = options[i]
			
			options_labels[i].text = option["text"]
			buttons[i].disabled = false
			
			# Mostrar el contenedor completo
			option_containers[i].visible = true
		
		else:
			# Ocultar opción sobrante
			print("Se oculta un botón")
			option_containers[i].visible = false
func _ready():
	for i in range(buttons.size()):
		var index = i
		buttons[i].pressed.connect(
			func(): _on_option_pressed(index)
		)

func _on_option_pressed(index: int):
	decision_active = false
	for b in buttons:
		b.disabled = true
		
	var result = decision_data["options"][index]["result"]
	emit_signal("option_selected", result)
	visible = false
	timer_label.visible = false
	
func _process(delta):
	if not decision_active:
		return
	
	time_left -= delta
	timer_label.text = str(int(time_left))
	
	if time_left < 0:
		_on_time_out()
		
func _on_time_out():
	decision_active = false
	hide()
	emit_signal("time_out")
