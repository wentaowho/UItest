class_name InventoryItem
extends TextureRect
@onready var counter: Label = $Label
var counterVisible: bool
var isDrag: bool = false
# var isDrag: bool = false:
# 	set(v):
# 		if !is_node_ready():
# 			await ready
# 			isDrag = v
# 			if isDrag:
# 				counter.visible = false
# 				counter.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
# 			else:
# 				counter.visible = counterVisible
# 				counter.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

@export var item: Item:
	set(v):
		if !is_node_ready():
			await ready
		if v != null:
			counter.visible = (v.type != Item.itemType.weapon)
			item = load(v.resource_path)
			if isDrag:
				texture = item.ICON_RAW
			else:
				texture = item.ICON
		else:
			item = null
			texture = null
			counter.visible = false
		counterVisible = counter.visible

func getCountLable() -> Label:
	return counter

func getCount() -> int:
	return counter.text as int

func _ready() -> void:
	if (item == null):
		counter.visible = false

# func setCounterVisible(v: Item):
# 	if v != null:
# 		counter.visible = (v.type == Item.itemType.weapon)
# 		item = load(v.resource_path)
# 		if isDrag:
# 			texture = item.ICON_RAW
# 		else:
# 			texture = item.ICON
# 	else:
# 		item = null
# 		texture = null
# 		counter.visible = false
