extends Panel


# Display the torah challenge panel with quote from card. Names from p2 BD.
# Param1: card to replace player's
func _on_p2_replaced_p1_card(replacing_card) -> void:
	set_visible(true)
	# get all names from the BD
	var p2_beit_din = cfc.NMAP.board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	var sage_names = []
	for card in p2_beit_din.get_occupying_cards():
		sage_names.append(card.get_property("Name"))
	sage_names.shuffle()
	var button_container = get_node("VBoxContainer/HBoxContainer")
	button_container.get_node("Option1").text = sage_names[0]
	button_container.get_node("Option2").text = sage_names[1]
	button_container.get_node("Option3").text = sage_names[2]
	var quote = replacing_card.get_property("Teaching")
	get_node("VBoxContainer/QuoteLabel").text = quote
	_set_on_top(true)
