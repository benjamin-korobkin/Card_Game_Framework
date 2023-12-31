extends "res://src/new_card_game/CardFront.gd"


func _ready() -> void:
	card_labels["Era"] = find_node("Era")
	card_label_min_sizes["Era"] = Vector2(CFConst.CARD_SIZE.x - 4,18)
	card_labels["Power"] = find_node("Power")
	card_label_min_sizes["Power"] = Vector2(CFConst.CARD_SIZE.x - 4,20)
	# Repeat these methods to get in the card_labels.rect_min_size
	# and original_font_sizes iterables
	set_card_rect_min_size()
	attach_card_labels()
