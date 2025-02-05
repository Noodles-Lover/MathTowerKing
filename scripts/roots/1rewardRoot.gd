extends Node

@export var rune: Rune

func _ready():
#	scene1.itemPressed.connect(choosedItem)
	
	var scene = rune.getScene()
	scene.scale = Vector2(0.1,0.1)
	scene.position = Vector2(160,160)
	$runeDisplay.add_child(scene)
	
	$titleContainer/title.text = rune.runeName
	
	# 符文放大动画
	var tween = get_tree().create_tween()
	const DURATION = 0.35
	tween.tween_property(scene, "scale",  Vector2(1.5,1.5), DURATION)	# (节点, 属性, 目标值, 时长)
	
	tween.set_ease(Tween.EASE_IN_OUT)  # 动画开始和结束时会减速
	tween.play()


var frame = 0
func _process(delta):
	frame += 1
	
	if (frame % 10 == 0):
		$runeDisplay/brightEffect.rotation += 0.5
	pass



func _on_yes_pressed():
	Player.addRune(rune)
	GameManager.paused = false
	queue_free()


func _on_no_pressed():
	GameManager.paused = false
	queue_free()
