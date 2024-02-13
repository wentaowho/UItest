extends Node
const bag_path := "res://bag.sav"
func loadPack():
	pass

func savePack(bag:Node):
	var item:String=""
	for i in bag.get_children():
		var number:int
		var itemID:int
		print(i.name)
		if i.getItem()!=null:
			print(i.getItem().resource_path)
		else:
			print("none")
		item+=i.name
	print(item)
	#var json := JSON.stringify(item)
	#var file := FileAccess.open(bag_path, FileAccess.WRITE)
	#if not file:
		#return
	#file.store_string(json)

