extends Card


var actions_menu : PopupMenu
var type : String
var board : Control
var field_button : Button
var timeline_button : Button
var challenge_button : Button
## No easy way to get grid as parent, so using attributes instead.
var in_p1_field: bool = false setget set_in_p1_field
var in_p2_field: bool = false setget set_in_p2_field
var player1 : Node2D = cfc.NMAP.board.get_node("TurnQueue/Player1")

## TODO: Refactor this later, update the control flow
func _on_Card_gui_input(event) -> void:
	# Don't allow player to click cards if it's not our turn
	if event is InputEventMouseButton and cfc.NMAP.has("board") \
		and not player1.turn_over:
		board = cfc.NMAP.board
		type = get_property("Type")
		
		if player1.get_is_challenging() and in_p2_field:
				player1.challenge(self)
				
		
		elif type == "Sage":
			player1.set_current_card(self)
			actions_menu = board.get_node("SageActionsMenu")
			field_button = actions_menu.get_node("VBoxContainer/HBoxContainer/FieldButton")
			timeline_button = actions_menu.get_node("VBoxContainer/HBoxContainer/TimelineButton")
			challenge_button = actions_menu.get_node("VBoxContainer/HBoxContainer/ChallengeButton")
			
			
			if get_parent() == board.get_node("Hand1"):
				# enable/disable field button
				var field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
				if field.count_available_slots() > 0:
					field_button.set_disabled(false)
				else:
					field_button.set_disabled(true)
				# enable/disable timeline button
				var timeline = board.get_node("FieldTimelineContainer/TimelineGrid1")
				var era = get_property("Era")
				var slot = timeline.get_slot_from_era(era)
				if slot.occupying_card or not player1.can_spend_tokens():
					timeline_button.set_disabled(true)
				else:
					timeline_button.set_disabled(false)
				actions_menu.popup()
			# When in field, only options should be challenge or cancel
			elif in_p1_field:
				field_button.set_disabled(true)
				timeline_button.set_disabled(true)
				actions_menu.popup()
			var p2_field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
			if p2_field.count_filled_slots() == 0:
				challenge_button.set_disabled(true)
			else:
				challenge_button.set_disabled(false)
			
func set_in_p1_field(value):
	in_p1_field = value

func set_in_p2_field(value):
	in_p2_field = value
