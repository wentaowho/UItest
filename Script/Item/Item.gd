extends Resource
class_name Item
var attr_type = {
	"hp" :"血量",
	"atk" :"攻击",
	"def" :"防御",
	"speed" :"速度",
	"descr":"描述"
}

@export var hp:int
@export var atk:int
@export var def:int
@export var speed:int
@export var descr:String
@export var ICON:Texture
@export var ICON_RAW:Texture
@export var itemName:String
@export var itemDescr:String
