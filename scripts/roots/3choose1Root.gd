extends Node

@export var items: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		var item: Item = items[i]
		var parent = get_node(str(i))

		var scene = load("res://scenes/part_of/item.tscn").instantiate()
		scene.item = item
		scene.itemPressed.connect(choosedItem)
		
		scene.scale = Vector2(2,2)
		scene.position = Vector2(112,112)

		parent.add_child(scene)
		
		# 为每个 Container 设置鼠标检测
#		parent.mouse_filter = Control.MOUSE_FILTER_STOP
#		parent.mouse_entered.connect(_on_container_mouse_entered.bind(scene))
#		parent.mouse_exited.connect(_on_container_mouse_exited.bind(scene))


func choosedItem(item: Item):
	Player.addInventory(item.getValue(),1)
	GameManager.addItemAnimation(item.getValue())
	
	GameManager.paused = false
	queue_free()	# 清除自身和子节点
	
# 鼠标进入 Container 时的处理
#func _on_container_mouse_entered(item_scene: Node2D):
#	item_scene.scale = Vector2(2.5,2.5)
#
## 鼠标离开 Container 时的处理
#func _on_container_mouse_exited(item_scene: Node2D):
#	item_scene.scale = Vector2(2,2)
