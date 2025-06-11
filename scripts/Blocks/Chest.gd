class_name Chest
extends Block

#var PlayerGD = load("res://scripts/Blocks/Player.gd")

var numberChance = 0.5
var operatorChance = 0.5


func execute():
	print("[事件] touch chest")
	GameManager.paused = true
	
	if Global.posibility(Global.runeRate):	# 出符文概率
		var scene = load("res://scenes/windowLike/1reward.tscn").instantiate()
		scene.rune = Rune.newRandomRune()
		Global.nodeTree.root.add_child(scene)
		
		AudioPlayer.playAudio("ChestRune")
		destorySelf()
		return
	
	# 获取三个*不同*物品
	var items: Array
	while items.size() < 3:
		var randomItem = getRandomItem()
		var is_unique = true
		for existingItem in items:
			if randomItem.getValue() == existingItem.getValue():
				is_unique = false
				break
		if is_unique:
			items.append(randomItem)
			
	print(">[宝箱] 三选一：%d %d %d" % [items[0].getValue(),items[1].getValue(),items[2].getValue()])
		
	var scene = load("res://scenes/windowLike/3choose1.tscn").instantiate()
	scene.items = items
	Global.nodeTree.root.add_child(scene)
	
	destorySelf()

func getRandomItem():
	var numberSum = 0
	var opSum = 0
	for i in range(1,10):
		numberSum += Player.inventory[i]
	for i in Operator.OP_TYPE.values():
		opSum += Player.inventory[i]
	opSum = floor(opSum*1.5)
	
	var item
	if randi_range(1, numberSum + opSum) <= opSum:	# 数字
		item = randi_range(1,9)
		item = Number.new(item,0)
	else:											# 符号
		item = Operator.new(Operator.getRandomOpType())
		
#	print(">[宝箱] 获得%d" % item.getValue())
	
	return item
#	Player.addInventory(item, 1)
#	GameManager.addItemAnimation(item)
	
static func getScene():
	var scene = load("res://scenes/part_of/texture.tscn").instantiate()
	scene.texturePath = "res://static/chest.png"
	return scene
