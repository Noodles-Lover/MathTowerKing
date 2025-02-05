extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	print("@ test.gd ready")
	test()
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func test():
	var a = {"test": 1}
	print("test a:")
	print(a)
	test2.use(a)
	print("after use:")
	print(a)
	

