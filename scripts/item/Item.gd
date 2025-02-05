class_name Item
extends Node


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func getValue():	# 抽象
	pass
	
func getScene():	# 子类多态
	var scene = load("res://scenes/part_of/item.tscn").instantiate()
	scene.item = self
	return scene
