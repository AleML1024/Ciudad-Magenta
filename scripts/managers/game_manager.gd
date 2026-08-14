extends Node

@onready var board = $Board
@onready var card_manager = $CardManager
@onready var players = $Players.get_children()
@onready var turn_screen = $TurnScreen
@onready var decision_options_ui = $DecisionOptionsScreen/Control
@onready var text_screen = $TextScreen/Control
@onready var selection_screen = $SelectionScreen/Control
@onready var pause_menu = $PauseMenu
@onready var settings_screen = $SettingsScreen
@onready var end_game_screen = $EndGameScreen
@onready var illustrated_decision = $IllustratedDecisionScreen

@onready var ui_violeta = $PlayersUI/PlayerInfoVioleta
@onready var ui_ruby = $PlayersUI/PlayerInfoRuby
@onready var ui_celeste = $PlayersUI/PlayerInfoCeleste
@onready var ui_marino = $PlayersUI/PlayerInfoMarino




var turn_in_progress := false
var ignore_decisions := true
var selection_in_progress := false

var current_player_index := 0
var is_last_round := false
var waiting_for_decision := false
var pending_result : Dictionary = {}
var pending_effect_player = null
var pending_effect_data = null

var finished_players := []
var game_finished := false

func _ready():
	print("Game started")
	
	waiting_for_decision = false
	for player in players:
		player.has_pending_decision = false
		player.pending_decision_card = {}
	
	$TextScreen.visible = false
	$DecisionOptionsScreen.visible = false
	$SelectionScreen.visible = false
	
	text_screen.decision_continue_pressed.connect(_on_problem_continue)
	text_screen.situation_continue_pressed.connect(_on_situation_continue)
	text_screen.result_continue_pressed.connect(_on_result_continue)
	text_screen.timeout_continue_pressed.connect(_on_timeout_continue)
	decision_options_ui.option_selected.connect(_on_decision_resolved)
	decision_options_ui.time_out.connect(_on_decision_timeout)
	selection_screen.confirmed.connect(_on_confirm_pressed)
	settings_screen.settings_confirmed.connect(_on_settings_confirmed)
	end_game_screen.continue_pressed.connect(_on_continue_button_pressed)
	illustrated_decision.option_selected.connect(_on_decision_resolved)
	illustrated_decision.time_out.connect(_on_decision_timeout)
	
	
	turn_screen.visible = false
	turn_screen.connect("continue_pressed", Callable(self, "_on_turn_continue"))
	
	var start_tiles = board.get_start_tiles()

	for i in range(players.size()):
		var player = players[i]
		player.set_game_manager(self)
		player.set_board(board)

		player.start_tile_index = start_tiles[i % start_tiles.size()]
		player.place_on_start()

		player.coins = 20
		
	setup_player_ui()
	start_turn()

func start_turn():
	if game_finished:
		return
		
	if turn_in_progress or waiting_for_decision:
		return

	turn_in_progress = true
	var player = players[current_player_index]

	turn_screen.show_turn(player)
	print("Turno de:", player.name)
		
		
func _on_turn_continue():
	turn_screen.visible = false
	var player = players[current_player_index]
	print("Primer turno:", player.is_first_turn, "Tile:", player.tile_index)
	
	if player.has_pending_decision:
		player.resolve_tile()
		return

	if player.is_first_turn:
		player.is_first_turn = false
		player.move_steps(1)

func end_turn():
	print("FIN TURNO:", players[current_player_index].name)
	turn_in_progress = false
	while true:

		current_player_index = (current_player_index + 1) % players.size()

		if !players[current_player_index].finished:
			break

		if finished_players.size() == players.size():
			return
	start_turn()


		
func start_decision(player):
	print("decision " + player.name)
	
	waiting_for_decision = true
	$TextScreen.visible = true
	$DecisionOptionsScreen.visible = false
	
	var card = player.pending_decision_card
	text_screen.show_screen(card["text"], "decision")
	
	
func _on_decision_resolved(result: Dictionary):
	$DecisionOptionsScreen.visible = false
	waiting_for_decision = false

	pending_result = result

	# mostrar pantalla de resultado
	text_screen.show_screen(result["text"], "result")
	$TextScreen.visible = true
	
func _on_result_continue():
	$TextScreen.visible = false

	var player = players[current_player_index]

	if pending_result.has("coins"):
		player.add_coins(pending_result["coins"])

	if pending_result.has("move") and pending_result["move"] != 0:
		await player.move_steps(pending_result["move"])
	else:
		end_turn()

	pending_result = {}
	
