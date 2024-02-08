extends Label

func _process(_delta: float) -> void:
	text=DragManager.dragType.find_key(DragManager.pickUpType)
