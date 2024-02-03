extends ParallaxLayer

func _physics_process(delta: float) -> void:
	motion_offset.x-=delta*3
	if(motion_offset.x<-1280):
		motion_offset.x=0
