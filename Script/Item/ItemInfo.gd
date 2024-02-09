extends PanelContainer

@onready var itemName: Label = $VBoxContainer/Title/Label
@onready var itemDescr: RichTextLabel = $VBoxContainer/Item/Descr/RichTextLabel
@onready var icon: TextureRect = $VBoxContainer/Item/Icon/MarginContainer/Icon



@export var item:Item:
	set(v):
		if v!=null:
			item=load(v.resource_path)
			icon.set("texture",item.ICON)
			itemName.text=item.itemName
			itemDescr.text=item.itemDescr
			
		else:
			icon.texture=null
			itemName.text=""
			itemDescr.text=""

func _ready() -> void:
	visible=false
