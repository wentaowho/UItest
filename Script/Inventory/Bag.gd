extends Control
class_name Bag
var offset=Vector2(24,24)
var info
var isDrag:bool
func _ready() -> void:
	gui_input.connect(_on_gui_input)

func _on_gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			DragManager.startPickControl(self)
