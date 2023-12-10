extends Card


func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board"):
		var actionsMenu = cfc.NMAP.board.get_node("SageActionsMenu")
		actionsMenu.set_current_card(self)
		actionsMenu.popup()

## TODO: Adjust the function so it's compatible with our actions menu(s)
#check out the move_card_to_board in scriptingengine.gd for moving card to 
# panelcontainer (timeline and field grids)
