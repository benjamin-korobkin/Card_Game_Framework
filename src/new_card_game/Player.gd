class_name Player
extends Node2D

signal action_completed

const ACTIONS_AT_START := 2
const TIMELINE_COST := 5

onready var board = get_parent().get_parent()
 
#var stats: Dictionary
var current_card : Card
var hand : Area2D
var timeline : PanelContainer
var timeline_complete = false
var field : PanelContainer
var opponent : Node2D
var actions_remaining : int
var max_torah_tokens : int = 5
var torah_tokens : int = 0
var turn_over : bool
var player_name : String
var actions_str = "_actions_remaining"
var tokens_str = "_torah_tokens"
var aharon_effect_remaining : int = 0
var moshe_effect_enabled : bool = false
var yehoshua_effect_enabled : bool = false
var cards_in_timeline : int = 0


func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	

func play_turn():
	#yield(get_tree().create_timer(0.7), "timeout")
	actions_remaining = ACTIONS_AT_START if aharon_effect_remaining == 0 else ACTIONS_AT_START - 1
	aharon_effect_remaining = max(0, aharon_effect_remaining - 1)
	
	add_tokens(field.count_filled_slots())
	update_counter(actions_str, actions_remaining)
	update_counter(tokens_str, torah_tokens)
	turn_over = false
	
func finish_turn():
	turn_over = true
	
func draw_card():
	if can_deduct_action():
		if hand.is_full() and player_name=="Player2":
			# TODO: Show that P2 is discarding
			var rand_card = randi() % (hand.hand_size - 1)  # Bug...?
			hand.get_card(rand_card).move_to(cfc.NMAP.discard)
			yield(hand.get_card(rand_card)._tween, "tween_all_completed")
			draw_card()
		else:
			deduct_action()
			hand.draw_card()
			check_turn_over()
			emit_signal("action_completed")
	else:
		print("INFO: " + player_name + " TRYING TO DRAW CARD WITH NO ACTIONS AVAILABLE")

func add_tokens(amt : int):
	torah_tokens = min(torah_tokens + amt, max_torah_tokens)
	update_counter(tokens_str, torah_tokens)
	
func is_timeline_complete():
	return timeline.count_available_slots() == 0
	
func update_counter(field_str, counter_field):
	var value_str
	if field_str == actions_str:
		value_str = str(counter_field) #+ "/" + str(ACTIONS_AT_START)
	elif field_str == tokens_str:
		value_str = str(counter_field) + "/" + str(max_torah_tokens)
	board.counters.update_counter(player_name+field_str, value_str, true)

func can_deduct_action() -> bool:
	return actions_remaining > 0
	
func deduct_action():
	if can_deduct_action():
		actions_remaining -= 1
		update_counter(actions_str, actions_remaining)
	
func can_put_in_timeline() -> bool:
	return moshe_effect_enabled or torah_tokens >= TIMELINE_COST

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
	
	yield(get_tree().create_timer(1.25), "timeout")
	player_card.move_to(cfc.NMAP.discard)
	opponent_card.move_to(cfc.NMAP.discard)
	yield(player_card._tween, "tween_all_completed")
	yield(opponent_card._tween, "tween_all_completed")
	player_card.set_in_p1_field(false)
	opponent_card.set_in_p2_field(false)
	check_turn_over()
	if player_name == "Player2":
		emit_signal("action_completed")
	
func get_field():
	return field
	
func get_timeline():
	return timeline
	
func get_hand():
	return hand
	
func reveal_opponent_bm_cards():
	for card in opponent.get_field().get_occupying_cards():
		card.set_is_viewed(true)
	
func add_bonus_actions(bonus_actions):
	actions_remaining += bonus_actions
	update_counter(actions_str, actions_remaining)

func can_do_effect(name):
	match name:
		"Eliyahu HaNavi":
			if get_timeline().get_available_slots().size() != 1 \
			or not can_put_in_timeline():
				return false
		"Elisha HaNavi": 
			if cfc.NMAP.discard.get_card_count() < 1:
				return false
		"Yaakov Avinu":  ## Must be at least 1 card in the BM
			if get_field().count_filled_slots() == 0 and \
			opponent.get_field().count_filled_slots() == 0:
				return false
		"Yehoshua": ## Must be at least 1 card in opponent BM
			if opponent.get_field().count_filled_slots() == 0:
				return false
		"Shimshon":
			if opponent.torah_tokens == 0 and torah_tokens == 0:
				return false
		"Shlomo HaMelech":
			if opponent.torah_tokens == 0:
				return false
		## TODO
		#"Yosef HaTzadik":
			#if hand.get_card_count() > cards_to_draw and player_name=="Player1":
		#		pass # TODO: Show discard popup
		_:
			return true
	return true
	
func do_effect(name):
	match name:
		"Avraham Avinu":
			add_bonus_actions(2)
		"Yitzchak Avinu":
			max_torah_tokens += 5
			update_counter(tokens_str, torah_tokens)
		"Yaakov Avinu":
			var amt = get_field().count_filled_slots() \
			+ opponent.get_field().count_filled_slots()
			add_tokens(amt)
		"Yosef HaTzadik":
			var cards_in_deck_amt = cfc.NMAP.deck.get_all_cards().size()
			var cards_to_draw = min(3,cards_in_deck_amt)
			for i in range(cards_to_draw):
				var drawn_card = hand.draw_card()
				yield(get_tree().create_timer(0.4), "timeout")
		"Aharon":
			opponent.aharon_effect_remaining = 2
		"Moshe Rabbeinu":
			moshe_effect_enabled = true
		"Yehoshua":
			yehoshua_effect_enabled = true
			reveal_opponent_bm_cards()
		"Shimshon":
			add_tokens(torah_tokens * (-1))
			opponent.add_tokens(opponent.torah_tokens * (-1))
		"David HaMelech":
			pass ## TODO: Create flag to prevent cards from being challenged
		"Shlomo HaMelech":
			var tokens_to_take = min(2, opponent.torah_tokens)
			opponent.add_tokens(-tokens_to_take)
			add_tokens(tokens_to_take)
		"Eliyahu HaNavi":
			# Implemented in Tanach.gd because requires ref to card itself
			spend_tokens()
		"Elisha HaNavi":
			yield(get_tree().create_timer(0.5), "timeout")
			hand.draw_card(cfc.NMAP.discard)

		_:
			printerr("NO MATCHING NAME FOR TANACH CARD")
	deduct_action()
	check_turn_over()
	
func get_actions_remaining():
	return actions_remaining

