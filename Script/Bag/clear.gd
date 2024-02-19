extends Button
@onready var bag: Pack = $"../Bag"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed():
	#dir_contents("res://Item/")
	for i in bag.get_children():
		i.removeItem()
	pass

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("发现目录：" + file_name)
			else:
				print("发现文件：" + file_name)
			file_name = dir.get_next()
			print((file_name.get_basename()).get_basename())
		
	else:
		print("尝试访问路径时出错。")

