extends Player

enum ACTIONS {
	DRAW_CARD,
	CHALLENGE,
	TANACH
}
var action_options = [ACTIONS.DRAW_CARD,ACTIONS.CHALLENGE]

func _ready() -> void:
	hand = board.get_node("Hand2")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid2")
	field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")
	player_name = get_name()
	
func play_turn():
	.play_turn()
	yield(get_tree().create_timer(1.2), "timeout")
	while not turn_over:
		action()
		yield(get_tree().create_timer(0.9), "timeout")
	
func action():
	var action_played = false
	if hand.get_card_count() == 0:
		draw_card()
		action_played = true
		return
	if can_put_in_timeline():
		for card in hand.get_all_cards():
			if not action_played and card.get_property("Type") == "Sage":
				if put_in_timeline(card):
					return
					#action_played = true
		if not action_played:
			draw_card()
			return
			#action_played = true
			
	else:
		var tanach_card
		if field.count_available_slots() > 0:
			for card in hand.get_all_cards():
				if card.get_property("Type") == "Tanach":
					if can_do_effect(card.get_name()):
						tanach_card = card
				elif not action_played and card.get_property("Type") == "Sage":
					put_in_field(card)
					return
					#action_played = true
			if not action_played and tanach_card:
				tanach_card.play_card(self)
				return
				#action_played = true
		else: 
			## If no cards in opponent field, draw or play Tanach
			var p1_field_cards = opponent.get_field().get_occupying_cards()
			if p1_field_cards.empty():
				## TODO
				#var action = action_options[randi() % action_options.size()]
				#if action == ACTIONS.DRAW_CARD:
				#elif action == ACTIONS.CHALLENGE:
				draw_card()
			else:
				## Challenge opponent card
				var card_to_chlng = p1_field_cards[randi() % p1_field_cards.size()]
				for card in hand.get_all_cards():
					if not action_played and card.get_property("Type") == "Sage":
						current_card = card
						challenge(card_to_chlng)
						return
						#action_played = true
				

func put_in_timeline(card) -> bool:
	var era = card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	if slot.occupying_card:
		return false
	if moshe_effect_enabled:
		moshe_effect_enabled = false
	else:
		spend_tokens()
		deduct_action()
	card.move_to(board, -1, slot)
	card.set_is_faceup(true)
	update_counter(actions_str, actions_remaining)
	check_turn_over()
	return true
		
func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(false)
	card.set_in_p2_field(true)
	add_tokens(1)
	actions_remaining -= 1
	update_counter(actions_str, actions_remaining)
	check_turn_over()

