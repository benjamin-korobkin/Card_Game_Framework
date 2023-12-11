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
	hide()
	
func _on_TimelineButton_pressed() -> void:
	current_card.move_to(board, -1, timeline.find_available_slot())
	current_card.set_is_faceup(true)
	hide()

func _on_CancelButton_pressed() -> void:
	hide()
	
func set_current_card(card):
	current_card = card
