extends Card

var p1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")

func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board") \
		and not p1.turn_over:
			var effect = get_property("Effect")
			if p1.can_do_effect(effect):
				## TODO: SHOW OPTION TO PLAY CARD
				p1.do_effect(effect)
				move_to(cfc.NMAP.discard)
