extends Node2D
var currentSlot: InventorySlot
var pickUpData: Control
var pickInventorySlot: InventorySlot
var pickUpType: dragType
#点击的位置与鼠标位置的差值
var offsetVector: Vector2

enum dragType {
	none, # 待机状态
	p_Control, # 抓取窗口状态
	p_Item, # 抓取物品状态
	p_ReplaceItem # 交换物品状态
}
func _ready() -> void:
	set_process(false)
	set_process_input(false)

func _process(_delta: float) -> void:
	pickUpData.global_position = get_global_mouse_position() - offsetVector

"进入抓取物品状态，将拖拽管理器状态设置为抓取物品
将被抓取的物品显示层级拉到最高

"
func startPickItem(data: Dictionary) -> void:
	if data.has("InventorySlot"):
		pickInventorySlot = data.get("InventorySlot")
		pickInventorySlot.isDrag = true
	if data.has("InventoryItem"):
		pickUpData = data.get("InventoryItem")
		pickUpType = dragType.p_Item

		#创造抓取物品的副本
		get_tree().root.add_child(pickUpData)
		offsetVector = Vector2(10, 10)
		#将抓取的物品层级显示为最高
		pickUpData.top_level = true
		pickUpData.z_index=101
		#修改抓取的物品状态为被抓取
		pickUpData.isDrag = true
		#修改鼠标的状态为抓取中
		Cursor.get_node_or_null("Cursor").isDrag = true

		set_process(true)
	
func startPickControl(control: Control):
	pickUpType = dragType.p_Control
	pickUpData = control
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
			releaseItem()
	#鼠标右键放下物体
	elif event.button_index == MOUSE_BUTTON_RIGHT and pickUpData != null and event.is_pressed():
		releaseItem()

func dragControl(event: InputEvent):
	if event.is_released() and pickUpData != null:
		pickUpData.top_level = false
		pickUpData.isDrag = false
		pickUpType = dragType.none
		pickUpData.set_process(false)
		set_process(false)
		return
	elif event.is_pressed():
		pickUpData.top_level = true
		pickUpData.isDrag = true
		pickUpData = null
		set_process(true)

func releaseItem():
	pickUpData.top_level = false
	pickUpData.isDrag = false
	pickUpData.set_process(false)
	set_process(false)
	#如果持有物品原始栏位与当前栏位不同则交换物品，否则放回物品
	if currentSlot != pickInventorySlot and currentSlot != null:
		# print("交换")
		replaceItem()
	else:
		# print("放回")
		pickInventorySlot.setItem(pickUpData.item,pickUpData.number)
		if currentSlot == null:
			#丢弃
			# print("none")
			initPickUpData(dragType.none)
		else:
			#放回
			# print("back")
			initPickUpData(dragType.p_ReplaceItem)

#交换栏位中的物品
func replaceItem():
	var currentSlotItem = currentSlot.getItem()
	var pickInventorySlotItem = pickInventorySlot.getItem()
	#print(currentSlotItem.item.ID,"--",pickInventorySlotItem.item.ID)
	pickInventorySlot.setItem(currentSlotItem["item"],currentSlotItem["number"])
	currentSlot.setItem(pickInventorySlotItem["item"],pickInventorySlotItem["number"])
	#显示物品详细信息
	currentSlot.showItemInfo(pickInventorySlotItem["item"])
	initPickUpData(dragType.p_ReplaceItem)

func initPickUpData(type: dragType):
	Cursor.get_node_or_null("Cursor").isDrag = false;
	pickUpData.queue_free()
	pickUpType = type
	pickInventorySlot.isDrag = false
	pickInventorySlot = null
