extends Player

onready var sage_actions_menu = board.get_node("SageActionsMenu")

var is_challenging : bool = false setget set_is_challenging,get_is_challenging

func _ready() -> void:
	hand = board.get_node("Hand1")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid1")
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	opponent = get_parent().get_node("Player2")
	player_name = get_name()
	sage_actions_menu.connect("moved_to_field", self, "add_tokens")

func _on_DeckPanel_gui_input(event: InputEvent) -> void:
	if event.is_action_released("click") and not cfc.game_paused:
		#and event.get_button_index() == 1:
		draw_card()

func add_tokens(amt):
	.add_tokens(amt)
	
func get_is_challenging():
	return is_challenging

func set_is_challenging(value):
	is_challenging = value
	

