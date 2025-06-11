extends Node

@export var targetNum: int
@export var isEnemy: bool

@onready var BatteInventoryScene = load("res://scenes/part_of/battleInventory.tscn")


func _ready():
	
	$hp.text = "HP: %d" % Player.hp
	# 渲染对方数字
	var number = Number.new(targetNum, Number.TYPE.FRIEND)
	if (isEnemy): number = Number.new(targetNum, Number.TYPE.ENEMY)
	
	var numScene = number.getScene()
	numScene.scale = Vector2(3, 3)
	numScene.position = Vector2(270, 10)
	numScene.name = "targetNum"
	
	$battleContainer/innerContainer.add_child(numScene)
	
	Player.updateInventory.connect(renderInventory)
	renderInventory()
	
	if (GameManager.needTutorial):
		var scene = load("res://scenes/windowLike/battleTutorial.tscn").instantiate()
		Global.nodeTree.root.add_child(scene)
		GameManager.needTutorial = false


func _process(delta):
	pass

func renderInventory():
	var inventoryNode = $Inventory
	var formulaNode = $battleContainer/innerContainer/FormulaContainer
	
	Global.remove_all_children(inventoryNode)
	for i in range(1,10):	# 1~9物品栏
		var scene = BatteInventoryScene.instantiate()
		scene.item = Number.new(i,0)
		scene.amount = Player.inventory[i]
		inventoryNode.add_child(scene)
		# 连接battleInventoryRoot的pressedItem(item)信号到formula.gd的uploadItem(item)函数
		scene.pressedItem.connect(Callable(formulaNode, "uploadItem")) 
		
	for i in Operator.OP_TYPE.values():		# +-*/物品栏
		var scene = BatteInventoryScene.instantiate()
		scene.item = Operator.new(i)
		scene.amount = Player.inventory[i]
		inventoryNode.add_child(scene)
		scene.pressedItem.connect(Callable(formulaNode, "uploadItem"))


func _on_update_inventory():
#	print("> 信号 update inventory")
	renderInventory()


func attack(usedItems):
	GameManager.paused = true # 防止二次触发攻击
	
	var leftNode = $battleContainer/innerContainer/FormulaContainer/left
	
	# 动画
	var tween = get_tree().create_tween()
	const DURATION = 0.5
	
#	tween.tween_property(leftNode, "rotation", 60, 0.2)
	tween.tween_property(leftNode, "position:y", -150, DURATION)	# (节点, 属性, 目标值, 时长)
	tween.parallel()  # 使下一个动画与前一个动画并行
	tween.tween_property(leftNode, "position:x", 280, DURATION)
	tween.parallel()  # 使下一个动画与前一个动画并行
	tween.tween_property(leftNode, "modulate:a", 0, DURATION)
	
	tween.set_ease(Tween.EASE_IN_OUT)  # 动画开始和结束时会减速
	tween.play()
	AudioPlayer.playAudio("attack")
	
	await get_tree().create_timer(DURATION).timeout	# 等待动画秒数
	# 动画
	
	# 跳转回playroom
	var root = Global.nodeTree.root
	Global.remove_all_children(root)
	var scene = load("res://scenes/playRoom.tscn").instantiate()
	root.add_child(scene)
	
	# 计算扣血
	var value = leftNode.num
	var minusHp = abs(targetNum - value)
	
	var data = {"dmg": minusHp}		# 战斗差值，要扣的血量
	Rune.checkAllRunes(Rune.TIMING.ATTACK_CALCULATE, data)
	
	print("[战斗] ATTACK: %d, 扣血%d" % [value, data["dmg"]])
	Player.addHp(-data["dmg"])	# 注意加了负号
	
	if GameManager.gameEnded: return
	
	if (!isEnemy):	# 友方则获得该数字，并返回物品
		Player.addInventory(targetNum, 1)
		for i in usedItems:
			var item = i
			if i is String:
				item = Operator.symbol2enum(i)
			Player.addInventory(item, 1)
		GameManager.addItemAnimation(targetNum)
		
	if (isEnemy): Rune.checkAllRunes(Rune.TIMING.AFTER_DEFEAT)
	else: Rune.checkAllRunes(Rune.TIMING.AFTER_FRIEND, {"targetNum": targetNum})			# 朋友
	
	GameManager.paused = false
