extends Node

const CONFIG_PATH := "user://config.ini"
const 调用测试 = preload("res://UI/下拉框/调用.gd")
func _ready() -> void:
	#var MyClass = load("myclass.gd")
	var instance = 调用测试.new()
	assert(instance.get_script() == 调用测试)
	instance.printf()
	load_config()
	
"config:游戏设置存储在计算机本地，每次开启自动读取"
func save_config() -> void:
	var config := ConfigFile.new()
	
	config.set_value("audio", "master", SoundManager.get_volume(SoundManager.Bus.MASTER))
	config.set_value("audio", "sfx", SoundManager.get_volume(SoundManager.Bus.SFX))
	config.set_value("audio", "bgm", SoundManager.get_volume(SoundManager.Bus.BGM))
	
	config.set_value("keybind", "move_left", "Left")
	config.save(CONFIG_PATH)

func load_config() -> void:
	var config := ConfigFile.new()
	config.load(CONFIG_PATH)
	
	SoundManager.set_volume(
		SoundManager.Bus.MASTER,
		config.get_value("audio", "master", 1.0)
	)
	SoundManager.set_volume(
		SoundManager.Bus.SFX,
		config.get_value("audio", "sfx", 1.0)
	)
	SoundManager.set_volume(
		SoundManager.Bus.BGM,
		config.get_value("audio", "bgm", 1.0)
	)
