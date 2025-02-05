extends Node

@export_file var texturePath

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = load(texturePath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
