extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
#	Global.generateMap()
	renderScene()
#	GameManager.renderMap.connect(renderScene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
	
func renderScene():
	deleteAllScene()
	for i in range(Global.MAPSIZE):
		for j in range(Global.MAPSIZE):
			var block = GameManager.map[i][j]
			if (!block): continue
			var scene = block.getScene()
			if (block is Chest):
#				print("chest type")
				scene = Chest.getScene()
			if (block is Enemy):
#				print("enemy type")
				scene = Enemy.getScene()
				scene.num = GameManager.map[i][j].num
			if (block is Friend):
#				print("friend type")
				scene = Friend.getScene()
				scene.num = GameManager.map[i][j].num
			if (block is Campfire):
#				print("friend type")
				scene = Campfire.getScene()
			
			scene.name = "%d %d" % [i,j]
#			print("@@@ %s [%d,%d]" % [scene.name,i,j])
			Block.placeBlock(i, j, scene)
			add_child(scene)
					
func deleteAllScene():
	var children = self.get_children()
	
	for child in children:	# 遍历子节点
		# 检查子节点的名字是否符合格式 "%d %d" % [i,j]
		if (child.name.get_slice_count(" ") == 2):
			child.queue_free()
	
