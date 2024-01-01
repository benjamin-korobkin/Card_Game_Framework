extends Card

var player1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")

func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board") \
		and not player1.turn_over:
			var effect = get_property("Effect")
			if effect == "Gain 3 actions":
				player1.actions_remaining += 3
				player1.deduct_action()
				move_to(cfc.NMAP.discard)
