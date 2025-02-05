class_name Block
extends Node

enum BLOCKTYPE{
	CHEST,
	ENEMY,
	FRIEND,
	CAMPFIRE
}

const SPRITESIZE = 50
var row: int
var col: int

func _init(row, col):
	self.row = row
	self.col = col

static func placeBlock(i, j, scene):
	if (i >= Global.MAPSIZE || i < 0 || j >= Global.MAPSIZE || j < 0):  return false
	scene.position = Vector2(4 + i * 54, 4 + j * 54)
#	print("place block %d %d" % [i, j])
	return true

func destorySelf():
#	print("destory self signal")
	GameManager.destory.emit(row, col)
	
func execute():		# 抽象函数
	pass
	
static func getScene():		# 抽象函数
	pass
	



