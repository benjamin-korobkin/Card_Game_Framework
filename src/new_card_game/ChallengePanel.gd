extends Popup

var board
var p1

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
	p1 = board.get_node("TurnQueue/Player1")
	p1.set_is_challenging(true)
	
func _process(delta: float) -> void:
	if p1.get_is_challenging() and not visible:
		p1.set_is_challenging(false)

func _on_CancelButton_pressed() -> void:
	hide()
