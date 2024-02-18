class_name CursorManager
extends Node2D

var ClickableAnimation:Resource
enum CursorStatus{
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
static var Singleton:CursorManager
var _status:CursorStatus=CursorStatus.Normal
var _animationStatus:CursorAnimationStatus = CursorAnimationStatus.Normal;
var _clickPreStatus:CursorStatus;
var _animationPlayer:AnimationPlayer;
var isDrag:bool


func _ready() -> void:
	#Singleton = self;
	top_level = true;
	#初始化 on-ready 变量
	_animationPlayer = get_node("AnimationPlayer")
	_animationPlayer.play(CursorStatus.find_key(_status))
	Input.mouse_mode=Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	global_position=get_global_mouse_position();

func ChangeState(status:CursorStatus):
	if isDrag:
		status=CursorStatus.Catched
	_clickPreStatus = _status;
	_status = status;
	_animationPlayer.play(CursorStatus.find_key(status));
	pass

func _input(event: InputEvent) -> void:
	match event.get_class():
		"InputEventMouseButton":
			match Input.get_current_cursor_shape():
				Input.CursorShape.CURSOR_CROSS:
					if(!event.is_pressed()||event.is_released()):
						ChangeState(CursorStatus.Catched)
					else:
						ChangeState(CursorStatus.Catchable)
				Input.CursorShape.CURSOR_ARROW,_:
					if event.button_index == MOUSE_BUTTON_LEFT and (!event.is_pressed()||event.is_released()):
						ChangeState(CursorStatus.Normal)
					else:
						ChangeState(CursorStatus.Click)
		"InputEventMouseMotion":
			match Input.get_current_cursor_shape():
				Input.CursorShape.CURSOR_CROSS:
					ChangeState(CursorStatus.Catchable)
				_:
					ChangeState(CursorStatus.Normal)

















