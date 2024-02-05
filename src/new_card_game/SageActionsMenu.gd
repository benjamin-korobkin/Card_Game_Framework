extends PopupMenu

var board
var timeline
var field
var p1
var current_card: Card
var challenge_panel

signal moved_to_field

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid1")
	p1 = board.get_node("TurnQueue/Player1")
	challenge_panel = board.get_node("ChallengePanel")
	

func _on_FieldButton_pressed() -> void:
	if p1.can_deduct_action():
		p1.deduct_action()
		p1.current_card.move_to(board, -1, field.find_available_slot())
		p1.current_card.set_is_faceup(false)
		p1.current_card.set_is_viewed(true)
		p1.current_card.set_in_p1_field(true)
		hide()
		emit_signal("moved_to_field", 1)
		p1.check_turn_over()
	else:
		print("ERROR: FIELD BUTTON PRESSED WITH NO ACTIONS REMAINING")
	
func _on_TimelineButton_pressed() -> void:
	var era = p1.current_card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	if not slot.occupying_card and p1.can_deduct_action():
		if p1.moshe_effect_enabled:
			p1.moshe_effect_enabled = false
		else:
			p1.deduct_action()
			p1.spend_tokens()
		p1.current_card.move_to(board, -1, slot)
		p1.current_card.set_is_faceup(true)
		hide()
		p1.check_turn_over()


## TODO: Change cancel button to big X on top left of popup menu
func _on_CancelButton_pressed() -> void:
	hide()

func _on_ChallengeButton_pressed() -> void:
	if p1.can_deduct_action():
		hide()
		challenge_panel.popup()
		p1.set_is_challenging(true)
	else:
		print("ERROR: CHALLENGE BUTTON PRESSED WITH NO ACTIONS REMAINING")
	
	
	
