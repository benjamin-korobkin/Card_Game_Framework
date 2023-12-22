class_name Player
extends Node2D

const ACTIONS_AT_START := 2
const TIMELINE_COST := 5

onready var board = get_parent().get_parent()

 
#var stats: Dictionary
var hand : Area2D
var timeline : PanelContainer
var timeline_complete = false
var field : PanelContainer
var opponent : Node2D
var actions_remaining : int
var torah_tokens : int = 0
var turn_over : bool
var player_name : String
var actions_str = "_actions_remaining"
var tokens_str = "_torah_tokens"
var current_card : Card

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	

func play_turn():
	yield(get_tree().create_timer(1.0), "timeout")
	actions_remaining = ACTIONS_AT_START
	add_tokens(field.count_filled_slots())
	update_counter(actions_str, actions_remaining)
	update_counter(tokens_str, torah_tokens)
	turn_over = false
	
func draw_card():
	if can_deduct_action():
		deduct_action()
		hand.draw_card()
		check_turn_over()
	else:
		print("INFO: TRYING TO DRAW CARD WITH NO ACTIONS AVAILABLE")

func add_tokens(amt):
	torah_tokens += amt
	update_counter(tokens_str, torah_tokens)

func finish_turn():
	turn_over = true
	
func is_timeline_complete():
	return timeline.count_available_slots() == 0
	
func update_counter(field_str, counter_field):
	board.counters.mod_counter(player_name+field_str, counter_field, true)

func can_deduct_action() -> bool:
	return actions_remaining > 0
	
func deduct_action():
	if can_deduct_action():
		actions_remaining -= 1
		update_counter(actions_str, actions_remaining)
	
func can_spend_tokens() -> bool:
	return torah_tokens >= TIMELINE_COST

func spend_tokens():
	torah_tokens -= TIMELINE_COST
	update_counter(tokens_str,torah_tokens)
	
func check_turn_over():
	get_parent().check_turn_over()

func set_current_card(card):
	current_card = card
	
func challenge(opponent_card):
	deduct_action()
	var player_card
	if player_name=="Player1":
		player_card = current_card ## to overcome a bug with current_card
	else:
		player_card = opponent_card
		opponent_card = current_card
	## Move both cards to field margin containers
	var challenge_grid1 = board.get_node("FieldTimelineContainer/FieldHBox1/FieldMarginContainer1")
	var challenge_grid2 = board.get_node("FieldTimelineContainer/FieldHBox2/FieldMarginContainer2")
	player_card.move_to(board, -1, challenge_grid1.get_global_position())
	opponent_card.move_to(board, -1, challenge_grid2.get_global_position())
	opponent_card.set_card_rotation(0)
	player_card.set_is_faceup(true)
	opponent_card.set_is_faceup(true)
	var p1_power = player_card.get_property("Power")
	var p2_power = opponent_card.get_property("Power")
	var awarded_tokens = abs(p1_power - p2_power)
	if p1_power > p2_power:
		add_tokens(awarded_tokens)
	else:
		opponent.add_tokens(awarded_tokens)
	player_card.set_in_p1_field(false)
	opponent_card.set_in_p2_field(false)
	
	yield(get_tree().create_timer(2.0), "timeout")
	player_card.move_to(cfc.NMAP.discard)
	opponent_card.move_to(cfc.NMAP.discard)
	check_turn_over()
	
func get_field():
	return field
