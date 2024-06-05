extends Node
class_name SoundManager


func play_bfx()->void:
	for i in get_node("BFX").get_children():
		if i is AudioStreamPlayer2D:
			i.play()
#
func set_bfx_volume(volume:int):
	var bus:AudioBusLayout=AudioServer.get_bus_index("BFX")
