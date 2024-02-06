extends Node2D

var pickUpData: Control
var pickInventorySlot
var pickUpType: dragType
#点击的位置与鼠标位置的差值
var offsetVector: Vector2

enum dragType {
	none,p_Control, p_Item
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
		return
	
func startPickControl(control: Control):
	pickUpType=dragType.p_Control
	pickUpData=control
	offsetVector = get_global_mouse_position() - control.global_position
	control.top_level = true
	set_process(true)
	set_process_input(true)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match pickUpType:
			dragType.p_Item:
				#鼠标左键
				if event.button_index == MOUSE_BUTTON_LEFT:
					if event.is_pressed():
						#放开物体
						if pickUpData != null:
							releaseItem()
						else:
							#如果拾取的物体，初始化拾取管理器
							pickUpData = null
							pickInventorySlot=null
							pickUpType=dragType.none
							set_process(true)
							set_process_input(true)
				#鼠标右键放下物体
				if event.button_index == MOUSE_BUTTON_RIGHT and pickUpData != null:
						releaseItem()
			dragType.p_Control:
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
	print("release")
	pickUpData.top_level = false
	pickUpData.isDrag = false
	pickUpData.set_process(false)
	set_process(false)
	set_process_input(false)
	if pickUpType == dragType.p_Item:
		pickUpType=dragType.none
		pickInventorySlot.setItem(pickUpData.item)
		pickUpData.queue_free()
		pickInventorySlot.isDrag = false
		pickInventorySlot=null
