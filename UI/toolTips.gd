extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_make_custom_tooltip("11111")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = for_text
	label.custom_minimum_size.x=100
	label.autowrap_mode=TextServer.AUTOWRAP_ARBITRARY
	return label
