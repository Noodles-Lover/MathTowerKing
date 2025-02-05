extends Node

@export var symbol: String


# Called when the node enters the scene tree for the first time.
func _ready():
	render()
	

func _process(delta):
	pass

func render():
	GameManager.remove_all_children(self)
	
	if (!symbol):	# 下划线
		var UIsymbol = TextureRect.new()
		UIsymbol.texture = load("res://static/math/underline.tres")
		UIsymbol.stretch_mode = UIsymbol.STRETCH_KEEP_ASPECT_CENTERED
		UIsymbol.custom_minimum_size = Vector2(50, 50)
		add_child(UIsymbol)
		return
	
	var textureName: String

	match symbol:
		"+":
			textureName = "plus"
		"-":
			textureName = "minus"
		"*":
			textureName = "multiply"
		"/":
			textureName = "divide"
		":":
			textureName = "colon"
		"=":
			textureName = "equal"
			
	var texturePath = "res://static/math/%s.tres" % textureName
#	print(texturePath)
	var texture = load(texturePath)
	
	var UIsymbol = TextureRect.new()
	UIsymbol.texture = texture  # 设置纹理
	UIsymbol.stretch_mode = UIsymbol.STRETCH_KEEP_ASPECT_CENTERED
	UIsymbol.custom_minimum_size = Vector2(50, 50)
	UIsymbol.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	add_child(UIsymbol)
