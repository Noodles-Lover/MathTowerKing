extends Node

@export var items: Array

# Called when the node enters the scene tree for the first time.
func _ready():
#	var scene1 = load("res://scenes/part_of/item.tscn").instantiate()
#	scene1.itemPressed.connect(choosedItem)
	
	for i in range(3):
		var item: Item = items[i]
		var parent = get_node(str(i))
#		var scene = item.getScene()

		var scene = load("res://scenes/part_of/item.tscn").instantiate()
		scene.item = item
		scene.itemPressed.connect(choosedItem)
		
		scene.scale = Vector2(2,2)
		scene.position = Vector2(112,112)

		parent.add_child(scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func choosedItem(item: Item):
	Player.addInventory(item.getValue(),1)
	GameManager.addItemAnimation(item.getValue())
	
	GameManager.paused = false
	queue_free()	# 清除自身和子节点
