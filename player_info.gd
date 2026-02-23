extends Control

@onready var name_label = $PanelContainer/VBoxContainer/TopRow/Label
@onready var color_rect = $PanelContainer/VBoxContainer/TopRow
@onready var portrait = $PanelContainer/VBoxContainer/BottomRow/TextureRect
@onready var coin_label = $PanelContainer/VBoxContainer/BottomRow/CoinContainer/Label

var player_ref = null

func set_player(player):
	player_ref = player
	name_label.text = player.name
	update_coins(player.coins)
	
	portrait.texture = player.get_character_portrait()

	color_rect.self_modulate = player.get_character_color()
	
	player.coins_changed.connect(update_coins)

func update_coins(value):
	coin_label.text = str(value)
