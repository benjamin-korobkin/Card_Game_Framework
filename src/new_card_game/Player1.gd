extends Player

func _ready() -> void:
	hand = board.get_node("Hand1")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid1")
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	opponent = get_parent().get_node("Player2")


func _on_Control_gui_input(event: InputEvent) -> void:
	if event.is_pressed() and not cfc.game_paused:
		#and event.get_button_index() == 1:
		draw_card("p1")
