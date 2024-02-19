extends Button
@onready var bag: Pack = $"../Bag"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed():
	PackManager.loadInventory(bag)
	pass
