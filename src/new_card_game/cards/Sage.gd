extends Card

var actions_menu : PopupMenu
var type : String
var board : Control
var field_button : Button
var timeline_button : Button
var challenge_button : Button
# No easy way to get grid as parent, so using attributes instead.
var in_p1_field: bool = false setget set_in_p1_field
var in_p2_field: bool = false setget set_in_p2_field

## TODO: Refactor this later, update the control flow
func _on_Card_gui_input(event) -> void:
	board = cfc.NMAP.board
	var player1 = board.get_node("TurnQueue/Player1")
	if event is InputEventMouseButton and cfc.NMAP.has("board") and not player1.turn_over:
		var hand1 = board.get_node("Hand1")

		if player1.get_is_challenging() and in_p2_field:
			player1.challenge(self)
			player1.set_is_challenging(false)
		elif player1.get_is_discarding() and get_parent() == hand1:
			move_to(cfc.NMAP.discard)
			player1.set_is_discarding(false)
		else:
			actions_menu = board.get_node("SageActionsMenu")
			field_button = actions_menu.get_node("VBoxContainer/HBoxContainer/FieldButton")
			timeline_button = actions_menu.get_node("VBoxContainer/HBoxContainer/TimelineButton")
			challenge_button = actions_menu.get_node("VBoxContainer/HBoxContainer/ChallengeButton")
			player1.set_current_card(self)

			if get_parent() == hand1:
				# enable/disable field button
				var field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
				if field.count_available_slots() > 0:
					field_button.set_disabled(false)
				else:
					field_button.set_disabled(true)
				# enable/disable timeline button
				var timeline = board.get_node("FieldTimelineContainer/TimelineGrid")
				var era = get_property("Era")
				var slot = timeline.get_slot_from_era(era)
				if slot.occupying_card or not player1.can_put_in_timeline():
					timeline_button.set_disabled(true)
				else:
					timeline_button.set_disabled(false)
				actions_menu.popup()
			# When in field, only options should be challenge or cancel
			if in_p1_field:
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
