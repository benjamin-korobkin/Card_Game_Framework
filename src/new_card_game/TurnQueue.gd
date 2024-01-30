extends Node2D

class_name TurnQueue

onready var game_over : bool = false
onready var active_player : Node2D 
onready var p1 = $Player1
onready var p2 = $Player2
onready var is_first_turn = true
	
func initialize():
	active_player = p1
	active_player.play_turn()


func check_turn_over():
	if not game_over:
		if active_player.actions_remaining < 1:
			active_player.finish_turn()
			active_player = p2 if active_player==p1 else p1
			active_player.play_turn()
	else:
		print("AND THAT'S THE GAME!!!")
		
func game_won(player: String):
	game_over = true
	print(player + " won the game!")
