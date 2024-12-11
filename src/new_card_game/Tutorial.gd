extends Control

onready var tutorial_panel = $CanvasLayer/TutorialPanel
onready var tutorial_label = tutorial_panel.get_node("CenterContainer/VBoxContainer/TutorialLabel")
onready var tutorial_next_button = tutorial_panel.get_node("CenterContainer/VBoxContainer/NextButton")
onready var node_to_reveal = null

onready var tutorial_steps = [
	{"text": """
		This grid <show grid> in the center is the Torah Timeline. 
		It contains 5 slots, one for each of the following 5 eras: 
			Tanna, Amora, Gaon, Rishon, and Acharon. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $FieldTimelineContainer/TimelineGrid},
	{"text": """
		You start the game with 3 cards. You get 2 actions per turn. Actions include:
		1. Drawing a card
		2. Putting a card in the Beit Midrash (BM)
		3. Placing a card in the Timeline (costs 5 tokens)
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $FieldTimelineContainer/TimelineGrid},
	{"text": """This deck <show deck> is shared between you and your opponent. 
		Click it to draw a card. 
		""", "state": "WAITING_FOR_DRAW", "reveal_node": $FieldTimelineContainer/TimelineGrid},
	{"text": """Notice you have one action left 
		after drawing a card <show action counter>. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null},
	{"text": """Now, click a Sage card and click Beit Midrash. 
		""", "state": "WAITING_FOR_BM", "reveal_node": null},
	{"text": """You've used 2 actions, so now it's your opponent's turn. 
		<Opponent plays a turn> 
		""", "state": "WAITING_FOR_AI", "reveal_node": null},
	{"text": """This grid <show BM> is your Beit Midrash (BM). 
		At the start of your turns, 
		you earn 1 token for each Sage card in your BM (up to 3 tokens). 
		You have 1 card in your BM, so you've earned 1 token.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null},
	{"text": """For this tutorial, we'll allow you to place a card 
		in the Timeline for free. 
		Select a Sage in your hand and click Timeline. <Put Sage in Timeline>
		""", "state": "WAITING_FOR_TIMELINE", "reveal_node": null},
	{"text": """Let's fast forward a little bit… 
		Press the button for the next part of the tutorial. 
		""", "state": "WAITING_FOR_NEXT_FF", "reveal_node": null},
	{"text": """	Your Beit Midrash is now full, giving it the status of a BEIT DIN. 
		With a Beit Din, you can REPLACE a Sage in the Timeline, 
		if you fulfill the following criteria:
		a. You have 5 tokens to spend
		b. A Sage in your Beit Din matches the era of the Sage you are replacing
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null},
	{"text": """Select the Tanna in your Beit Din and click Timeline 
		to replace the opponent's Tanna in the Timeline <Replace Sage in Timeline>
		""", "state": "WAITING_FOR_REPLACE", "reveal_node": null},
	{"text": """Well done! Keep in mind your opponent can also replace your cards.
		This is where the Challenge action comes in handy. 
		Select a Sage card, click Challenge, and select a card in your 
		opponent's Beit Midrash. <Do the Challenge>
		""", "state": "WAITING_FOR_CHALLENGE", "reveal_node": null},
	{"text": """In a challenge, both cards end up in the Olam haba (discard) pile. 
		However, the card with the higher era/number gains tokens. 
		The bigger the difference in era, the more tokens you earn. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null},
	{"text": """One last thing before we go: Tanach cards! 
		These are non-Sage cards that can give you an advantage. 
		Use them wisely! <Show a Tanach card>
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null},
	{"text": """You now have everything you need to start playing! 
		Come back here whenever you need a refresher. 
		Press the button to return to the main menu.
		""", "state": "WAITING_FOR_END", "reveal_node": null},
	]
var current_step = -1
var tutorial_state = "INTRO"

func _ready() -> void:
	tutorial_label.text = """Welcome to the Torah Timeline tutorial! 
		In this game, your goal is to place Sage cards into the Timeline
		and have the majority when the Timeline is full. Click NEXT to continue.
		"""

func _advance_tutorial():
	current_step += 1
	if current_step < tutorial_steps.size():
		tutorial_state = tutorial_steps[current_step]["state"]
		tutorial_label.text = tutorial_steps[current_step]["text"]
		node_to_reveal = tutorial_steps[current_step]["reveal_node"]
		reveal_node(node_to_reveal)
	else:
		cfc.quit_game()
		get_parent().get_tree().change_scene("res://src/custom/MainMenu.tscn")


func _on_NextButton_pressed() -> void:
	_advance_tutorial()
	
func reveal_node(node: Node) -> void:
	if node:
		node.set_visible(true)
		print("SHOW NODE: " + node.get_name())
