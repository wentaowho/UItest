extends Button
@onready var bag: Control = $"../Bag"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed():
	PackManager.savePack(bag)
