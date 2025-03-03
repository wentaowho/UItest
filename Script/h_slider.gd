extends HSlider

@export var bus: StringName = "Master"

@onready var bus_index := AudioServer.get_bus_index(bus)

# 可以声明额外的参数。
# 这些参数必须在发出信号时传递。
func _ready() -> void:
	value = SoundManager.get_volume(bus_index)
	value_changed.connect(func (v: float):
		SoundManager.set_volume(bus_index, v)
		Game.save_config()
	)
