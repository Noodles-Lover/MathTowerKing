extends Node

@export var num: int
@export var type: Number.TYPE

const COLOR = {
	"enemy": Color("ff0000"),
	"friend": Color("00ff28")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	render()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func render():
	GameManager.remove_all_children($HBoxContainer)
	
	if (num < 0):	# 下划线
		var UInum = TextureRect.new()
		UInum.texture = load("res://static/math/underline.tres")
		UInum.stretch_mode = UInum.STRETCH_KEEP_ASPECT_CENTERED
		UInum.custom_minimum_size = Vector2(50, 50)
		$HBoxContainer.add_child(UInum)
		return
	if (num >= 10000):
		num = 9999
	
	var nums = 1	# 数值的位数
	var multiDigits = num > 9		# 是否两位数
	var digits = []
	if (multiDigits): 
		nums = len(String.num_int64(num))	# 获取位数
		digits = extract_digits(nums)
	
	var texturePath: String
	var texture
	
	for i in range(nums):
		if (multiDigits):
			texturePath = "res://static/math/%d.tres" % digits[i]
			texture = load(texturePath)
		else:
			texturePath = "res://static/math/%d.tres" % num
			texture = load(texturePath)
	
		var UInum = TextureRect.new()
		UInum.texture = texture  # 设置纹理
		UInum.stretch_mode = UInum.STRETCH_KEEP_ASPECT_CENTERED
		UInum.mouse_filter = Control.MOUSE_FILTER_IGNORE
		UInum.custom_minimum_size = Vector2(50, 50)
		if (multiDigits): UInum.custom_minimum_size = Vector2(21, 50)
		
		match type:
			Number.TYPE.ENEMY:
#				print("enemy color")
				UInum.modulate = COLOR["enemy"]
			Number.TYPE.FRIEND:
#				print("friend color")
				UInum.modulate = COLOR["friend"]
			_:
#				print("default color")
				UInum.modulate = Color("ffffff")
		
		$HBoxContainer.add_child(UInum)

# 数字每一位转数组
# 1234 -> [1,2,3,4]
func extract_digits(nums):
	var digits = []
	var tempNum = num
	for i in range(nums):
		var digit = tempNum % 10	# 计算当前位的数值
		tempNum = floor(tempNum/10)
		digits.append(digit)
	digits.reverse()	# [0]为高位
	return digits	
