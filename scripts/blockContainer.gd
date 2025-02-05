extends Node

@onready var BlockScene = load("res://scenes/part_of/block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# 初始化11*11个地图格子
	for i in range(11):
		for j in range(11):
			add_child(BlockScene.instantiate()) # 将block节点添加到当前节点下


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

