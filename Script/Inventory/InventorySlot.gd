class_name InventorySlot
extends TextureRect
@onready var slot: TextureRect = $Item

var offset = Vector2(24, 24)
var info
var isDrag: bool

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	DragManager.currentSlot=self
	if slot.item!=null:
		showItemInfo(slot.item)

func _on_mouse_exited() -> void:
	DragManager.currentSlot=null
	ItemInfo.visible = false
	ItemInfo.item = null

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		#DragManager._input(event)
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			
			#交换物体
			if DragManager.pickUpType==DragManager.dragType.p_ReplaceItem:
				DragManager.pickUpType=DragManager.dragType.none
			#拾取物体
			elif DragManager.pickUpType==DragManager.dragType.none and slot.item!=null:
				#print("拾取物体")
				get_node("Item").counter.visible=false
				var pickData: InventoryItem = get_node("Item").duplicate()
				pickData.isDrag = true;
				#print(pickData.count)
				print(pickData.isDrag)
				#pickData.count.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT
				var data: Dictionary = {
					"InventoryItem": pickData,
					"InventorySlot": self,
				}
				get_node("Item").texture = null
				DragManager.startPickItem(data)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			#交换物体
			if DragManager.pickUpType==DragManager.dragType.p_ReplaceItem:
				DragManager.pickUpType=DragManager.dragType.none

func setItem(item:Item):
	get_node("Item").set("item",item)

func getItem()->Item:
	return get_node("Item").item

func showItemInfo(item:Item):
	ItemInfo.item = item
	ItemInfo.visible = true
	ItemInfo.global_position = offset + global_position
