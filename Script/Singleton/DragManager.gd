#class_name  DragManager
extends Node2D
var currentSlot:InventorySlot
var pickUpData: Control
var pickInventorySlot:InventorySlot
var pickUpType: dragType
#点击的位置与鼠标位置的差值
var offsetVector: Vector2
enum dragType {
	none,p_Control,p_Item,p_ReplaceItem
}
func _ready() -> void:
	set_process(false)
	set_process_input(false)

func _process(_delta: float) -> void:
	pickUpData.global_position = get_global_mouse_position() - offsetVector

func startPickItem(data: Dictionary) -> void:
	if data.has("InventorySlot"):
		pickInventorySlot = data.get("InventorySlot")
		pickInventorySlot.isDrag=true
	if data.has("InventoryItem"):
		pickUpData = data.get("InventoryItem")
		pickUpType = dragType.p_Item
		get_tree().root.add_child(pickUpData)
		offsetVector = Vector2(10, 10)
		pickUpData.top_level = true
		pickUpData.isDrag = true
		set_process(true)
		set_process_input(true)
	
func startPickControl(control: Control):
	pickUpType=dragType.p_Control
	pickUpData=control
	offsetVector = get_global_mouse_position() - control.global_position
	control.top_level = true
	set_process(true)
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match pickUpType:
			dragType.p_Item:
				dragItem(event)
			dragType.p_Control:
				dragControl(event)


func dragItem(event: InputEvent):
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			#放开物体
			if pickUpData != null:
				#print("放开物体")
				releaseItem()
			else:
				#如果拾取的物体，初始化拾取管理器
				pickUpData = null
				pickInventorySlot=null
				pickUpType=dragType.p_Item
				set_process(true)
				set_process_input(true)
	#鼠标右键放下物体
	elif event.button_index == MOUSE_BUTTON_RIGHT and pickUpData != null and event.is_pressed():
		releaseItem()

func dragControl(event: InputEvent):
	if event.is_released() and pickUpData != null:
		pickUpData.top_level = false
		pickUpData.isDrag = false
		pickUpType=dragType.none
		pickUpData.set_process(false)
		set_process(false)
		set_process_input(false)
		return
	elif event.is_pressed():
		pickUpData.top_level = true
		pickUpData.isDrag = true
		pickUpData = null
		set_process(true)
		set_process_input(true)

func releaseItem():
	pickUpData.top_level = false
	pickUpData.isDrag = false
	pickUpData.set_process(false)
	set_process(false)
	set_process_input(false)
	#如果持有物品原始栏位与当前栏位不同则交换物品，否则放回物品
	if currentSlot!=pickInventorySlot and currentSlot!=null:
		#print("交换")
		replaceItem()
	else:
		#print("放回")
		pickInventorySlot.setItem(pickUpData.item)
		if currentSlot==null:
			initPickUpData(dragType.none)
		else:
			initPickUpData(dragType.p_ReplaceItem)

#交换栏位中的物品
func replaceItem():
	var currentSlotItem=currentSlot.getItem()
	var pickInventorySlotItem=pickInventorySlot.getItem()
	pickInventorySlot.setItem(currentSlotItem)
	currentSlot.setItem(pickInventorySlotItem)
	currentSlot.showItemInfo(pickInventorySlotItem)
	
	pickUpType=dragType.p_Item
	initPickUpData(dragType.p_ReplaceItem)


func initPickUpData(type:dragType):
	pickUpData.queue_free()
	pickUpType=type
	pickInventorySlot.isDrag = false
	pickInventorySlot=null
