extends CanvasLayer

signal option_selected(result)
signal time_out

const HOTSPOT_SCENE := preload("res://scenes/Hotspot.tscn")

@onready var background = $Control/Background
@onready var hotspot_container = $Control/Hotspots
@onready var timer_label = $Control/Timer/Label

var decision_data
var time_left = 60
var active = false

func show_decision(card):
	decision_data = card
	background.texture = load(card["image"])

	for c in hotspot_container.get_children():
		c.queue_free()

	for i in range(card["hotspots"].size()):
		var hotspot = HOTSPOT_SCENE.instantiate()
		
		var texture_size = background.texture.get_size()
		var display_size = background.size

		var scale_x = display_size.x / texture_size.x
		var scale_y = display_size.y / texture_size.y

		var scaled = PackedVector2Array()
		
		for p in card["hotspots"][i]["polygon"]:
			scaled.append(Vector2(
			p.x * scale_x,
			p.y * scale_y
		))
		hotspot.set_polygon(card["hotspots"][i]["polygon"])
		
		
		hotspot.option_index = i
		hotspot.option_clicked.connect(_on_option_clicked)
		hotspot_container.add_child(hotspot)
		
	timer_label.visible = true
	time_left = 60
	active = true
	print("Texture:", background.texture.get_size())
	print("Background:", background.size)
	
func _on_option_clicked(index):
	active = false
	var result = decision_data["options"][index]["result"]
	option_selected.emit(result)
	hide()
	
	
func _process(delta):
	if !active:
		return

	time_left -= delta

	timer_label.text = str(int(time_left))

	if time_left <= 0:
		active = false
		time_out.emit()
	
