extends Node

@onready var board = $Board
@onready var card_manager = $CardManager
@onready var players = $Players.get_children()
@onready var turn_screen = $TurnScreen
@onready var decision_options_ui = $DecisionOptionsScreen/Control
@onready var decision_screen = $DecisionScreen/Control
var turn_in_progress := false
var ignore_decisions := true


var current_player_index := 0
var game_time := 20 * 60
var is_last_round := false
var waiting_for_decision := false

func _ready():
	print("Game started")
	
	waiting_for_decision = false
	for player in players:
		player.has_pending_decision = false
		player.pending_decision_card = {}
	
	$DecisionScreen.visible = false
	$DecisionOptionsScreen.visible = false
	
	decision_screen.continue_pressed.connect(_on_problem_continue)
	decision_options_ui.option_selected.connect(_on_decision_resolved)
	decision_options_ui.time_out.connect(_on_decision_timeout)
	
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

	start_turn()

func start_turn():
	if turn_in_progress or waiting_for_decision:
		return

	turn_in_progress = true
	var player = players[current_player_index]

	turn_screen.show_turn(player.name)
	print("Turno de:", player.name)
		
		
func _on_turn_continue():
	turn_screen.visible = false
	var player = players[current_player_index]
	print("Primer turno:", player.is_first_turn, "Tile:", player.tile_index)
	
	if player.has_pending_decision:
		start_decision(player)
		return

	if player.is_first_turn:
		player.is_first_turn = false
		player.move_steps(1)
	else:
		player.move_steps(1)

func end_turn():
	print("FIN TURNO:", players[current_player_index].name)
	turn_in_progress = false
	current_player_index = (current_player_index + 1) % players.size()
	start_turn()
	
func show_decision(player):
	var card = player.pending_decision_card

	if card.is_empty():
		print("DECISIÓN sin carta válida")
		return

	if not card.has("text"):
		print("Carta de decisión mal formada:", card)
		return

	print("DECISIÓN:", card["text"])

func apply_decision_option(player, option: Dictionary):
	player.has_pending_decision = false
	player.pending_decision_card = {}

	if option.has("coins"):
		player.add_coins(option["coins"])

	if option.has("move"):
		player.move_steps(option["move"])
	else:
		end_turn()
		
func start_decision(player):
	print("decision")
	waiting_for_decision = true
	$DecisionScreen.visible = true
	$DecisionOptionsScreen.visible = false
	
	var card = player.pending_decision_card
	decision_screen.show_problem(card["text"])

func resolve_decision(player, result: Dictionary):
	waiting_for_decision = false
	player.has_pending_decision = false

	if result.has("coins"):
		player.add_coins(result["coins"])

	if result.has("move") and result["move"] != 0:
		player.move_steps(result["move"])
	else:
		end_turn()
		
func start_mock_minigame(player):
	await get_tree().create_timer(1.0).timeout

	var result = {
		"coins": 3,
		"move": 1
	}
	resolve_decision(player, result)
	
func _on_decision_resolved(result: Dictionary):
	var player = players[current_player_index]
	
	$DecisionOptionsScreen.visible = false
	waiting_for_decision = false
	player.has_pending_decision = false
	
	if result.has("coins"):
		player.add_coins(result["coins"])
		
	if result.has("move"):
		await player.move_steps(result["move"])
	else:
		end_turn()

func _on_decision_timeout():
	$DecisionOptionsScreen.visible = false
	waiting_for_decision = false

	var player = players[current_player_index]
	
	print("Tiempo agotado, se aplica penalización")
	player.move_steps(1)
	end_turn()

func _on_problem_continue():
	$DecisionScreen.visible = false
	$DecisionOptionsScreen.visible = true
	
	var player = players[current_player_index]
	decision_options_ui.show_decision(player.pending_decision_card)

func on_tile_resolved(_player):
	end_turn()
