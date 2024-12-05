extends Card


#var p1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")

func _on_Card_gui_input(event) -> void:
	var board = cfc.NMAP.board
	var player1 = board.get_node("TurnQueue/Player1")
	
	if event.is_pressed() and cfc.NMAP.has("board") \
		and not player1.turn_over and get_parent() == board.get_node("Hand1") :
			if player1.get_is_discarding():
				move_to(cfc.NMAP.discard)
				yield(self._tween, "tween_all_completed")
				player1.set_is_discarding(false)
			elif player1.can_do_effect(name):
				## TODO: SHOW OPTION TO PLAY CARD
				player1.do_effect(name)
				if name == "Eliyahu HaNavi":
					eliyahu_hanavi_effect(player1)
				else:
					move_to(cfc.NMAP.temppile)
					yield(get_tree().create_timer(1.5), "timeout")
					move_to(cfc.NMAP.discard)
					yield(self._tween, "tween_all_completed")
			else:
				pass ## TODO: disable play option for card in TanachMenu

## Used for p2 for now. Can update later for p1 as well.
func play_card(player):
	set_is_faceup(true)
	if name == "Eliyahu HaNavi":
		eliyahu_hanavi_effect(player)
	else:
		move_to(cfc.NMAP.temppile)
		player.do_effect(name) # discard card after affect done
		yield(get_tree().create_timer(1.5), "timeout")
		move_to(cfc.NMAP.discard)
		yield(self._tween, "tween_all_completed")
	player.check_turn_over()
	player.emit_signal("action_completed")

func eliyahu_hanavi_effect(player):
	player.cards_in_timeline += 1
	set_is_faceup(true) # Test putting this first
	move_to(cfc.NMAP.board, -1, player.timeline.find_available_slot())
	yield(self._tween, "tween_all_completed")
	player.finish_turn()
	player.check_turn_over()
	
func get_name():
	return get_card_name()
