class_name AllFriends
extends Rune


func _init():
	runeName = "四海皆朋友"
	description = "获得朋友时，有25%概率获得多一个。"
	timing = TIMING.AFTER_FRIEND
	textureName = "AllFriends"
	

# data = {"targetNum": targetNum}		# 战斗的对方数值，此时为朋友数值
func use(data = {}):		# 抽象
	print("[符文] %s 发动了" % runeName)
	if Global.posibility(0.25):
		Player.addInventory(data["targetNum"], 1)
		GameManager.addItemAnimation(data["targetNum"])
	
	
