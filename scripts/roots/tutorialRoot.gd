extends Node

@export var curStep = 0
var windows = []

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.paused = true
	# 按index存储所有教学窗口
	for i in range(20):
		if (get_node(str(i))):
			windows.append(get_node(str(i)))
		else:
			windows.append(null)
	print(windows)
	toTutorialStep(curStep)

func hideAllWindow():
	for window in windows:
		if (window is Control):
			window.hide()

func toTutorialStep(step):
	curStep = step
	hideAllWindow()
	
#	若不存在则消除教学面板
	if (windows[step]):
		windows[step].show()
	else:
		GameManager.paused = false
		queue_free()
	

func next():
	toTutorialStep(curStep+1)
	
func previous():
	if (curStep - 1 < 0): return
	toTutorialStep(curStep-1)
