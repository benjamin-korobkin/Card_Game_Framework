extends Card


#var p1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")

func _on_Card_gui_input(event) -> void:
	var board = cfc.NMAP.board
	var player1 = board.get_node("TurnQueue/Player1")
	if event is InputEventMouseButton and cfc.NMAP.has("board") \
		and not player1.turn_over:
			if player1.get_is_discarding() and get_parent() == board.get_node("hand1"):
				move_to(cfc.NMAP.discard)
				player1.set_is_discarding(false)
			elif player1.can_do_effect(name):
				## TODO: SHOW OPTION TO PLAY CARD
				player1.do_effect(name)
				if name == "Eliyahu HaNavi":
					eliyahu_hanavi_effect(player1)
				else:
					#yield(get_tree().create_timer(0.7), "timeout")  # Avraham? bug
					move_to(cfc.NMAP.discard)
			else:
				pass ## TODO: disable play option for card in TanachMenu

## Used for p2 for now. Can update later for p1 as well.
func play_card(player):
	player.do_effect(name)
	if name == "Eliyahu HaNavi":
		eliyahu_hanavi_effect(player)
	else:
		#yield(get_tree().create_timer(0.7), "timeout")  # Avraham? bug
		move_to(cfc.NMAP.discard)
		player.check_turn_over()

func eliyahu_hanavi_effect(player):
	move_to(cfc.NMAP.board, -1, player.timeline.find_available_slot())
	set_is_faceup(true)
	player.check_turn_over()
	
func get_name():
	return get_card_name()
