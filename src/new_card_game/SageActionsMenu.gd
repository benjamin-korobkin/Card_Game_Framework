extends PopupMenu

var board
var timeline
var field
var current_card: Card

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid1")

func _on_FieldButton_pressed() -> void:
	current_card.move_to(board, -1, field.find_available_slot())
	current_card.set_is_faceup(false)
	current_card.set_is_viewed(true)
	current_card.set_in_field(true)
	hide()
	
func _on_TimelineButton_pressed() -> void:
	var era = current_card.get_property("Era")
	var slot = get_slot(era)
	if slot.occupying_card:
		pass
	else:
		current_card.move_to(board, -1, slot)
		current_card.set_is_faceup(true)
		hide()


func get_slot(era):
	match era:
		"Tanna":
			return timeline.get_slot(0)
		"Amora":
			return timeline.get_slot(1)
		"Gaon":
			return timeline.get_slot(2)
		"Rishon":
			return timeline.get_slot(3)
		"Acharon":
			return timeline.get_slot(4)
		_:
			print("ERROR: Unknown era value")
			return

func _on_CancelButton_pressed() -> void:
	hide()
	
func set_current_card(card):
	current_card = card


func _on_ChallengeButton_pressed() -> void:
	## Used for testing for now
	print(cfc.NMAP.board.get_node("SageActionsMenu"))