func _on_decision_timeout():
	$DecisionOptionsScreen.visible = false
	text_screen.show_screen("Pierdes el turno y avanzas 1 casilla.", "timeout")
	$TextScreen.visible = true

func _on_timeout_continue():
	$TextScreen.visible = false
	waiting_for_decision = false
	
	var player = players[current_player_index]
	
	print("Tiempo agotado, se aplica penalización")
	player.move_steps(1)
	
func _on_problem_continue():
	$TextScreen.visible = false

	var player = players[current_player_index]
	var card = player.pending_decision_card

	if card.has("illustrated_scene"):
		show_illustrated_decision(card)
	else:
		$DecisionOptionsScreen.visible = true
		decision_options_ui.show_decision(card)

func show_illustrated_decision(card):
	$IllustratedDecisionScreen.visible = true
	illustrated_decision.show_decision(card)
	
func _on_situation_continue():
	$TextScreen.visible = false
	var player = players[current_player_index]
	resolve_card(player, player.situation_card)
	
func apply_effects(player, effects):
	for effect in effects:
		apply_single_effect(player, effect)
	if selection_in_progress == false:
		player.move_steps(1)

func apply_single_effect(player, effect):
	var target = effect.get("target", "self")
	var value = effect.get("value", 0)

	var target_player = resolve_target(player, target)

	if target_player == null:
		return
	target_player.add_coins(value)

func resolve_target(player, target):
	match target:

		"self":
			return player

		"other_random":
			var others = players.filter(func(p): return p != player)
			return others.pick_random()

		"other_choice":
			selection_in_progress = true
			print("Escogiendo objetivo")
			pending_effect_player = player
			pending_effect_data = target
			show_player_selection(player)
			print("Objetivo seleccionado")
			return null

	return player
	
func show_player_selection(current_player):
	$SelectionScreen.visible = true
	selection_screen.setup(current_player)
	
func _on_confirm_pressed(player_name):
	var source = pending_effect_player
	var target = players.filter(func(p): return p.name == player_name)[0]

	for effect in source.situation_card["effects"]:
		if effect["target"] != "other_choice":
			continue
			
		match effect["type"]:
			"coins":
				target.add_coins(effect["value"])
			"swap_position":
				swap_players(source, target)

	pending_effect_player = null
	pending_effect_data = null
	
	print("Confirmar presionado")
	$SelectionScreen.visible = false
	selection_in_progress = false
	await source.move_steps(1)

func swap_players(player_a, player_b):
	var progress_a = player_a.tile_index - player_a.start_tile_index
	var progress_b = player_b.tile_index - player_b.start_tile_index

	player_a.tile_index = player_a.start_tile_index + progress_b
	player_b.tile_index = player_b.start_tile_index + progress_a

	player_a.global_position = board.tiles_positions[player_a.tile_index]
	player_b.global_position = board.tiles_positions[player_b.tile_index]
	
func resolve_card(player, card):
	if card.has("effects"):
		apply_effects(player, card["effects"])
		
func apply_decision_result(player, result):
	if result.has("coins"):
		player.add_coins(result["coins"])

	if result.has("move"):
		player.move_steps(result["move"])
		
func show_situation(player):
	print("situation")
	$TextScreen.visible = true
	
	var card = player.situation_card
	text_screen.show_screen(card["text"], "situation")

func on_tile_resolved(_player):
	end_turn()
	
func setup_player_ui():

	var ui_map = {
		"Violeta": ui_violeta,
		"Ruby": ui_ruby,
		"Celeste": ui_celeste,
		"Marino": ui_marino
	}

	for player in players:
		if ui_map.has(player.name):
			ui_map[player.name].set_player(player)
			
func _input(event):

	if event.is_action_pressed("ui_cancel"):

		if waiting_for_decision:
			return

		if $TextScreen.visible:
			return

		if $SelectionScreen.visible:
			return

		$PauseMenu.toggle_pause()
		
func _on_settings_confirmed():
	$SettingsScreen.visible = false
	$PauseMenu.visible = true

func player_reached_goal(player):

	if player.finished:
		return

	player.finished = true

	finished_players.append(player)

	player.finish_order = finished_players.size()

	print(
		player.name,
		" llegó en posición ",
		player.finish_order
	)

	check_game_end()
	
	if !game_finished:
		end_turn()
		
func check_game_end():
	if finished_players.size() == players.size():
		end_game()

func end_game():
	game_finished = true
	show_end_screen(finished_players)
	
func show_end_screen(ranking: Array):
	$EndGameScreen.show_results(ranking)

func _on_continue_button_pressed ():
		get_tree().change_scene_to_file(
		"res://scenes/MainMenu.tscn"
	)
