class_name CursorManager
extends Node2D

var ClickableAnimation: Resource
enum CursorStatus {
		Normal,
		Click,
		Clickable,
		Catched,
		Catchable
	}
enum CursorAnimationStatus {
		Normal,
		Click,
		Catch
	}
#static var Singleton: CursorManager
var _status: CursorStatus = CursorStatus.Normal
#var _animationStatus: CursorAnimationStatus = CursorAnimationStatus.Normal;
var _clickPreStatus: CursorStatus;
var _animationPlayer: AnimationPlayer;
var isDrag: bool
var _isClickLeft:bool=false
var mouse_pos:Vector2
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	#Singleton = self;
	top_level = true;
	#初始化 on-ready 变量
	_animationPlayer = get_node("AnimationPlayer")
	_animationPlayer.play(CursorStatus.find_key(_status))
	mouse_pos = get_global_mouse_position()  
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(_delta: float) -> void:
	#global_position = get_global_mouse_position()  
	#Input.warp_mouse(mouse_pos)
	limitMousePos()

func ChangeState(status: CursorStatus):
	if isDrag:
		status = CursorStatus.Catched
	_clickPreStatus = _status;
	_status = status;
	_animationPlayer.play(CursorStatus.find_key(status));
	pass

func _input(event: InputEvent) -> void:
	mouseShpaeManager(event)
func limitMousePos():
	mouse_pos = get_global_mouse_position()  
	var window_size = DisplayServer.window_get_size()
	#print(window_size,mouse_pos)
	var max_x = window_size.x - 1  
	var max_y = window_size.y - 1  
	var min_x = 0  
	var min_y = 0     
# 如果鼠标试图超出窗口范围，将其位置限制在窗口内  
	if mouse_pos.x > max_x:  
		mouse_pos.x = max_x  
	if mouse_pos.y > max_y:  
		mouse_pos.y = max_y  
	if mouse_pos.x < min_x:  
		mouse_pos.x = min_x  
	if mouse_pos.y < min_y:  
		mouse_pos.y = min_y  
	global_position = mouse_pos

func mouseButtonLeftClickCheck(event: InputEvent) -> bool:
	if event.button_index == MOUSE_BUTTON_LEFT:
		_isClickLeft=event.is_pressed()
	else:
		_isClickLeft=false
	return _isClickLeft

func mouseShpaeManager(event: InputEvent):
	match event.get_class():
		"InputEventMouseButton":
			match Input.get_current_cursor_shape():
				#抓取物体
				Input.CursorShape.CURSOR_CROSS:
					if mouseButtonLeftClickCheck(event):
						ChangeState(CursorStatus.Catched)
					else:
						ChangeState(CursorStatus.Catchable)
				_:
					if mouseButtonLeftClickCheck(event):
						ChangeState(CursorStatus.Click)
					else:
						ChangeState(CursorStatus.Normal)
		"InputEventMouseMotion":
			match Input.get_current_cursor_shape():
				Input.CursorShape.CURSOR_CROSS:
					ChangeState(CursorStatus.Catchable)
				_:
					if _isClickLeft:
						ChangeState(CursorStatus.Click)
					else:
						ChangeState(CursorStatus.Normal)
