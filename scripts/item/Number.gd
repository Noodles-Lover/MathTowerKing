class_name Number
extends Item

enum TYPE{
	NEUTRAL,
	ENEMY,
	FRIEND
}

var num: int
var type: TYPE

func _init(num = 0, type = TYPE.NEUTRAL):
	self.num = num
	self.type = type

func getValue():
	return num
	
func getScene():
	var scene = load("res://scenes/part_of/number.tscn").instantiate()
	scene.num = num
	scene.type = type
	return scene
	
