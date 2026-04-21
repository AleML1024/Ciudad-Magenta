extends Node

enum Character_type {
	VIOLETA,
	RUBY,
	CELESTE,
	MARINO 
}

var card_banks = {
	Character_type.VIOLETA: {
		"positive": [
			{
				"id": "V_P_1",
				"text": "Violeta pasa por una zona en la cual se ubican unos depósitos de reciclaje. 
					Violeta deposita ahí la botella de plástico que llevaba para tomar agua y otros residuos reciclables. 
						Gana 6 monedas en total, pues le compran el plástico. Entonces Violeta se gana 3 monedas, y le da las otras 3 monedas a otro jugador que elige.",
				"effects": [
					{ "type": "coins", "target": "self", "value": 3 },
					{ "type": "coins", "target": "other_choice", "value": 3 }
				]
			},
			{
				"id": "V_P_2",
				"text": "Violeta se encuentra con unas bancas a la sombra, como ha caminado bastante 
					puede detenerse a descansar y recobrar energías. Gana 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": 3 }
				]
			}
		],

		"negative": [
			{
				"id": "V_N_1",
				"text": "Violeta debe pasar por una zona en la cual la calle está llena de bolsas de 
					basura abiertas porque ya no pasa el camión recolector de basura. Es difícil pasar y huele muy mal, 
						se ensucia la ropa. Pierde 3 monedas comprando otra ropa.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 }
				]
			},
			{
				"id": "V_N_2",
				"text": "Otro jugador paseaba a su perro pero olvidó las bolsas para recoger las heces 
					por lo que Violeta y su amigos las pisaron. Violeta pierde 3 monedas porque debe buscar 
						donde limpiar los zapatos y el otro jugador también pierde 3 monedas al comprar una bolsa.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 },
					{ "type": "coins", "target": "other_random", "value": -3 }
				]
			}
		],
		
		"decision" : [
			{
				"id": "V_D_1",
				"text": "Violeta va a pasar por un callejón, para tomar un atajo y ganar tiempo, pero está oscuro, porque el alumbrado no funciona.
							A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Seguir por ese camino aunque esté oscuro",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Irse por el camino más largo.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Reportar el fallo en el tendido eléctrico y la municipalidad lo soluciona.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": +3, "move": 1}
					}
				]
			}
		]
	},
	
	Character_type.RUBY: {
		"positive": [
			{
				"id": "R_P_1",
				"text": "Rubí debe pasar por una zona en la cual se topa con unos grifos de agua públicos, 
					se refresca y llena su botella. Gana 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": 3 },
					{ "type": "coins", "target": "other_choice", "value": 3 }
				]
			},
			{
				"id": "R_P_2",
				"text": "Otro jugador está sediento de tanto caminar, entonces Rubí le vende la botella 
					de agua. Por lo que Rubí gana 3 monedas y el otro jugador que elige pierde 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": 3 },
					{ "type": "coins", "target": "other_choice", "value": -3 }
				]
			}
		],

		"negative": [
			{
				"id": "R_N_1",
				"text": "Rubí debe pasar por una zona en la cual se ubica el cementerio y se ve abandonado, 
					el zacate está muy alto, las flores marchitas y el portón entreabierto. Se asusta al pasar al frente, prefiere tomar un taxi. Pierde 3 monedas pagando el taxi.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 }
				]
			},
			{
				"id": "R_N_2",
				"text": "Hay una zona en la cual hay un comerciante que arroja sus desechos al río y 
					genera malos olores. Esto también afecta a otras personas río abajo. Entonces Rubí pierde 3 monedas y elige otro jugador que también pierde 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 },
					{ "type": "coins", "target": "other_choice", "value": -3 }
				]
			}
		],
		
		"decision" : [
			{
				"id": "R_D_1",
				"text": "Rubí pasa por la fábrica que emite gases y polvo.
						A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por la zona donde está la fábrica casi que sin respirar.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Evitar la ruta donde está la fábrica y dar la vuelta.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Reportar a la municipalidad la irregularidad en la emisión de gases y polvo.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			}
		]
	},
	
	Character_type.CELESTE: {
		"positive": [
			{
				"id": "C_P_1",
				"text": "Hay una zona en la cual Celeste se topa con un mariposario y se toma fotos y aprende de las mariposas. Gana 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": 3 }
				]
			},
			{
				"id": "C_P_2",
				"text": "Celeste se pierde en el camino al concierto y puede intercambiar la posición en el tablero con otro jugador que elija, que puede estar más cerca de la meta.",
				"effects": [
					{ "type": "move", "target": "self", "value": 0 }, # Tienen que intercambiar las posiciones en el tablero
					{ "type": "move", "target": "other_choice", "value": 0 }
				]
			}
		],

		"negative": [
			{
				"id": "C_N_1",
				"text": "Celeste pasa por una zona en la cual suelen haber muchos asaltos y que no está vigilada. Es asaltada. Pierde 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 }
				]
			},
			{
				"id": "C_N_2",
				"text": "Celeste pasa por una calle sin ciclovías y los vehículos no respetan a los peatones, 
					algunos ciclistas viajan por la acera y casi son atropellados Celeste y otro jugador. Celeste pierde 3 monedas y escoge otro jugador que también pierde 3 monedas. ",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 },
					{ "type": "coins", "target": "other_choice", "value": -3 }
				]
			}
		],
		
		"decision" : [
			{
				"id": "C_D_1",
				"text": "Celeste puede pasar por una zona en la cual el césped no ha sido podado.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por esa zona en donde el césped no se ha cortado, sin saber si existen sapos, culebras, lodo o huecos.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y pasar por otra zona en donde el césped sí haya sido podado.",
						"result": { "text": "Avanzas 1 casilla y pierdes 3 monedas", "coins": -3, "move": 1}
					},
					{  
						"text": "Tomar fotos y publicar el descuido en redes sociales.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": +3, "move": 1}
					}
				]
			}
		]
	},
	
	Character_type.MARINO: {
		"positive": [
			{
				"id": "M_P_1",
				"text": "Marino va caminando y ayuda a un adulto mayor a quien se le cayó la billetera 
					y lo recompensa con 6 monedas. Marino gana 3 monedas y le regala las otras 3 monedas a otro jugador que elige.",
				"effects": [
					{ "type": "coins", "target": "self", "value": 3 },
					{ "type": "coins", "target": "other_choice", "value": 3 }
				]
			},
			{
				"id": "M_P_2",
				"text": "Marino decide avanzar un tramo en bicicleta, pero no tiene monedas para pagarla, entonces elige otro jugador quien paga 3 monedas.",
				"effects": [
					{ "type": "move", "target": "other_choice", "value": -3 },
				]
			}
		],

		"negative": [
			{
				"id": "M_N_1",
				"text": "Hay un jardín con muchos tipos de flores. Al acercarse, Marino se corta con las espinas de una rosa y necesita comprarse unas curitas. Pierde 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 }
				]
			},
			{
				"id": "M_N_2",
				"text": "Marino pasa por la cancha de fútbol, y como no hay redes, se les va la bola y 
					los niños que estaban jugando tienen que comprar otra. Pierde 3 monedas y elige a otro jugador que también pierde 3 monedas.",
				"effects": [
					{ "type": "coins", "target": "self", "value": -3 },
					{ "type": "coins", "target": "other_choice", "value": -3 }
				]
			}
		],
		
		"decision" : [
			{
				"id": "M_D_1",
				"text": "Marino puede pasar por una zona en la cual hay unos niños jugando fútbol en la calle porque la ciudad no tiene canchas para jugar.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar caminando cuidadosamente por el sector en donde están jugando fútbol.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Irse por otra ruta en la que no estén jugando bola.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			}
		]
	}
}

func draw_card(character_type, card_kind: String) -> Dictionary:
	return card_banks[character_type][card_kind].pick_random()
	
func apply_card(card: Dictionary, current_player, players: Array):
	print("Carta:", card["text"])

	for effect in card["effects"]:
		apply_effect(effect, current_player, players)
		
func apply_effect(effect: Dictionary, current_player, players: Array):
	match effect["type"]:
		"coins":
			apply_coin_effect(effect, current_player, players)
			
func apply_coin_effect(effect: Dictionary, current_player, players: Array):
	var value = effect["value"]

	match effect["target"]:
		"self":
			current_player.add_coins(value)

		"other_random":
			var others = players.filter(func(p): return p != current_player)
			if others.size() == 0:
				return
			var target = others.pick_random()
			target.add_coins(value)

		"other_choice":
			# 🔴 más adelante con UI
			print("Elegir otro jugador (pendiente)")
