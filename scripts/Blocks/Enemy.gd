class_name Enemy
extends Block

var num: int

func _init(row, col, num):
	self.row = row
	self.col = col
	self.num = num


func execute():
	print("[事件] touch enemy")
	destorySelf()
	
	# 跳转到战斗
	var root = GameManager.nodeTree.root
	GameManager.remove_all_children(root)
	
	var battleScene = load("res://scenes/battle.tscn").instantiate()
	battleScene.targetNum = num
	battleScene.isEnemy = true
	
	root.add_child(battleScene)
	
static func getScene():
#	print("enemy getScene")
	return Number.new(0,Number.TYPE.ENEMY).getScene()
