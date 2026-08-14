extends CanvasLayer

signal option_selected(result)
signal time_out

@onready var timer_label = $Control/Timer/Label
@onready var decision_container = $Control/DecisionContainer

var decision_data: Dictionary
var time_left := 60.0
var active := false
var decision_scene


func show_decision(card: Dictionary):
	decision_data = card
	time_left = 60.0
	active = true
	
	timer_label.visible = true
	
	decision_scene = load(card["illustrated_scene"]).instantiate()
	decision_container.add_child(decision_scene)

	decision_scene.option_selected.connect(_on_option_clicked)


func _on_option_clicked(index: int):
	if not active:
		return
	
	print("IllustratedDecisionScreen visible antes: ", visible)
	
	active = false
	timer_label.visible = false
	
	decision_scene.queue_free()
	decision_scene = null
	visible = false

	print("IllustratedDecisionScreen visible después: ", visible)
	
	var result = decision_data["options"][index]["result"]
	option_selected.emit(result)


func _process(delta):
	if not active:
		return

	time_left -= delta
	timer_label.text = str(int(time_left))

	if time_left <= 0:
		active = false
		timer_label.visible = false
		decision_scene.queue_free()
		decision_scene = null
		visible = false
		time_out.emit()
