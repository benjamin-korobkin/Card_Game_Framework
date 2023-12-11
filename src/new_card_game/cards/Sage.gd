extends Card


func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board"):
		## TODO: Control flow that gives card type (Sage vs SA)
		##     plus where the card is (hand, field, or timeline)
		
		var actionsMenu = cfc.NMAP.board.get_node("SageActionsMenu")
		actionsMenu.set_current_card(self)
		actionsMenu.popup()

