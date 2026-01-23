extends Control

signal option_selected(result: Dictionary)
signal time_out

@onready var timer_label = $Timer/Label
@onready var buttons = [
	$Panel/Option1/Panel/Button1,
	$Panel/Option2/Panel/Button1,
	$Panel/Option3/Panel/Button1
]
@onready var options_labels = [
	$Panel/Option1/ColorRect/Panel/Label,
	$Panel/Option2/ColorRect/Panel/Label,
	$Panel/Option3/ColorRect/Panel/Label
]

var time_left = 60
var decision_data := {}

func show_decision(data: Dictionary):
	visible = true
	timer_label.visible = true
	decision_data = data
	time_left = 60
	
	for i in range(options_labels.size()):
		var option = data["options"][i]
		options_labels[i].text = option["text"]
		buttons[i].disabled = false
		
func _ready():
	for i in range (buttons.size()):
		buttons[i].pressed.connect(
			func(): _on_option_pressed(i)
		)

func _on_option_pressed(index: int):
	for b in buttons:
		b.disabled = true
		
	var result = decision_data["options"][index]["result"]
	emit_signal("option_selected", result)
	visible = false
	timer_label.visible = true
	
func _process(delta):
	if not visible:
		return
		
	time_left -= delta
	timer_label.text = str(ceil(time_left))
	
	if time_left < 0:
		_on_time_out()
		
func _on_time_out():
	hide()
	emit_signal("time_out")
