extends Node2D

var pickUpData: Control
var pickUpType: dragType
#点击的位置与鼠标位置的差值
var offsetVector: Vector2

enum dragType {
	p_Control, p_Item
}
func _ready() -> void:
	set_process(false)
	set_process_input(false)

func _process(_delta: float) -> void:
	pickUpData.global_position = get_global_mouse_position() - offsetVector

func startPick(p_pickUpData: Control, type: dragType) -> void:
	pickUpData = p_pickUpData
	pickUpType = type
	match type:
		dragType.p_Item:
			get_tree().root.add_child(pickUpData)
			offsetVector = Vector2(10, 10)
		dragType.p_Control:
			offsetVector = get_global_mouse_position() - pickUpData.global_position
	pickUpData.top_level = true
	set_process(true)
	set_process_input(true)
	#match p_pickUpData:
		#Node2D:
			#pickUpData=p_pickUpData
			#pickUpData.top_level=true
		#Control:
			#pickUpData=p_pickUpData
			#pickUpData.top_level=true
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_released() and pickUpData != null:
				pickUpData.top_level = false
				pickUpData.isDrag = false
				pickUpData.set_process(false)
				set_process(false)
				set_process_input(false)
				if pickUpType == dragType.p_Item:
					pickUpData.queue_free()
			elif event.is_pressed():
				pickUpData.top_level = true
				pickUpData.isDrag = true
				pickUpData = null
				set_process(true)
				set_process_input(true)
