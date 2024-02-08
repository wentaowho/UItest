class_name InventoryItem
extends TextureRect
@onready var counter: Label = $Label

var isDrag: bool = false:
	set(v):
		if !is_node_ready():
			await ready
			isDrag=v
			if isDrag:
				print(counter.horizontal_alignment,HORIZONTAL_ALIGNMENT_RIGHT)
				counter.horizontal_alignment=HORIZONTAL_ALIGNMENT_LEFT
			else:
				counter.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT

@export var item: Item:
	set(v):
		if !is_node_ready():
			await ready
		if v != null:
			counter.visible=(v.type==Item.itemType.weapon)
			item = load(v.resource_path)
			if isDrag:
				texture = item.ICON_RAW
			else:
				texture = item.ICON
		else:
			item=null

func getCountLable()->Label:
	print(counter)
	return counter

func getCount()->int:
	return counter.text as int

