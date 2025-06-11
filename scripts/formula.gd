extends Node

var usedItems: Array
#var settleSymbol = false

signal updateFormula
signal attack(usedItems)

# Called when the node enters the scene tree for the first time.
func _ready():
	var data = {"initNum": -1}		# 战斗初始值
	Rune.checkAllRunes(Rune.TIMING.BEFORE_BATTLE, data)

	if Global.posibility(Global.baseNumRate):	# 随机有初始数
		data["initNum"] = randi_range(0,50*GameManager.level)
		AudioPlayer.playAudio("randomNumber")
	
	$left.num = data["initNum"]
		
	updateFormula.emit()
	
# battleInventoryRoot的pressedItem(item)信号（由battleRoot）连接到该函数
# item: 0~9, +-*/
func uploadItem(item):
	if (GameManager.paused): return
	print("[战斗] upload item: %d" % item)
	
	if (item > 9):	# 运算符号
		if ($symbol.symbol):	# 已存在运算符号，返回物品
			var inventoryIndex = Operator.symbol2enum($symbol.symbol)
			Player.addInventory(inventoryIndex,1)
			usedItems.erase($symbol.symbol)		# 从已使用物品中删除
			
		$symbol.symbol = Operator.enum2symbol(item)
		usedItems.append(item)
	else:		# 数字
		if ($left.num < 0):		# 左边有空位
#			print("@@@@: %d" % $left.num)
			$left.num = item
			usedItems.append(item)
		else:	# 右边
			if ($right.num >= 0):	# 已有数字，返回
				Player.addInventory($right.num,1)
				usedItems.erase($right.num)
			$right.num = item
			usedItems.append(item)
			
	updateFormula.emit()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func calculate():
	if (GameManager.paused): return
	if ($left.num < 0 || $right.num < 0 || !$symbol.symbol): return
	
	var operator = Operator.newBySymbol($symbol.symbol)
	var result = operator.calculate($left.num, $right.num)
	$result.num = result
	
	updateFormula.emit()
	AudioPlayer.playAudio("calculate")
	
	await get_tree().create_timer(0.5).timeout	#等待秒
	
	$left.num = result
	$symbol.symbol = ""
	$right.num = -1			# -1为_
	$result.num = -1
	updateFormula.emit()


func _on_attack_button_down():
	if (GameManager.paused): return
	attack.emit(usedItems)
