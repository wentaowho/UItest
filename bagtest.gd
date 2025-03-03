extends Control

const save_path="res://save/Inventory.json"
const ITEM_INFO = preload("res://Scene/ItemInfo.tscn")

#func _ready():  
	#var scene = preload("res://Scene/ItemInfo.tscn")  
	#var scene_instance = scene.instantiate()  
	#if scene_instance:  
		#add_child(scene_instance)  

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
