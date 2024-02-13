extends Button

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed():
	dir_contents("res://Item/")
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
			print(file_name.get_basename())
		
	else:
		print("尝试访问路径时出错。")

