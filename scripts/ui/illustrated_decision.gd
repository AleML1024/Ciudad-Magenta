extends CanvasLayer

signal option_selected(index)

@onready var hotspots = $Control/Hotspots.get_children()


func _ready():
	var index = -1
	for hotspot in hotspots:
		hotspot.option_clicked.connect(_on_option_clicked)
		hotspot.option_index = index+1


func _on_option_clicked(index):
	option_selected.emit(index)
