extends Node


func _ready():
	GameManager.statusUpdate()
	
	if (Global.isMobile):
		$moblieControl.show()
	else:
		$moblieControl.hide()
		
	#	询问是否需要教程
	if (Global.firstPlay):
		var scene = load("res://scenes/windowLike/askTutorial.tscn").instantiate()
		Global.nodeTree.root.add_child(scene)
		Global.firstPlay = false
	

func _process(delta):
	pass
