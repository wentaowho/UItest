extends Resource
class_name Item
enum itemType{
	consume,
	weapon,
	setting,
	special,
	decoration
}
#var attr_type = {
	#"hp" :"血量",
	#"atk" :"攻击",
	#"def" :"防御",
	#"speed" :"速度",
	#"descr":"描述"
#}
@export var ICON:Texture
@export var ICON_RAW:Texture
@export var itemName:String
@export var itemDescr:String
@export var type:itemType
@export var num:int
#
#func _() -> void:
	#match type:
		#itemType.co


