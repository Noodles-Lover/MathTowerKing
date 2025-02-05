class_name Vampire
extends Rune


func _init():
	runeName = "吸血鬼"
	description = "在和敌人的战斗后，有25%概率回复3点hp。"
	timing = TIMING.AFTER_DEFEAT
	textureName = "Vampire"
	

func use(data = {}):		# 抽象
	print("[符文] %s 发动了" % runeName)
	if Global.posibility(0.25):	# 25%概率回血
		Player.addHp(3)
		AudioPlayer.playUnCoverAudio("campfire")
	
	
