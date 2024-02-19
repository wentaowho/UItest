class_name Consume
extends Item
@export var hp:int
@export var mp:int
@export var stackMaxNumber:int=99

#func _init() -> void:
	#id=resource_path.get_basename()
	#print("resname=",self)
