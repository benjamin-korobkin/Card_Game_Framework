extends "res://src/new_card_game/CardFront.gd"


func _ready() -> void:
	card_labels["Effect"] = find_node("Effect")
	card_label_min_sizes["Effect"] = Vector2(CFConst.CARD_SIZE.x - 4,STANDARD_FONT_SIZE+4)
	# Repeat these methods to get in the card_labels.rect_min_size
	# and original_font_sizes iterables
	set_card_rect_min_size()
	attach_card_labels()
