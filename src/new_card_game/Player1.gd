extends Player

onready var sage_actions_menu = board.get_node("SageActionsMenu")
onready var discard_panel = board.get_node("DiscardPanel")

var is_challenging : bool = false setget set_is_challenging,get_is_challenging
var is_discarding : bool = false setget set_is_discarding,get_is_discarding

func _ready() -> void:
	hand = board.get_node("Hand1")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid")
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	opponent = get_parent().get_node("Player2")
	player_name = get_name()

func _on_DeckPanel_gui_input(event: InputEvent) -> void:
	if event.is_pressed() and not cfc.game_paused:
		if hand.is_full():
			discard_panel.popup()
			set_is_discarding(true)
		else:
			draw_card()

func add_tokens(amt):
	.add_tokens(amt)
	
func get_is_challenging():
	return is_challenging

func set_is_challenging(value):
	is_challenging = value

func get_is_discarding():
	return is_discarding

func set_is_discarding(value):
	is_discarding = value
	
func _on_Player1_action_completed() -> void:
	pass # To avoid null function call
