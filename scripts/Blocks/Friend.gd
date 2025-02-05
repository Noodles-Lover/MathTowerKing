class_name Friend
extends Block

var num: int

func _init(row, col, num):
	self.row = row
	self.col = col
	self.num = num


func execute():
	print("[事件] touch friend")
	destorySelf()
	
	# 跳转到战斗
	var root = GameManager.nodeTree.root
	GameManager.remove_all_children(root)
	
	var battleScene = load("res://scenes/battle.tscn").instantiate()
	battleScene.targetNum = num
	battleScene.isEnemy = false
	
	root.add_child(battleScene)
	
static func getScene():
#	print("friend getScene")
	return Number.new(0,Number.TYPE.FRIEND).getScene()
