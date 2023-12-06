class_name Player
extends Node2D

const ACTIONS_AT_START := 2

onready var board = get_parent().get_parent()

#var stats: Dictionary
var hand : Area2D
var timeline : PanelContainer
var field : PanelContainer
var opponent : Node2D
var actions_remaining : int = ACTIONS_AT_START
var torah_tokens : int = 0
var turn_over : bool
var timeline_complete = false setget set_timeline_complete, get_timeline_complete


func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	

func play_turn():
	actions_remaining = ACTIONS_AT_START
	turn_over = false
	while not turn_over:
		get_parent().check_turn_over()
	return timeline_complete
	
func draw_card(p: String):
	if actions_remaining >= 1:	
		hand.draw_card()
		actions_remaining -= 1
		board.counters.mod_counter((p+"_actions_remaining"), actions_remaining, true)


func finish_turn():
	turn_over = true

func set_timeline_complete(is_complete):
	timeline_complete = is_complete
	
func get_timeline_complete():
	return timeline_complete

#stats = {
	#	"cards_in_timeline": timeline.count_filled_slots(),
	#	"cards_in_field": field.count_filled_slots(),
	#	"cards_in_hand": hand.get_card_count(),
	#	"actions_remaining": actions_remaining,
	#	"torah_tokens": torah_tokens }
