extends Node

@export var item: Item

signal itemPressed(item)

# Called when the node enters the scene tree for the first time.
func _ready():
	render()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func render():
	if (!item): return
	
	const NODENAME = "item"
	var itemParent = $Container
	var targetNode = itemParent.get_node(NODENAME)
	itemParent.remove_child(targetNode)
	
	var scene = item.getScene()
	scene.name = "item"
	if item is Number:
		scene.num = item.num
		scene.type = item.type
	if item is Operator:
		scene.symbol = item.symbol
		
	itemParent.add_child(scene)


func _on_button_pressed():
	itemPressed.emit(item)
