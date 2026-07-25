extends CanvasLayer

signal continue_pressed

@onready var ranking_rows = [
	$Ranking/FirstPlace,
	$Ranking/SecondPlace,
	$Ranking/ThirdPlace,
	$Ranking/FourthPlace
]

@onready var coin_winner_label = $HBoxContainer/CoinContainer


func _ready():

	visible = false


func show_results(ranking: Array):

	visible = true

	# Mostrar ranking
	for i in range(ranking_rows.size()):

		var row = ranking_rows[i]

		if i >= ranking.size():
			row.visible = false
			continue

		row.visible = true

		var player = ranking[i]

		row.get_node("PlayerName").text = player.get_character_name()

		row.get_node("PlayerCoins").text = str(player.coins)

		# Color del jugador
		row.get_node("PlayerName").modulate = player.get_character_color()


	# Buscar ganador por monedas
	var coin_winner = ranking[0]

	for player in ranking:

		if player.coins > coin_winner.coins:
			coin_winner = player

	coin_winner_label.get_node("PlayerName").text = coin_winner.get_character_name()
	coin_winner_label.get_node("CoinCounter").text = str(coin_winner.coins)

func _on_button_pressed() -> void:
	emit_signal("continue_pressed")
