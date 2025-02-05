class_name Training
extends Rune


func _init():
	runeName = "锻炼"
	description = "每层的初始体力+6"
	timing = TIMING.NEXT_LEVEL
	textureName = "Training"
	

# data = {"initNum": -1}		# 战斗初始值
func use(data = {}):		# 抽象
	print("[符文] %s 发动了" % runeName)
	Player.energy += 6
	
	
