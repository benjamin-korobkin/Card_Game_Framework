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
	while not turn_over:
		action()
		yield(get_tree().create_timer(0.7), "timeout")
	
func action():
	if torah_tokens >= TIMELINE_COST:
		var card_placed = false
		for card in hand.get_all_cards():
			if not card_placed and card.get_property("Type") == "Sage":
				if put_in_timeline(card):
					card_placed = true
		if not card_placed:
			draw_card()
	else:
		if hand.get_card_count() == 0:
			draw_card()
		else:
			if field.count_available_slots() > 0:
				var card_placed = false
				for card in hand.get_all_cards():
					if not card_placed and card.get_property("Type") == "Sage":
						put_in_field(card)
						card_placed = true
			else:  ## TODO: Will update when we implement challenges and TAs (torah actions)
				draw_card()


func put_in_timeline(card) -> bool:
	var era = card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	if slot.occupying_card:
		return false
	else:
		spend_tokens()
		card.move_to(board, -1, slot)
		card.set_is_faceup(true)
		actions_remaining -= 1
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
