extends Node

const MAPSIZE = 11
const baseNumRate = 0.2	# 战斗的初始数字出现概率
const runeRate = 0.11	# 出符文概率
const defaultHp = 30
var firstPlay = true
var isMobile = false

@onready var nodeTree = get_tree()

#
#var BlockGD = load("res://scripts/Blocks/Block.gd")
#var ChestGD = load("res://scripts/Blocks/Chest.gd")
#var EnemyGD = load("res://scripts/Blocks/Enemy.gd")
#var FriendGD = load("res://scripts/Blocks/Friend.gd")

# 按概率给出true false
# rate = [0,1]
func posibility(rate: float) -> bool:	
	if randf() <= rate:
		return true
	return false
	
func remove_all_children(node: Node):
	var ignoreAmount = 0
	if node == nodeTree.root:
		ignoreAmount = node.get_child_count()-1	 # 忽略autoload
	while node.get_child_count() > ignoreAmount:
		var child = node.get_child(ignoreAmount)  # 获取第一个子节点
		node.remove_child(child)  # 从父节点中移除子节点
		child.queue_free()  # 将子节点标记为待释放
