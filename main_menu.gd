extends Control

func _ready():
	$StartScreen.visible = true
	$RulesScreen.visible = false
	$IntroScreen.visible = false
	


func _on_play_pressed() -> void:
	$StartScreen.visible = false
	$IntroScreen.visible = true
