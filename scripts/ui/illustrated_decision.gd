extends CanvasLayer

signal option_selected(index)

@onready var hotspots = $Control/Hotspots.get_children()


func _ready():
	for hotspot in hotspots:
		hotspot.option_clicked.connect(_on_option_clicked)


func _on_option_clicked(index):
	option_selected.emit(index)
