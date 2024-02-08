extends Node2D
class_name TurnQueue

const CARDS_DRAWN_AT_START : int = 3

signal game_won(player)

onready var game_over : bool = false
onready var active_player : Node2D 
onready var p1 = $Player1
onready var p2 = $Player2
onready var is_first_turn = true


func initialize():
	for i in range(CARDS_DRAWN_AT_START):
		yield(get_tree().create_timer(0.5), "timeout")
		p1.hand.draw_card()
		yield(get_tree().create_timer(0.5), "timeout")
		p2.hand.draw_card()
	active_player = p1
	active_player.play_turn()


func check_turn_over():
	if active_player.is_timeline_complete():
		emit_signal("game_won", active_player.get_name())
		game_over = true
		active_player.finish_turn() ## Prevent game from continuing
	elif active_player.actions_remaining < 1 and not game_over:
		active_player.finish_turn()
		active_player = p2 if active_player == p1 else p1
		active_player.play_turn()
