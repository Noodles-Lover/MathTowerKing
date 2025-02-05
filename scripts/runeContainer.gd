extends Node


func _ready():
	Player.updateRunes.connect(_on_update_runes)
	renderRune()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func renderRune():
	GameManager.remove_all_children(self)
	
	var scene
	for i in range(9):	# 9个以上就会超出界面
		if (len(Player.runes) <= i): scene = load("res://scenes/part_of/rune.tscn").instantiate()
		else: scene = Player.runes[i].getScene()
		scene.position = Vector2(0,i*55)
		add_child(scene)

func _on_update_runes():
	renderRune()

