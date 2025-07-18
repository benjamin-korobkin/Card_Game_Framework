extends Counters

# * The `counters_container` has to point to the scene path, relative to your
#	counters scene, where each counter will be placed.
# * value_node specified the name of the label which holds
#	the value of the counter as displayed to the player
# * The needed_counters dictionary has one key per counter used in your game
#	Each value hold a dictionary with details about this counter.
#	* The key matching `value_node` will be used to set the starting
#		value of this counter
#	* All other keys specified have to match a label node name in the counter scene
#		and their value will be set as that label's text.
# * spawn_needed_counters() has to be called at the end, to actually
#	add the specified counters to your counters scene.
func _ready() -> void:
	counters_container = $VBC
	value_node = "Value"
	needed_counters = {
		"Player1_merits": {
			"CounterTitle": "P1 Merits: ",
			"Value": "0"},
		"Player1_actions_remaining":{
			"CounterTitle": "P1 Actions: ",
			"Value": "2"},
		"Separator":{
			"CounterTitle":"---------",
			"Value":"---------"},
		"Player2_merits": {
			"CounterTitle": "P2 Merits: ",
			"Value": "0"},
		"Player2_actions_remaining":{
			"CounterTitle": "P2 Actions: ",
			"Value": "0"},
	}
	# warning-ignore:return_value_discarded
	spawn_needed_counters()
