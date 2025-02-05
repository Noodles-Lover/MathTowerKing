extends Node


var row = 5
var col = 5
func _init(num):
	print(num)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print("READY")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("PROCESS")
	pass
