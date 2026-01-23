extends Node2D

var tile_index := 0
var coins := 20
var has_pending_decision := false
var pending_decision_card: Dictionary = {}
var is_first_turn := true

var board: Node = null
var game_manager: Node =null

enum Character_type {
	VIOLETA, 
	RUBY,
	CELESTE,
	MARINO,
}

@export var character_type: Character_type
@export var start_tile_index := 0

func place_on_start():
	tile_index = start_tile_index
	global_position = board.tiles_positions[tile_index]
	
func set_board(board_ref):
	board = board_ref
	global_position = board.tiles_positions[tile_index]

func set_game_manager(gm):
	game_manager = gm
	
func move_steps(steps: int):
	for i in range(steps):
		tile_index += 1
		tile_index = min(tile_index, board.tiles_positions.size() - 1)

		var tween = create_tween()
		tween.tween_property(
			self,
			"global_position",
			board.tiles_positions[tile_index],
			0.3
		)
		await tween.finished
	resolve_tile()

func resolve_tile():
	var tile = board.get_tile(tile_index)

	match tile["type"]:
		board.tile_type.POSITIVE:
			# aplicar carta
			game_manager.on_tile_resolved(self)
			
		board.tile_type.NEGATIVE:
			# aplicar carta
			game_manager.on_tile_resolved(self)

		board.tile_type.DECISION:
			if has_pending_decision:
				return

			has_pending_decision = true
			pending_decision_card = game_manager.card_manager.draw_card(
				character_type,
				"decision"
			)

			game_manager.start_decision(self)
			return

		board.tile_type.ADVANCE:
			move_steps(tile["value"])

func add_coins(amount: int):
	coins += amount
	coins = max(coins, 0)
	print(name, "monedas:", coins)
