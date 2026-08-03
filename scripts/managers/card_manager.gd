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
						"text": "Seguir por ese camino aunque esté oscuro.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Irse por el camino más largo.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Reportar el fallo en el tendido eléctrico y la municipalidad lo soluciona.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "V_D_2",
				"text": "Violeta pasa por una calle en la cual están arreglando la acera y es más rápido pasar por la calle.  Hay otra acera en mejor estado, pero hay que desviarse. 
							A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "pasar por la calle de la construcción.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Pasar por la acera en buen estado.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			},
			{
				"id": "V_D_3",
				"text": "Para llegar al concierto Violeta debe cruzar una intersección de 3 carriles por cada sentido. El paso peatonal más próximo está a 500 metros.
							A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Cruzar primero un sentido y luego el otro.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Ir hasta la zona en donde hay paso peatonal.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			},
			{
				"id": "V_D_4",
				"text": "Violeta debe cruzar al otro lado de la calle, pero el semáforo está dañado.
							A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "pasar por la zona donde no hay semáforo.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Caminar hasta encontrar el semáforo más pronto.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Solicitar a la municipalidad que repare el semáforo dañado.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "V_D_5",
				"text": "Violeta debe pasar por un puente sobre un río. El puente está falseado porque existe un deslizamiento provocado por el exceso de agua y las crecidas del río.
							A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por el puente.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Evitar la ruta alterna y dar la vuelta por la calle principal que va al centro.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Reportar a la municipalidad para que clausuren el puente.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
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
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "R_D_2",
				"text": "Rubí debe pasar aceras que están descuidadas y rotas o bien caminar por la cuneta del lado contrario, para poder pasar, ya que por ese trayecto hay una curva peligrosa y no permite ver los carros que vienen en sentido contrario.
						A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por la cuneta vigilando los carros que pasan en sentido contrario.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y buscar una ruta con aceras en buen estado.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			},
			{
				"id": "R_D_3",
				"text": "Rubí pasa por una zona en la cual la calle está inundada por las lluvias y las alcantarillas se desbordaron.
						A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por la calle inundada y tantear el fondo de la calle, para detectar los caños, los huecos o las alcantarillas.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y buscar por donde pasar la calle donde no está tan inundado.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Agarrarse de las rejas de los portones y pasar por la acera.",
						"result": { "text": "Avanzas 1 casilla y pierdes 3 monedas", "coins": -3, "move": 1}
					}
				]
			},
			{
				"id": "R_D_4",
				"text": "La acera y la calle está llena de hojas y cáscaras de verduras y algunos restos de fruta y verdura que se perdió de la última feria del agricultor , y como ya no hay barrenderos no han limpiado la calle.
						A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por la calle sucia brincando entre las cáscaras ¡qué asco!.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "ir a buscar un escobón en la casa cercana de mi amigo y entre todos limpiar un poco la calle y acera.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					},
					{  
						"text": "Denunciarlo ante la administración de la Feria del Agricultor.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			},
			{
				"id": "R_D_5",
				"text": "Rubí debe pasar por una zona en la cual la acera no tiene árboles que den sombra, como en otras partes, en la que hay árboles floreados al lado de la acera.
						A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por la acera sin árboles y sudarse la ropa para el concierto, ya que el sol está muy fuerte.",
						"result": { "text": "Avanzas 2 casillas y no pierdes monedas", "coins": 0, "move": 2}
					},
					{  
						"text": "Caminar más lento para no sudar la ropa.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					},
					{  
						"text": "Aplicarse bloqueador solar.",
						"result": { "text": "Avanzas 3 casilla y pierdes 3 monedas", "coins": -3, "move": 3}
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
					{ "type": "swap_position", "target": "other_choice"}
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
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "C_D_2",
				"text": "Celeste cruza por la zona en donde el ascensor del puente peatonal para personas discapacitadas pero está descompuesto.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Atravesar la calle corriendo.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dan la vuelta para buscar una ruta alterna.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			},
			{
				"id": "C_D_3",
				"text": "Celeste puede pasar por una zona en la cual hay un hidrante de agua que se ha reventado, pero no ha sido atendido.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por esa zona en donde la acera está mojada, con cuidado de no caerse y mojarse.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y pasar por otra zona en donde la acera no esté mojada.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					}
				]
			},
			{
				"id": "C_D_4",
				"text": "Celeste puede pasar por una zona en la cual hay una reparación de la acera que nunca fue completada.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por esa zona en donde la acera está en reparación, con cuidado de no caerse.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y pasar por otra zona en donde la acera no esté en reparación.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Tomar fotos y publicar el descuido en redes sociales.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "C_D_5",
				"text": "Celeste puede pasar por una zona en la cual hay una construcción que no ha levantado toldos que protejan a la gente del polvo.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por esa zona en donde está la construcción, con cuidado de no caerse.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "dar la vuelta y pasar por otra zona en donde no haya tanto polvo.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "denunciar la construcción ante la municipalidad por no levantar toldos.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
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
			},
			{
				"id": "M_D_2",
				"text": "Marino debe subir la escalinata o las gradas de la Catedral, para luego atravesar el parquecito del lado y ahorrar tiempo.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Subir las gradas y ayudar a su amiga Celeste a subir alzando la silla.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Irse por otra ruta en la que sí haya rampa para acceder a la acera.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					},
					{  
						"text": "Llamar a la municipalidad haciéndoles saber sobre la falta de rampas.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "M_D_3",
				"text": "Marino puede pasar por una zona en la cual hay unos perros callejeros peleando.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por esa zona en donde los animales están peleando.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y pasar por otra zona en donde no haya animales.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Llamar a control de animales para que apacigüe a los animales.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "M_D_4",
				"text": "Marino pasa por una zona en la cual hay una construcción abandonada que nunca fue completada. Hay un gran agujero en la zona.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Bajar con cuidado en el agujero.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y evitar esa zona de construcción.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
					}
				]
			},
			{
				"id": "M_D_5",
				"text": "Marino puede pasar por una zona en la cual hay unos carros que están estacionados y están acaparando la acera, y como resultado, no hay cómo cruzar por la acera.
					A continuación deberás de tomar una decisión en un máximo de 60 segundos.",
				"options" : [
					{  
						"text": "Pasar por esa zona y caminar por la cuneta con cuidado de no ser atropellado por un vehículo.",
						"result": { "text": "Avanzas 2 casillas y pierdes 3 monedas", "coins": -3, "move": 2}
					},
					{  
						"text": "Dar la vuelta y pasar por otra zona en donde sí haya campo de caminar por la acera.",
						"result": { "text": "Avanzas 1 casilla y no pierdes monedas", "coins": 0, "move": 1}
					},
					{  
						"text": "Reportar la situación ante la municipalidad para que ordenen la movilización de los vehículos.",
						"result": { "text": "Avanzas 1 casilla y ganas 3 monedas", "coins": 3, "move": 1}
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
