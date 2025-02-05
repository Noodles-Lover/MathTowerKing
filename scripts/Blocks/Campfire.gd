class_name Campfire
extends Block

func execute():
	print("[事件] touch Campfire")
	
	var data = {"energy": 5, "hp": 5}	# 体力和hp回复量
	Rune.checkAllRunes(Rune.TIMING.BEFORE_CAMPFIRE, data)
	
	Player.energy += data["energy"]
	Player.addHp(data["hp"])
	AudioPlayer.playUnCoverAudio("campfire")
	
	destorySelf()
	
static func getScene():
	var scene = load("res://scenes/part_of/texture.tscn").instantiate()
	scene.texturePath = "res://static/Campfire.png"
	return scene
