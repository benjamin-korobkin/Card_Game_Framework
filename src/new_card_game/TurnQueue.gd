extends Node2D
class_name TurnQueue

const CARDS_DRAWN_AT_START : int = 3
const TANACH_CARD_INTERVAL : int = 6

signal game_won(player)
signal turn_counter_updated(turn_counter)
signal tdeck_empty

onready var game_over : bool = false
onready var active_player : Node2D setget set_active_player, get_active_player
onready var p1 = $Player1
onready var p2 = $Player2
onready var is_first_turn = true
onready var turn_counter = TANACH_CARD_INTERVAL



func initialize():
	for i in range(CARDS_DRAWN_AT_START):
		yield(get_tree().create_timer(0.4), "timeout")
		p1.hand.draw_card()
		yield(get_tree().create_timer(0.4), "timeout")
		p2.hand.draw_card()
	set_active_player(p1)
	active_player.play_turn()


func check_turn_over():
#	print("P1 cards in timeline: " + str(p1.cards_in_timeline))
#	print("P2 cards in timeline: " + str(p2.cards_in_timeline))
	if active_player.is_timeline_complete():
		var winner
		if p1.cards_in_timeline > p2.cards_in_timeline:
			winner = p1
		else:
			winner = p2
		emit_signal("game_won", winner.get_name())
		game_over = true
		active_player.finish_turn() ## Prevent game from continuing
	elif active_player.get_actions_remaining() <= 0 and not game_over:
		active_player.finish_turn()
		increment_turn_counter()
		if get_active_player() == p1:
			set_active_player(p2)
		else:
			set_active_player(p1)
		active_player.play_turn()
		
func set_active_player(player):
	active_player = player
	
func get_active_player():
	return active_player

func increment_turn_counter():
	if cfc.NMAP.tdeck.get_card_count() > 0:
		turn_counter -= 1
		if turn_counter <= 0:
		# Give each player a Tanach card
		# Ensure an even number of cards to draw
			p1.hand.draw_card(cfc.NMAP.tdeck)
			yield(get_tree().create_timer(0.4), "timeout")
			p2.hand.draw_card(cfc.NMAP.tdeck)
			turn_counter = TANACH_CARD_INTERVAL
		emit_signal("turn_counter_updated", turn_counter)
	else: # No cards left in pile
		emit_signal("tdeck_empty")
		
