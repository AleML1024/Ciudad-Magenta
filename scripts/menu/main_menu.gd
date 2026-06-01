extends Control

func _ready():
	$StartScreen.visible = true
	$RulesScreen.visible = false
	$IntroScreen.visible = false
	$SettingsScreen.visible = false
	$CreditsScreen.visible = false
	
	$RulesScreen.rules_finished.connect(_on_rules_finished)
	$SettingsScreen.settings_confirmed.connect(_on_settings_confirmed)
	
	var menu_music = preload(
		"res://assets/audio/music/Wii Party Soundtrack Main Menu Music (Nostalgia Version).mp3"
	)

	AudioManager.play_music(menu_music)

func _on_play_pressed() -> void:
	switch_screen($StartScreen, $IntroScreen)
	

func _on_rules_pressed() -> void:
	switch_screen($StartScreen, $RulesScreen)

func _on_settings_pressed() -> void:
	switch_screen($StartScreen, $SettingsScreen)
	
func _on_credits_pressed() -> void:
	switch_screen($StartScreen, $CreditsScreen)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_rules_finished():
	switch_screen($RulesScreen, $StartScreen)
	
func _on_settings_confirmed():
	switch_screen($SettingsScreen, $StartScreen)
	
func switch_screen(from_screen: Control, to_screen: Control):

	var tween = create_tween()

	# Fade out
	tween.tween_property(from_screen, "modulate:a", 0.0, 0.15)

	await tween.finished

	from_screen.visible = false

	# Preparar nueva pantalla
	to_screen.visible = true
	to_screen.modulate.a = 0.0

	# Fade in
	var tween2 = create_tween()
	tween2.tween_property(to_screen, "modulate:a", 1.0, 0.15)
