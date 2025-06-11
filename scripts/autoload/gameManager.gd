extends Node

var startNumAmount = 1		# 数字起始数量
var startOpAmount = 2		# 运算符号起始数量
var map

var level = 1
var gameEnded = false
var paused = false
var needTutorial = true

signal destory(row, col)
#signal renderMap

func _ready():
	destory.connect(destoryBlock)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initGame():
	level = 1
	gameEnded = false
	paused = false
	Player.initPlayer()
	initMap()
	generateMap()

func initMap():
	map = []
	for i in range(Global.MAPSIZE):
		var tempArray = []
		for j in range(Global.MAPSIZE):
			tempArray.append(null)
		map.append(tempArray)
	
func generateMap():
	var chestAmount = randi_range(6,8+level)
	generateBlock(chestAmount, Block.BLOCKTYPE.CHEST)
	
	var friendAmount = randi_range(2,3+level)
	generateBlock(friendAmount, Block.BLOCKTYPE.FRIEND)
	
	var enemyAmount = randi_range(3, 3+level-1)
	generateBlock(enemyAmount, Block.BLOCKTYPE.ENEMY)
	
	var campfireAmount = randi_range(0, level/2)
	generateBlock(campfireAmount, Block.BLOCKTYPE.CAMPFIRE)

func generateBlock(amount, type):
	var enemyMax = 15 + 20*level
	for i in range(amount):
		while (true):	# 注意当数组没有空间时的死循环
			var row = randi_range(0, 10)
			var col = randi_range(0, 10)
			if (!map[row][col] && (row != 5 && col != 5)):
				match (type):
					Block.BLOCKTYPE.CHEST:
						map[row][col] = Chest.new(row, col)
						print("[地图] Chest: %d, %d" % [row, col])
					Block.BLOCKTYPE.ENEMY:
#						var randNum = randi_range(1, 10 + 5*level)
						var randNum = randi_range(1, enemyMax+10)
						if (i == amount-1 && enemyMax > 0):		# 最后一次生成
							randNum = enemyMax	# 剩余所有数值为敌人数值
						enemyMax -= randNum
						if enemyMax < 0: enemyMax = 0
						
						map[row][col] = Enemy.new(row, col, randNum)
						print("[地图] Enemy: %d, %d" % [row, col])
					Block.BLOCKTYPE.FRIEND:
						var randNum = randi_range(1, 9)
						map[row][col] = Friend.new(row, col, randNum)
						print("[地图] Friend: %d, %d" % [row, col])
					Block.BLOCKTYPE.CAMPFIRE:
						map[row][col] = Campfire.new(row, col)
						print("[地图] Campfire: %d, %d" % [row, col])
				break
		
func addItemAnimation(key):
	if (gameEnded): return
	
	var node = get_node("/root/playRoom/inventoryContainer/%s" % key)
	var label = Label.new()
	label.position += Vector2(125, 10)
	label.text = "+1"
	label.set("theme_override_fonts/font", load("res://static/HYPixel11pxU-2.ttf"))
	label.set("theme_override_colors/font_color", Color("26ff00"))
	label.set("theme_override_font_sizes/font_size", 25)
	node.add_child(label)
	
	AudioPlayer.playUnCoverAudio("addItem")
	var tween = get_tree().create_tween()
	const DURATION = 0.62

	tween.tween_property(label, "position:y", -15, DURATION)	# (节点, 属性, 目标值, 时长)
	tween.parallel()  # 使下一个动画与前一个动画并行
	tween.tween_property(label, "modulate:a", 0.3, DURATION)
	
	tween.set_ease(Tween.EASE_IN_OUT)  # 动画开始和结束时会减速
	tween.play()
	await get_tree().create_timer(DURATION).timeout		# 等待动画秒数
	
	if node != null:	node.remove_child(label)		# 删除，!=null是因为可能被切换场景了

func destoryBlock(row, col):
#	print("[GM] destorying: %d, %d" % [row, col])
	var parent = $"../playRoom/background/map"
	var name = "%d %d" % [row,col]
	var targetNode = parent.get_node(name)
	parent.remove_child(targetNode)
	
	GameManager.map[row][col] = null
#	print(">[GM] destoryed [%d,%d]" % [row, col])

		
# UI文本更新
func statusUpdate():
#	print("@ status update")
	$"../playRoom/status".text = "HP: %d\n体力：%d\n层数：%d" % [Player.hp, Player.energy, level]
	
func checkAllClear() -> bool:
	for i in range(Global.MAPSIZE):
		for j in range(Global.MAPSIZE):
			if map[i][j]: return false
	
	# 地图全空
	nextLevel()
	return true

func noEnergy():
	print("[GM] no energy")
	detectLeftEnemy()	# 检测残余敌人，进行扣血
	if gameEnded: return
	nextLevel()
	
func nextLevel():
	level += 1
	Player.row = 5
	Player.col = 5
	Player.energy = 51 - level
	Player.facingText = "down"
	initMap()
	generateMap()
	
	# 跳转回playroom
	var root = get_tree().root
	Global.remove_all_children(root)
	var scene = load("res://scenes/playRoom.tscn").instantiate()
	root.add_child(scene)
	
	Rune.checkAllRunes(Rune.TIMING.NEXT_LEVEL)
	
	statusUpdate()
	AudioPlayer.playUnCoverAudio("levelup")
	
	
func detectLeftEnemy():
	for i in range(Global.MAPSIZE):
		for j in range(Global.MAPSIZE):
			if gameEnded: return
			
			var block = map[i][j]
			if (!block): continue
			
			if (block is Enemy):
				print(">[GM] left enemy: %d" % block.num)
				Player.addHp(-block.num)
	
func gameOver():	# 回到初始界面，全部重置（显示层数？）
	print("[GM] game over")
	AudioPlayer.playAudio("gameOver")
	AudioPlayer.stopBGM()
	gameEnded = true
	
	Global.remove_all_children(Global.nodeTree.root)
	Global.nodeTree.change_scene_to_file("res://scenes/start.tscn")
	
