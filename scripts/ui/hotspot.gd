extends Area2D

signal option_clicked(index)

@export var option_index: int = 0

@onready var highlight = $Highlight
@onready var info_panel = $InfoPanel
@onready var info_label = $InfoPanel/Label

var highlight_tween: Tween


func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

	highlight.polygon = $CollisionPolygon2D.polygon
	input_pickable = true

	highlight.visible = false
	info_panel.visible = false

	highlight.color = Color(1.0, 1.0, 0.711, 0.0)


func _on_mouse_entered():
	highlight.visible = true
	info_panel.visible = true

	if highlight_tween:
		highlight_tween.kill()

	highlight_tween = create_tween()
	highlight_tween.set_trans(Tween.TRANS_SINE)
	highlight_tween.set_ease(Tween.EASE_IN_OUT)

	highlight_tween.tween_property(
		highlight,
		"color:a",
		0.22,
		0.25
	)

	highlight_tween.tween_property(
		highlight,
		"color:a",
		0.10,
		0.5
	)

	highlight_tween.set_loops()


func _on_mouse_exited():
	if highlight_tween:
		highlight_tween.kill()

	highlight_tween = create_tween()
	highlight_tween.set_trans(Tween.TRANS_SINE)
	highlight_tween.set_ease(Tween.EASE_OUT)

	highlight_tween.tween_property(
		highlight,
		"color:a",
		0.0,
		0.15
	)

	await highlight_tween.finished

	highlight.visible = false
	info_panel.visible = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			option_clicked.emit(option_index)
