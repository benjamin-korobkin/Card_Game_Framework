extends Card


var actionsMenu : PopupMenu
var type : String
var board : Control
var fieldButton : Button
var timelineButton : Button
## No easy way to get grid as parent, so using attributes instead.
var in_field: bool = false setget set_in_field


func _on_Card_gui_input(event) -> void:
	if event is InputEventMouseButton and cfc.NMAP.has("board"):
		## TODO: Control flow that gives card type (Sage vs SA)
		##     plus where the card is (hand, field, or timeline)
		##     and enable relevant buttons
		type = get_property("Type")
		board = cfc.NMAP.board
		
		if type == "Sage":
			actionsMenu = board.get_node("SageActionsMenu")
			fieldButton = actionsMenu.get_node("VBoxContainer/HBoxContainer/FieldButton")
			timelineButton = actionsMenu.get_node("VBoxContainer/HBoxContainer/TimelineButton")
			actionsMenu.set_current_card(self)
			if get_parent() == board.get_node("Hand1"):
				fieldButton.set_disabled(false)
				timelineButton.set_disabled(false)
				actionsMenu.popup()
			elif in_field:
				fieldButton.set_disabled(true)
				timelineButton.set_disabled(true)
				actionsMenu.popup()
			
func set_in_field(value):
	in_field = value
