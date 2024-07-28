extends Player

#enum ACTIONS {
#	CHALLENGE,
#	TANACH
#}

var ready_for_next_action : bool = true

export var test_mode : bool = false

func _ready() -> void:
	hand = board.get_node("Hand2")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid")
	field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")
	player_name = get_name()

func action_complete():
	ready_for_next_action = true
	
func play_turn():
	.play_turn()
	yield(get_tree().create_timer(1.0), "timeout")
	while not turn_over:
		if opponent.actions_remaining <= 0 and ready_for_next_action:
			action()

		yield(get_tree().create_timer(1.5), "timeout")
		
func action():  ## Optimize. create method(s) for getting card type
	ready_for_next_action = false
	if hand.get_card_count() == 0:
		draw_card()
		return
	var current_hand = hand.get_all_cards()
	
	if can_put_in_timeline():
		# TODO: Testing basic feature
		for card in field.get_occupying_cards():
			if card.can_go_in_timeline(self):
				put_in_timeline(card)
				return

		for card in current_hand:
			if card.get_name() == "Eliyahu HaNavi" and can_do_effect(card.get_name()):
				card.play_card(self)
				return
			if card.get_property("Type") == "Sage":
				if card.can_go_in_timeline(self): 
					put_in_timeline(card)
					return
		draw_card()
		return
	else:
		var tanach_card = null
		if field.count_available_slots() > 0:
			for card in current_hand:
				if card.get_property("Type") == "Tanach":
					if can_do_effect(card.get_name()):
						tanach_card = card
				elif card.get_property("Type") == "Sage":
					put_in_field(card)
					return
			if tanach_card:
				tanach_card.play_card(self)
				return
		else: ## If we reach this code, it means the BM is full
			for card in current_hand:  ## Play Tanach card if we have
				if card.get_property("Type") == "Tanach":
					if can_do_effect(card.get_name()):
						card.play_card(self)
						return
			var p1_field_cards = opponent.get_field().get_occupying_cards()
			if not p1_field_cards.empty(): ## Challenge
				var card_to_chlng = p1_field_cards[randi() % p1_field_cards.size()]
				for card in hand.get_all_cards():
					if card.get_property("Type") == "Sage":
						current_card = card
						challenge(card_to_chlng)
						return
	# If no other options can be performed, draw a card
	draw_card()
				

func put_in_timeline(card):
	var era = card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	## TODO: Return false if opponent's own card
	
	if moshe_effect_enabled:
		moshe_effect_enabled = false
	else:
		spend_tokens()
		deduct_action()
	if slot.occupying_card:
		slot.occupying_card.move_to(cfc.NMAP.discard)
		yield(slot.occupying_card._tween, "tween_all_completed")
		opponent.cards_in_timeline -= 1
		# TODO: TEST
		#yield(owner.get_tree().create_timer(0.75), "timeout")
	card.move_to(board, -1, slot)
	card.set_is_faceup(true)
	yield(card._tween, "tween_all_completed")
	cards_in_timeline += 1
	update_counter(actions_str, actions_remaining)
	check_turn_over()
	action_completed()
	

func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(true)  # TODO - test true
	yield(card._tween, "tween_all_completed")
	card.set_in_p2_field(true)
	deduct_action()
	update_counter(actions_str, actions_remaining)
	check_turn_over()
	action_completed()

func _on_Player2_action_completed() -> void:
	action_completed()
	
func action_completed():
	ready_for_next_action = true
