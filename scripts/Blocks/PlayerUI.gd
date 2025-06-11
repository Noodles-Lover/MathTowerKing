class_name PlayerUI
extends Block

@onready var Operator = load("res://scripts/item/Operator.gd")
@onready var InventoryContainerGD = load("res://scripts/inventoryContainer.gd")
#static var Global = preload("res://scripts/global.gd")
#var GameManagerGD = load("res://scripts/gameManager.gd")

static var instance = PlayerUI.new()
const moveAnimationDuration = 0.1

func _init():
	pass

static func getInstance():
	if not instance:
		instance = PlayerUI.new()
	return instance

func _ready():
	row = Player.row
	col = Player.col
	
	placePlayer(row, col)
	playerFacing()
	
#	updateInventory.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
#	print("PROCESS")
	moveDetect()
	
func _input(event):
	pass
	
func moveDetect():
	if GameManager.paused: return
	
	var moved = false
	
	# 定义一个字典来映射输入动作到移动方向
	var move_directions = {
		"ui_up": Vector2(0, -1),
		"ui_down": Vector2(0, 1),
		"ui_left": Vector2(-1, 0),
		"ui_right": Vector2(1, 0)
	}

	# 检查输入并处理玩家移动
	for action in move_directions:
		if Input.is_action_just_released(action):
			var delta = move_directions[action]
			var new_row = row + delta.x
			var new_col = col + delta.y
			if movePlayer(new_row, new_col):	# 成功移动（不是地图外）
				row = new_row
				col = new_col
				moved = true
				
				Player.facingText = action.substr(3, len(action))
				playerFacing()
			else:
				AudioPlayer.playAudio("walk_fail")
	
	if (moved):
		AudioPlayer.playAudio("walk")
		Player.col = col
		Player.row = row
		
		Player.energy -= 1
		GameManager.statusUpdate()
		if (Player.energy < 0): 
			GameManager.noEnergy()
			return
		
		if GameManager.checkAllClear(): # 检测地图是否已清空	
			return
			
		executeBlock()
			
func executeBlock():
	if (GameManager.map[row][col]):
		GameManager.map[row][col].execute()
	
#	静态移动
func placePlayer(row, col) -> bool:
	if Block.placeBlock(row, col, self):
		self.position.y -= 20		# 因为玩家高70，Block.placeBlock为50*50
		return true
	return false

#	动画的移动
func movePlayer(row, col) -> bool:
#	边界检测
	if row >= Global.MAPSIZE or row < 0 or col >= Global.MAPSIZE or col < 0:
		return false
	
	var target_pos = Vector2(4 + row * 54, 4 + col * 54 - 20)
	var tween = create_tween()
	tween.tween_property(self, "position", target_pos, moveAnimationDuration)
	return true

func playerFacing():
	$PlayerImg.texture = load("res://static/player/%s-%s.tres" % [Player.skinID, Player.facingText])
