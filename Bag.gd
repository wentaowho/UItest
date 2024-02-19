class_name Pack
extends Control
enum PackType{
	Consume,
	Equipment,
	Set,
	Else,
	Special
}

@export var type:PackType

func _ready() -> void:
	_initSeq()
	PackManager.loadInventory(self)

func _initSeq()->void:
	var num:int=0
	for i in get_children():
		i.name=str(num)
		num+=1;
