extends Card

var p1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")

func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board") \
		and not p1.turn_over:
			var name = get_property("Name")
			if p1.can_do_effect(name):
				## TODO: SHOW OPTION TO PLAY CARD
				p1.do_effect(name)
				move_to(cfc.NMAP.discard)
			else:
				## For now, applies to Elisha and Eliyahu
				pass ## TODO: show text saying you can't play it
