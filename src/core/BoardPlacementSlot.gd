# Represents a spot on the placement grid that is used to organize
# cards on the board.
class_name BoardPlacementSlot
extends Control

# If a card is placed on this spot, this variable will hold a reference
# to the Card object
# and no other card can be placed in this slot
var occupying_card = null

# Stores a reference to the owning BoardPlacementGrid object
onready var owner_grid = get_parent().get_parent()
onready var start_pos : Vector2 = get_global_position()

func _ready() -> void:
	# We set the initial size of our highlight and area, to 
	# fit the size of the cards on the board.
	rect_min_size = owner_grid.card_size * owner_grid.card_play_scale
	$Highlight.rect_min_size = rect_min_size
	$Area2D/CollisionShape2D.shape.extents = rect_min_size / 2
	$Area2D/CollisionShape2D.position = rect_min_size / 2
	

func _process(delta: float) -> void:
	if occupying_card:
		# Check if position changed and update card position
		var new_pos = get_global_position()
		if new_pos != start_pos:
			var diff = new_pos - start_pos
			var card_pos = occupying_card.get_position()
			occupying_card.set_position(card_pos + diff)
			start_pos = new_pos
			
# Returns true if this slot is highlighted, else false
func is_highlighted() -> bool:
	return($Highlight.visible)


# Changes card highlight colour.
func set_highlight(requested: bool,
		hoverColour = owner_grid.highlight) -> void:
	$Highlight.visible = requested
	if requested:
		$Highlight.modulate = hoverColour


# Returns the name of the grid which is hosting this slot.
# This is typically used with CFConst.BoardDropPlacement.SPECIFIC_GRID
func get_grid_name() -> String:
	return(owner_grid.name_label.text)
