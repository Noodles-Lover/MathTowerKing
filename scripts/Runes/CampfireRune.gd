class_name CampfireRune
extends Rune


func _init():
	runeName = "营火之符"
	description = "营火回复的hp和体力+3"
	timing = TIMING.BEFORE_CAMPFIRE
	textureName = "CampfireRune"
	

# data = {"energy": 5, "hp": 5}	# 体力和hp回复量
func use(data = {}):	
	print("[符文] %s 发动了" % runeName)
	data["energy"] += 3
	data["hp"] += 3
	print(data)
	

