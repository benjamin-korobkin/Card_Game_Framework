# new_card_game/Deck.gd, copied from CGFDeck.gd
extends Pile

#signal draw_card(deck)

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	# warning-ignore:return_value_discarded
	#$Control.connect("gui_input", self, "_on_Deck_input_event")
	# warning-ignore:return_value_discarded
	##connect("draw_card", cfc.NMAP.hand1, "draw_card")
	#connect("draw_card", cfc.NMAP.hand2, "draw_card")
	#print(get_signal_connection_list("input_event")[0]['target'].name)
