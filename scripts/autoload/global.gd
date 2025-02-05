extends Node

const MAPSIZE = 11
const baseNumRate = 0.2	# 初始数字出现概率
const runeRate = 0.11	# 出符文概率
const defaultHp = 30

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
