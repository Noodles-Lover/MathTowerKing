extends AudioStreamPlayer

var bgmPlayer = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.volume_db = -10
	add_child(bgmPlayer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func playAudio(name):
	self.stream = load("res://static/audios/%s.wav" % name)
	if (!self.stream): self.stream = load("res://static/audios/%s.mp3" % name)
#	self.stream.loop = false
	self.play()

func playUnCoverAudio(name):
	var audio_player = AudioStreamPlayer.new()
	
	audio_player.volume_db = -10
	audio_player.stream = load("res://static/audios/%s.wav" % name)
	if (!audio_player.stream): audio_player.stream = load("res://static/audios/%s.mp3" % name)
#	audio_player.connect("finished", self, "on_audio_finished")
# 待完成自动删除功能
	
	add_child(audio_player)
	audio_player.play()
	
func playBGM():
	bgmPlayer.volume_db = -20
	bgmPlayer.stream = load("res://static/audios/bgm.mp3")
	bgmPlayer.stream.loop = true
	bgmPlayer.play()
	
func stopBGM():
	bgmPlayer.stop()
