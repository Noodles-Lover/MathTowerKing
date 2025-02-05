extends Node

@export var item: Item
@export var amount: int


# 由battleRoot连接信号到formula.gd的uploadItem(item)函数
# item: 0~9, +-*/
signal pressedItem(item) 

func _ready():
	var scene = item.getScene()
	scene.position = Vector2(5, 5)
	scene.scale = Vector2(1.5, 1.5)
	add_child(scene)
	
	# 数量文本
	var strAmount = String.num_int64(amount)
	var amountNode = $PanelContainer/amountPoint/amount
	if len(strAmount) > 1:
		amountNode.position -= Vector2(15, 0)
	amountNode.text = strAmount
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# 该物品被点击时
func _on_inventory_button_down():
	var inventoryIndex = item.getValue()
		
	print("[战斗] inventory_button_down: %s" % inventoryIndex)

	var success = Player.addInventory(inventoryIndex, -1)
	if (success): 
		AudioPlayer.playAudio("useItem")
		pressedItem.emit(item.getValue())
	else:
		AudioPlayer.playAudio("useItem_fail")
