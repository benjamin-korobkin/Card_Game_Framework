extends Card

var actions_menu : PopupMenu
var type : String
var board : Control
var field_button : Button
var timeline_button : Button
var challenge_button : Button
# No easy way to get grid as parent, so using attributes instead.
var in_p1_field: bool = false setget set_in_p1_field,get_in_p1_field
var in_p2_field: bool = false setget set_in_p2_field,get_in_p1_field

## TODO: Refactor this later, update the control flow
func _on_Card_gui_input(event) -> void:
	board = cfc.NMAP.board
	var player1 = board.get_node("TurnQueue/Player1")

	if event is InputEventMouseButton and cfc.NMAP.has("board") and not player1.turn_over:
		var hand1 = board.get_node("Hand1")

		if player1.get_is_challenging() and get_in_p2_field():
			player1.challenge(self)
			player1.set_is_challenging(false)
			if board.get_name() == "Tutorial":
				board.advance_tutorial()
		elif player1.get_is_discarding() and get_parent() == hand1:
			move_to(cfc.NMAP.discard)
			yield(self._tween, "tween_all_completed")
			player1.set_is_discarding(false)
		else:
			var field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
			actions_menu = board.get_node("SageActionsMenu")
			field_button = actions_menu.get_node("VBoxContainer/HBoxContainer/FieldButton")
			timeline_button = actions_menu.get_node("VBoxContainer/HBoxContainer/TimelineButton")
			challenge_button = actions_menu.get_node("VBoxContainer/HBoxContainer/ChallengeButton")
			player1.set_current_card(self)

			if player1.can_put_in_timeline() and can_go_in_timeline(player1):
				timeline_button.set_disabled(false)
			else:
				timeline_button.set_disabled(true)
			
			if get_parent() == hand1:
				# enable/disable field button
				if field.count_available_slots() > 0:
					field_button.set_disabled(false)
				else:
					field_button.set_disabled(true)
				# timeline_button.set_disabled(true) ## We'll see. Maybe
				actions_menu.popup()
			# When in field, options can be timeline, challenge, or cancel
			if in_p1_field:
				field_button.set_disabled(true)
				actions_menu.popup()
			var p2_field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
			if p2_field.count_filled_slots() == 0:
				challenge_button.set_disabled(true)
			else:
				challenge_button.set_disabled(false)
				
			## TUTORIAL CODE
			tutorial_checks(player1)
				
func tutorial_checks(player):
	if board.get_name() == "Tutorial":
		field_button.set_disabled(true)
		timeline_button.set_disabled(true)
		challenge_button.set_disabled(true)
		match board.get_tutorial_state():
			"WAITING_FOR_CHALLENGE":
				challenge_button.set_disabled(false)
			"WAITING_FOR_BM":
				field_button.set_disabled(false)
			"WAITING_FOR_TIMELINE": # For BD, only the Tanna can go in
				if player.can_put_in_timeline() and can_go_in_timeline(player):
					timeline_button.set_disabled(false)
				else:
					timeline_button.set_disabled(true)	
			_:
				pass			

			
func set_in_p1_field(value):
	in_p1_field = value
	
func get_in_p1_field():
	return in_p1_field

func set_in_p2_field(value):
	in_p2_field = value

func get_in_p2_field():
	return in_p2_field

	
func can_go_in_timeline(player) -> bool:
	var era = get_property("Era")
	# TODO: Update - move the get_timeline() method to board. Only 1 now.
	var slot = player.get_timeline().get_slot_from_era(era)
	if slot.occupying_card:
		# Check if card is from hand or if belongs to current player
		if get_parent() == player.hand or \
			slot.occupying_card.get_card_owner() == get_card_owner():
			return false
		if player.get_field().count_available_slots() == 0:
			return true
		return false # Don't have a beit din
	if get_parent() == player.hand:  # make sure card is coming from hand
		return true
	return false  # open slot, but card from BM, not hand
