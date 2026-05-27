extends Node2D

enum tile_type {
	START,
	ADVANCE,
	BACK,
	POSITIVE,
	NEGATIVE,
	DECISION,
	GOAL
}

var tiles_positions = []

var tiles_data = [
	{"type": tile_type.START, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.GOAL, "value": 0},
	{"type": tile_type.START, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.GOAL, "value": 0},
	{"type": tile_type.START, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.GOAL, "value": 0},
	{"type": tile_type.START, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.POSITIVE, "value": 0},
	{"type": tile_type.DECISION, "value": 0},
	{"type": tile_type.ADVANCE, "value": 2},
	{"type": tile_type.ADVANCE, "value": 1},
	{"type": tile_type.NEGATIVE, "value": 0},
	{"type": tile_type.GOAL, "value": 0},
]


func _ready():
	for tile in $Tiles.get_children():
		tiles_positions.append(tile.global_position)
		
func get_tile(tile_index: int) -> Dictionary:
	return tiles_data[tile_index]
	
func get_start_tiles() -> Array[int]:
	var starts : Array[int] = []
	for i in range(tiles_data.size()):
		if tiles_data[i]["type"] == tile_type.START:
			starts.append(i)
	return starts
