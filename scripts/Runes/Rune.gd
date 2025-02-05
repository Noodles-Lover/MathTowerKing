class_name Rune
extends Node

enum TIMING{	# 道具触发的时机
	AFTER_DEFEAT,			# 打倒*敌人*后
	BEFORE_CAMPFIRE,		# 触发营火前
	ATTACK_CALCULATE,		# 攻击结算时
	BEFORE_BATTLE,			# 战斗前
	NEXT_LEVEL,				# 下一层时
	AFTER_FRIEND,			# 和朋友的战斗后
	AFTER_DMG,				# 受到伤害后
}

var runeName: String
var description: String
var timing: TIMING
var textureName: String

func use(data = {}):		# 抽象，data用于修改源脚本变量，用字典为指针
	pass
	
func getScene():
	var scene = load("res://scenes/part_of/rune.tscn").instantiate()
	scene.rune = self
	return scene
	
static func newRandomRune() -> Rune:
	var ALL_RUNES = [Vampire, CampfireRune, Absolute, Dice, Training, AllFriends, FirstAidKit]
	var random_index = randi() % ALL_RUNES.size()  # 生成随机索引
	return ALL_RUNES[random_index].new()  # 返回随机子类的实例
	
static func checkAllRunes(targetTiming: TIMING, data = {}):
	for rune in Player.runes:
		if rune.timing == targetTiming:
			rune.use(data)
			
