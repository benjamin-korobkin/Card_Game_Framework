extends Player

onready var sage_actions_menu = board.get_node("SageActionsMenu")

var is_challenging : bool = false setget set_is_challenging,get_is_challenging
var current_card : Node2D

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
	
## TODO: Implement for player 2 as well (put in parent class)
func challenge(opponent_card):
	deduct_action()
	current_card.set_is_faceup(true)
	opponent_card.set_is_faceup(true)
	opponent_card.set_card_rotation(0) ## Not working, not a priority
	var p1_power = current_card.get_property("Power")
	var p2_power = opponent_card.get_property("Power")
	var awarded_tokens = abs(p1_power - p2_power)
	var winner
	if p1_power > p2_power:
		torah_tokens += awarded_tokens
		winner = player_name
	else:
		winner = opponent.player_name
		opponent.torah_tokens += awarded_tokens
	## TODO: uncomment this line when placing this func in parent class
	#update_counter(tokens_str,awarded_tokens)
	current_card.set_in_p1_field(false)
	opponent_card.set_in_p2_field(false)
	set_is_challenging(false)
	check_turn_over()
	yield(get_tree().create_timer(2.0), "timeout")
	current_card.move_to(cfc.NMAP.discard)
	opponent_card.move_to(cfc.NMAP.discard)
	# testing
	print("Player 1 card power: " + str(p1_power))
	print("Player 2 card power: " + str(p2_power))
	print(winner + " awarded " + str(awarded_tokens) + " token(s)!")
	
func set_current_card(card):
	current_card = card
