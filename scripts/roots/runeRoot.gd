extends Node

@export var rune: Rune

signal runePressed(rune)

func _ready():
	if (!rune): return
	
	var textureNode = $PanelContainer/runeTexture
	var texturePath = "res://static/runes/%s.png" % rune.textureName
	
	textureNode.texture = load(texturePath)
	textureNode.tooltip_text = rune.description


func _process(delta):
	pass


func _on_rune_pressed():
	print("@ rune pressed")
	runePressed.emit(rune)
