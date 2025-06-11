extends Node

var InventoryRowScene = load("res://scenes/part_of/inventoryRow.tscn")


func _ready():
	Player.updateInventory.connect(_on_update_inventory)
	renderInventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func renderInventory():
	Global.remove_all_children(self)
	for i in range(1,10):	# 1~9物品栏
		var inventoryRowScene = InventoryRowScene.instantiate()
		inventoryRowScene.item = Number.new(i,0)
		inventoryRowScene.amount = Player.inventory[i]
		inventoryRowScene.custom_minimum_size = Vector2(0, 43)
		inventoryRowScene.name = String.num_int64(i)
		add_child(inventoryRowScene)
		
	for i in Operator.OP_TYPE.values():		# +-*/物品栏
		var inventoryRowScene = InventoryRowScene.instantiate()
		inventoryRowScene.item = Operator.new(i)
		inventoryRowScene.amount = Player.inventory[i]
		inventoryRowScene.custom_minimum_size = Vector2(0, 43)
		inventoryRowScene.name = str(i)
		add_child(inventoryRowScene)


func _on_update_inventory():
#	print("> 信号 update inventory")
	renderInventory()
