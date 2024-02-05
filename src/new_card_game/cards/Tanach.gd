extends Card
#class_name Tanach

var p1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")


func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board") \
		and not p1.turn_over:
			#var name = get_property("Name")
			if p1.can_do_effect(name):
				## TODO: SHOW OPTION TO PLAY CARD
				p1.do_effect(name)
				if name == "Eliyahu HaNavi":
					eliyahu_hanavi_effect(p1)
				else:
					#yield(get_tree().create_timer(0.7), "timeout")  # Avraham bug
					move_to(cfc.NMAP.discard)
			else:
				## For now, applies to Elisha and Eliyahu
				pass ## TODO: disable play option for card in TanachMenu (todo)

## Used for p2 for now. Can update later for p1 as well.
func play_card(player):
	player.do_effect(name)
	if name == "Eliyahu HaNavi":
		eliyahu_hanavi_effect(player)
	else:
		#yield(get_tree().create_timer(0.7), "timeout")  # Avraham bug
		move_to(cfc.NMAP.discard)

func eliyahu_hanavi_effect(player):
	move_to(cfc.NMAP.board, -1, player.timeline.find_available_slot())

func get_name():
	return name
