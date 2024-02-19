extends Control

const save_path="res://save/Inventory.json"


func saveInventory()->void:
	pass

func loadInventory(pack:Pack)->void:
	var file := FileAccess.open(save_path, FileAccess.READ)
	if file==null:
		#初始化背包数据
		file = FileAccess.open(save_path, FileAccess.WRITE)
		print("loadinfo:init inventory data......")
		return
	else:
		var json := file.get_as_text()
		var data := JSON.parse_string(json) as Dictionary

