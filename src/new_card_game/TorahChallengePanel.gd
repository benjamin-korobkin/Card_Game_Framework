extends Panel

var correct_sage : String = ""

func _ready():
	for button in get_tree().get_nodes_in_group("torah_challenge_buttons"):
		button.connect("pressed", self, "_on_button_pressed", [button])

func _on_button_pressed(button):
	if correct_sage == "":
		print("Correct sage text is empty") # Do nothing, text not ready yet
	elif button.text == correct_sage:
		display_reward_options()
	else:
		display_failure() 

# Display the torah challenge panel with quote from card. Names from p2 BD.
# Param1: card to replace player's
func _on_Player2_replacing_p1_card(replacement_card) -> void:
	#set_visible(true) ## Set in p2 script to ensure we wait for player
	# get all names from the BD
	correct_sage = replacement_card.get_property("Name")
	var p2_beit_din = cfc.NMAP.board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	var sage_names = []
	for card in p2_beit_din.get_occupying_cards():
		sage_names.append(card.get_property("Name"))
	sage_names.shuffle()
	var button_container = get_node("VBoxContainer/HBoxContainer")
	button_container.get_node("SageOption1").text = sage_names[0]
	button_container.get_node("SageOption2").text = sage_names[1]
	button_container.get_node("SageOption3").text = sage_names[2]
	var quote = replacement_card.get_property("Teaching")
	get_node("VBoxContainer/QuoteLabel").text = quote
	_set_on_top(true)
	
## TODO: Create 2 buttons for extra card, tokens.
func display_reward_options():
	print("Correct Answer!")
	set_visible(false)

## TODO: Add "continue" button so user clearly first sees they chose wrong
func display_failure():
	print("Incorrect answer :(")
	set_visible(false)
