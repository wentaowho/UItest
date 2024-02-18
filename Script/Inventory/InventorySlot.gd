class_name InventorySlot
extends TextureRect
@onready var slot: TextureRect = $Item

var offset = Vector2(24, 24)
var info

var isDrag: bool:
	set(v):
	#拖动物体后，原来的物品栏半透明
		isDrag = v
		var i = get_node("Item")
		if (v):
			i.set("self_modulate", Color(1, 1, 1, 0.25))
			mouse_default_cursor_shape = Control.CURSOR_ARROW
			i.counter.visible = false
		else:
			i.set("self_modulate", Color(1, 1, 1, 1))
			mouse_default_cursor_shape = Control.CURSOR_CROSS
			i.counter.visible = i.counterVisible

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	mouse_default_cursor_shape = Control.CURSOR_ARROW

func _on_mouse_entered() -> void:
	DragManager.currentSlot = self
	DragManager.set_process_input(false)
	if slot.item != null:
		showItemInfo(slot.item)
	setCursorShape()

func _on_mouse_exited() -> void:
	DragManager.currentSlot = null
	DragManager.set_process_input(true)
	ItemInfo.visible = false
	ItemInfo.item = null

func _on_gui_input(event: InputEvent):
	DragManager._input(event)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			
			#交换物体
			if DragManager.pickUpType == DragManager.dragType.p_ReplaceItem:
				DragManager.pickUpType = DragManager.dragType.none
			#拾取物体
			elif DragManager.pickUpType == DragManager.dragType.none and slot.item != null:
				#print("拾取物体")
				#get_node("Item").counter.visible=false
				
				var pickData: InventoryItem = get_node("Item").duplicate()
				pickData.isDrag = true;
				ItemInfo.visible = false

				var data: Dictionary = {
					"InventoryItem": pickData,
					"InventorySlot": self,
				}

				DragManager.startPickItem(data)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			#交换物体
			if DragManager.pickUpType == DragManager.dragType.p_ReplaceItem:
				DragManager.pickUpType = DragManager.dragType.none

func setItem(item: Item):
	get_node("Item").set("item", item)
	setCursorShape()

func setCursorShape():
	if (getItem() != null && !isDrag):
		mouse_default_cursor_shape = Control.CURSOR_CROSS
	else:
		mouse_default_cursor_shape = Control.CURSOR_ARROW


func getItem() -> Item:
	if get_node("Item").item!=null:
		return get_node("Item").item
	else:
		return null

func showItemInfo(item: Item):
	ItemInfo.item = item
	ItemInfo.visible = true
	ItemInfo.global_position = offset + global_position
