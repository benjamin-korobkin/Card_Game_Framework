extends PopupMenu

var board
var timeline
var field
var player1
var current_card: Card

signal moved_to_field

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid1")
	player1 = board.get_node("TurnQueue/Player1")

func _on_FieldButton_pressed() -> void:
	if player1.can_deduct_action():
		current_card.move_to(board, -1, field.find_available_slot())
		current_card.set_is_faceup(false)
		current_card.set_is_viewed(true)
		current_card.set_in_field(true)
		hide()
		emit_signal("moved_to_field", 1)
		player1.check_turn_over()
	else:
		print("ERROR: FIELD BUTTON PRESSED WITH NO ACTIONS REMAINING")
	
func _on_TimelineButton_pressed() -> void:
	var era = current_card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	if slot.occupying_card:
		pass
	else:
		player1.spend_tokens()
		current_card.move_to(board, -1, slot)
		current_card.set_is_faceup(true)
		hide()
		player1.check_turn_over()


## TODO: Change cancel button to big X on top left of popup menu
func _on_CancelButton_pressed() -> void:
	hide()
	
func set_current_card(card):
	current_card = card


func _on_ChallengeButton_pressed() -> void:
	## Used for testing for now
	print(current_card.position)
	#print(current_card)
