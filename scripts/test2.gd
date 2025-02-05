class_name test2
extends Node


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
static func use(data):
	data["test"] = 999
	print("test2 use:")
	print(data)
