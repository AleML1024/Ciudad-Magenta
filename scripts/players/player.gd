extends Node2D

var tile_index := 0
var coins := 20
var has_pending_decision := false
var pending_decision_card: Dictionary = {}
var situation_card: Dictionary = {}
var is_first_turn := true
var is_first_decision := true
var finished := false
var finish_order := -1

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

signal coins_changed(new_value)

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
			0.7
		)
		await tween.finished
		
	if tile_index == board.tiles_positions.size() - 1:
		game_manager.player_reached_goal(self)
		return
	resolve_tile()

func resolve_tile():
	var tile = board.get_tile(tile_index)

	match tile["type"]:
		board.tile_type.POSITIVE:
			situation_card = game_manager.card_manager.draw_card(
				character_type,
				"positive"
			)
			game_manager.show_situation(self)		
			
		board.tile_type.NEGATIVE:
			situation_card = game_manager.card_manager.draw_card(
				character_type,
				"negative"
			)
			game_manager.show_situation(self)
			
		board.tile_type.DECISION:
			if is_first_decision:
				print("es la primera decision que tomo")
				has_pending_decision = true
				pending_decision_card = game_manager.card_manager.draw_card(
					character_type,
					"decision"
				)
				is_first_decision = false
				game_manager.start_decision(self)
				
			else:
				print("me guardo la decision para mi siguiente turno")
				has_pending_decision = true
				pending_decision_card = game_manager.card_manager.draw_card(
					character_type,
					"decision"
				)
				is_first_decision = true
				game_manager.on_tile_resolved(self)

		board.tile_type.ADVANCE:
			move_steps(tile["value"])

func add_coins(amount: int):
	coins += amount
	coins = max(coins, 0)
	print(name, "monedas:", coins)
	emit_signal("coins_changed", coins)
	
func get_character_name() -> String:
	match character_type:
		Character_type.VIOLETA: return "Violeta"
		Character_type.RUBY: return "Ruby"
		Character_type.CELESTE: return "Celeste"
		Character_type.MARINO: return "Marino"
	return "Jugador"


func get_character_color() -> Color:
	match character_type:
		Character_type.VIOLETA: return Color("a259ffba")
		Character_type.RUBY: return Color("ff4d4dba")
		Character_type.CELESTE: return Color("6fc3ffba")
		Character_type.MARINO: return Color("1b3b6fba")
	return Color.WHITE


func get_character_portrait() -> Texture2D:
	match character_type:
		Character_type.VIOLETA:
			return preload("res://assets/characters/VioletaAvatar.PNG")
		Character_type.RUBY:
			return preload("res://assets/characters/RubíAvatar.PNG")
		Character_type.CELESTE:
			return preload("res://assets/characters/CelesteAvatar.PNG")
		Character_type.MARINO:
			return preload("res://assets/characters/MarinoAvatar.PNG")
	return null
