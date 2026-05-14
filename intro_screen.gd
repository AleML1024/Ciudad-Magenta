extends Control

func _on_button_pressed() -> void:
	hide()
	get_tree().change_scene_to_file("res://Main.tscn")
	
