class_name InventoryItem
extends TextureRect
@onready var counter: Label = $Counter
var counterVisible: bool=false
var isDrag: bool = false

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

@export var number:int:
	set(v):
		if !is_node_ready():
			await ready
		if v<=1:
			counter.visible = false
			if v<=0:
				item=null
		else:
			counter.visible=true
			counter.text=str(v)
		counterVisible = counter.visible
		number=v

func _ready() -> void:
	if (item == null or number<=0):
		counter.visible = false

func getCountLable() -> Label:
	return counter
