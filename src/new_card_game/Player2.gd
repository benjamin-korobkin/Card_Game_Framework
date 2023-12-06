extends Player

func _ready() -> void:
	hand = board.get_node("Hand2")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid2")
	field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")

