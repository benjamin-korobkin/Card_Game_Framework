extends Node2D

class_name TurnQueue

onready var game_over : bool 
onready var active_player : Node2D 
onready var p1 = $Player1
onready var p2 = $Player2

func initilalize():
	game_over = false
	active_player = p1
	active_player.play_turn()
	
func play():
	while not game_over:
		game_over = yield(active_player.play_turn(), "completed")


func check_turn_over():
	if active_player.action_points <= 0:
		active_player.finish_turn()
		active_player = p2 if active_player==p1 else p1
		active_player.play_turn()
