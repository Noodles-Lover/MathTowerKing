class_name FirstAidKit
extends Rune


func _init():
	runeName = "急救包"
	description = "受到致命伤时，恢复到5点血（一次性）"
	timing = TIMING.AFTER_DMG
	textureName = "FirstAidKit"
	

# var data = {"value": value}	# addHp(value), 有正负
func use(data = {}):
	print("[符文] %s 发动了" % runeName)
	if (Player.hp + data["value"] <= 0):
		data["value"] = -(Player.hp - 5)
		
		Player.runes.erase(self)
		Player.updateRunes.emit()
		
		AudioPlayer.playUnCoverAudio("FirstAidKit")

	
	
