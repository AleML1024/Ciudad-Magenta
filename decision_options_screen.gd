extends CanvasLayer

signal option_selected(result: Dictionary)
signal time_out

@onready var root = $Root
@onready var timer_label = $Root/Panel/Timer/Label
@onready var buttons = [
	$Root/Panel/Option1/Panel/Button1,
	$Root/Panel/Option2/Panel/Button2,
	$Root/Panel/Option3/Panel/Button3
]

var time_left = 60
var decision_data := {}

func show_decision(data: Dictionary):
	root.visible = true
	decision_data = data
	time_left = 60
	
	for i in range(buttons.size()):
		var option = data["options"][i]
		buttons[i].text = option["text"]
		buttons[i].disabled = false
		
func _ready():
	for i in range (buttons.size()):
		buttons[i].pressed.connect(
			func(): _on_option_pressed(i)
		)

func _on_option_pressed(index: int):
	for b in buttons:
		b.disabled = true
		
	var result = decision_data["data"][index]["result"]
	emit_signal("option_selected", result)
	root.visible = false
	
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
