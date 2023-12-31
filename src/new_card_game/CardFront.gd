
extends CardFront

func _ready() -> void:
	var _card_text = find_node("CardText")
	# Map your card text label layout here. We use this when scaling
	# The card or filling up its text
	card_labels["Name"] = find_node("Name")
	card_labels["Type"] = find_node("Type")
	#card_labels["Tags"] = find_node("Tags")
	#card_labels["Description"] = find_node("Description")
	

	# These set te max size of each label. This is used to calculate how much
	# To shrink the font when it doesn't fit in the rect.
	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x - 4, 20)
	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x - 4, 20)

	set_card_rect_min_size()
	attach_card_labels()
	# This is not strictly necessary, but it allows us to change
	# the card label sizes without editing the scene
func set_card_rect_min_size():
	for l in card_label_min_sizes:
	#if l in card_labels.keys():
		card_labels[l].rect_min_size = card_label_min_sizes[l]

# This stores the maximum size for each label, when the card is at its
# standard size.
# This is multiplied when the card is resized in the viewport.
func attach_card_labels():
	for label in card_labels:
		match label:
			"Power":
				original_font_sizes[label] = 18
			"Description":
				original_font_sizes[label] = 18
			"Era":
				original_font_sizes[label] = 20
			_:
				original_font_sizes[label] = 16
