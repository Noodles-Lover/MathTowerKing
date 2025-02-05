class_name Dice
extends Rune


func _init():
	runeName = "骰子"
	description = "战斗时会有随机初始值1~6"
	timing = TIMING.BEFORE_BATTLE
	textureName = "Dice"
	

# data = {"initNum": -1}		# 战斗初始值
func use(data = {}):		# 抽象
	print("[符文] %s 发动了" % runeName)
	data["initNum"] = randi_range(1,6)
	
	
