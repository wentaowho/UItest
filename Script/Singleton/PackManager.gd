extends Node
const bag_path := "res://bag.sav"
func loadPack():
	pass

func savePack(bag:Node):
	var itemDic:Dictionary={}
	var count:int=0
	for slot:InventorySlot in get_children():
		itemDic[str(count)]={}
		itemDic[str(count)]["id"]=slot.getItem().id
		itemDic[str(count)]["num"]=slot.getItem().num
		count+=1
	#var json := JSON.stringify(item)
	#var file := FileAccess.open(bag_path, FileAccess.WRITE)
	#if not file:
		#return
	#file.store_string(json)

const save_path="res://save/Inventory.json"
const save_path2="res://save/Inventory.json"

func saveInventory(pack:Pack)->void:
	var file := FileAccess.open(save_path2, FileAccess.WRITE)
	var data:Dictionary
	var type:String=Pack.PackType.find_key(pack.type)
	data[type]={}
	var num:int=0
	for i in pack.get_children():
		var item:Dictionary=i.getItem()
		print(item)
		print(item.get("id"))
		data[type][str(num)]={
			id=item.get("id"),
			number=item.get("number")
		}
		num+=1
	var json := JSON.stringify(data)
	if not file:
		return
	file.store_string(json)


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
		var packType=Pack.PackType.find_key(pack.type)
		for slot in data[packType]:
			var itemId:int=data[packType][slot]["id"]
			var number:int=data[packType][slot]["number"]
			if itemId!=-1:
				pack.get_node(str(slot)).setItemByID(itemId,number)
