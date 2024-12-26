extends Node2D

signal game_won(player)

onready var game_over : bool = false
onready var active_player : Node2D setget set_active_player, get_active_player
onready var p1 = $Player1
onready var p2 = $Player2
onready var is_first_turn = true


func initialize():
	set_active_player(p1)
	active_player.play_turn()


func check_turn_over():
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
		if get_active_player() == p1:
			set_active_player(p2)
		else:
			set_active_player(p1)
		active_player.play_turn()
		
func set_active_player(player):
	active_player = player
	
func get_active_player():
	return active_player
