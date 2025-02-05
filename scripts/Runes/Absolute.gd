class_name Absolute
extends Rune


func _init():
	runeName = "绝对值"
	description = "攻击时自身与对方差值为1时，免疫该伤害。"
	timing = TIMING.ATTACK_CALCULATE
	textureName = "Absolute"
	

# data = {"dmg": minusHp}	# 战斗差值，要扣的血量
func use(data = {}):		# 抽象
	print("[符文] %s 发动了" % runeName)
	if data["dmg"] <= 1:
		data["dmg"] = 0
	
	
