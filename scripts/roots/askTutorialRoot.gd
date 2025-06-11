extends Node

func _ready():
	GameManager.paused = true
	pass

func _on_yes_pressed():
	print("[事件] 用户点击需要教程")
	GameManager.needTutorial = true
	GameManager.paused = false	# tutorial内部再设置为true管理
	var scene = load("res://scenes/windowLike/playRoomTutorial.tscn").instantiate()
	Global.nodeTree.root.add_child(scene)
	queue_free()

func _on_no_pressed():
	print("[事件] 用户点击*不*需要教程")
	GameManager.needTutorial = false
	GameManager.paused = false
	queue_free()
