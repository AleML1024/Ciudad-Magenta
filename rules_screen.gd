extends Control

@onready var content = $PanelContainer/Content
@onready var next_button = $HBoxContainer/Next
@onready var back_button = $HBoxContainer/Previous
# @onready var indicator = $PageIndicator

var pages = [
	preload("res://rules/RulesPage1.tscn"),
	preload("res://rules/RulesPage2.tscn"),
	preload("res://rules/RulesPage3.tscn"),
	preload("res://rules/RulesPage4.tscn"),
	preload("res://rules/RulesPage5.tscn"),
	preload("res://rules/RulesPage6.tscn"),
	preload("res://rules/RulesPage7.tscn")
]

var current_page := 0
var current_instance

signal rules_finished

func _ready():
	show_page(0)

func show_page(index):
	if current_instance:
		var old = current_instance
		var tween = create_tween()
		
		tween.tween_property(old, "modulate:a", 0, 0.1)
		tween.tween_callback(func():
			old.queue_free()
			
			current_instance = pages[index].instantiate()
			current_instance.modulate.a = 0
			content.add_child(current_instance)
			
			var t2 = create_tween()
			t2.tween_property(current_instance, "modulate:a", 1, 0.1)
		)
	else:
		current_instance = pages[index].instantiate()
		content.add_child(current_instance)

	current_page = index
	update_ui()

func update_ui():
	#indicator.text = str(current_page + 1) + "/" + str(pages.size())

	back_button.disabled = current_page == 0
	

func _on_next_pressed() -> void:
	if current_page < pages.size() - 1:
		show_page(current_page + 1)
		if current_page == pages.size() - 1:
			next_button.get_child(0).text = "Salir"
	else:
		print("Reglas terminadas")
		emit_signal("rules_finished")
		


func _on_previous_pressed() -> void:
	if current_page > 0:
		show_page(current_page - 1)
		

func _on_skip_pressed() -> void:
	print("Reglas terminadas")
	current_page = pages.size() -1
	emit_signal("rules_finished")
