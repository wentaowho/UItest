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

