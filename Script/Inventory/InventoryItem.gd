class_name InventoryItem
extends TextureRect
var isDrag: bool
@export var item: Item:
	set(v):
		if !is_node_ready():
			await ready
		if v != null:
			item = load(v.resource_path)
			texture = item.ICON
		else:
			texture = null
