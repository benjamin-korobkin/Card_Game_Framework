extends Player

func _ready() -> void:
	hand = board.get_node("Hand2")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid2")
	field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")
	player_name = get_name()
	
func play_turn():
	.play_turn()
	yield(get_tree().create_timer(1.2), "timeout")
	actions()
	
func actions():
	draw_card()
	yield(get_tree().create_timer(0.7), "timeout")
	draw_card()
	
