extends Card

var actionsMenu : PopupMenu
var parent : Node
var type : String
var board : Control
var fieldButton : Button
var timelineButton : Button


func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board"):
		## TODO: Control flow that gives card type (Sage vs SA)
		##     plus where the card is (hand, field, or timeline)
		##     and hide/show relevant buttons
		parent = get_parent()
		type = get_property("Type")
		board = cfc.NMAP.board
		
		if type == "Sage":
			actionsMenu = board.get_node("SageActionsMenu")
			fieldButton = actionsMenu.get_node("VBoxContainer/HBoxContainer/FieldButton")
			timelineButton = actionsMenu.get_node("VBoxContainer/HBoxContainer/TimelineButton")
			actionsMenu.set_current_card(self)
			if parent == board.get_node("Hand1"):
				fieldButton.set_visible(true)
				timelineButton.set_visible(true)
				actionsMenu.popup()
			## TODO: Set parent of card as the field when moved (currently the board)
			elif parent == board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1"):
				fieldButton.set_visible(false)
				timelineButton.set_visible(false)
				actionsMenu.popup()

