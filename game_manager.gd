extends Node

@onready var board = $Board
@onready var card_manager = $CardManager
@onready var players = $Players.get_children()
@onready var turn_screen = $TurnScreen
var turn_in_progress := false
var ignore_decisions := true


var current_player_index := 0
var game_time := 20 * 60
var is_last_round := false
var waiting_for_decision := false

func _ready():
	print("Game started")
	
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
	if turn_in_progress:
		return

	turn_in_progress = true
	var player = players[current_player_index]

	turn_screen.show_turn(player.name)
	print("Turno de:", player.name)
		
		
func _on_turn_continue():
	turn_screen.visible = false

	var player = players[current_player_index]

	if player.is_first_turn:
		player.is_first_turn = false
		player.move_steps(1)
	else:
		start_turn()

func end_turn():
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
	waiting_for_decision = true
	print("Iniciando minijuego para", player.name)
	start_mock_minigame(player)

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
	
