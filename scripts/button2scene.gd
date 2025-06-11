extends Button

#定义可设置变量，可在所挂载物件的属性上更改
#@export var to_scene = ""		
@export_file var scenePath		#跳转路径
@export var default_foucs = false	#是否默认获取焦点

func _ready():
	if(default_foucs): grab_focus()
	# 绑定事件和触发函数，事件可在右侧节点查看
	connect("mouse_entered", Callable(self, "_on_Button_mouse_entered"))
	connect("pressed", Callable(self, "_on_Button_Pressed")) 
	

func _on_Button_mouse_entered():	#鼠标经过按钮时
	grab_focus()	#获取焦点

func _on_Button_Pressed():
#	print("pressed")
	if(scenePath):
#		print("@@@ " + scenePath)
		if (scenePath == "res://scenes/playRoom.tscn"):
			print("[GM] Start game")
			GameManager.initGame()
			AudioPlayer.playAudio("startGame")
			AudioPlayer.playBGM()
			
		get_tree().change_scene_to_file(scenePath)		#跳转
		
	else:
		get_tree().quit()	#退出游戏

