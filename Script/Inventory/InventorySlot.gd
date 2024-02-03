extends TextureRect
@onready var items: TextureRect = $Item

var offset=Vector2(24,24)
var info
var isDrag:bool

func _ready() -> void:
	mouse_entered.connect(p)
	mouse_exited.connect(e)
	gui_input.connect(_on_gui_input)
	set_process(false)


func p()->void:
	ItemInfo.item=items.item
	ItemInfo.visible=true
	ItemInfo.global_position=offset+global_position
	set_process(true)


func e()->void:
	ItemInfo.visible=false
	ItemInfo.item=null
	set_process(false)

func _on_gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			#todo 物品和界面分开
			DargManager.startPick(self.get_node("Item").duplicate(),DargManager.dragType.p_Item)

