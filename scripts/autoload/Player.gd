extends Node

var row: int
var col: int
var hp: int
var energy: int

var facingText: String
var skinID: int

var inventory = {}
var runes = []

# 各自 由进行渲染的节点脚本连接
signal updateInventory
signal updateRunes
	

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func initPlayer():
	row = 5
	col = 5
	hp = Global.defaultHp
	energy = 50
	facingText = "down"
	skinID = randi_range(1,2)
	
	for i in range(1,10):
		inventory[i] = GameManager.startNumAmount
	for i in Operator.OP_TYPE.values():
		inventory[i] = GameManager.startOpAmount
	
	runes = []
		
		
func addInventory(key, value):
	print("[玩家] add inventory: %s %d" % [key, value])
	inventory[key] += value
	
	if (inventory[key] < 0):
		print(">[玩家] inventory %s < 0" % key)
		inventory[key] = 0
		return false
		
	updateInventory.emit()
#	AudioPlayer.playAudio("addItem")
	return true
	
func addRune(rune: Rune):
	print("[玩家] add rune: %s" % rune.runeName)
	if (len(runes) >= 9): 
		print(">[玩家] runes 已满")
		return false
		
	runes.append(rune)
	updateRunes.emit()
	AudioPlayer.playAudio("addItem")
	return true

func addHp(value):
	print("[玩家] HP + (%d)" % value)
	var data = {"value": value}
	
	if data["value"] < 0:
		AudioPlayer.playUnCoverAudio("hurt")
		Rune.checkAllRunes(Rune.TIMING.AFTER_DMG, data)
		
	hp += data["value"]
	
	GameManager.statusUpdate()
	if (hp <= 0):
		GameManager.gameOver()
