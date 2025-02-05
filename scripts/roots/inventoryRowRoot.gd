extends Node

@export var item: Item
@export var amount: int


func _ready():
#	print("@ inventoryRow onready")

	var scene = item.getScene()
	scene.scale = Vector2(0.8, 0.8)
	add_child(scene)
	
	$amount.text = str(amount)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
