extends Area2D

signal option_clicked(index)

@export var option_index = 0

func _ready():
	print("Hotspot listo")
	input_pickable = true
	
func set_polygon(points):
	$CollisionPolygon2D.polygon = points
	$Highlight.polygon = points
	
	print("Puntos:", points.size())
	print("Collision:", $CollisionPolygon2D.polygon)
	
func _on_mouse_entered():
	print("ENTER", option_index)
	$Highlight.visible = true
	
func _on_mouse_exited():
	print("EXIT", option_index)
	$Highlight.visible = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("CLICK HOTSPOT", option_index)
			option_clicked.emit(option_index)
