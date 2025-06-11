extends Button

@export var ui_input: String
#"ui_up"
#"ui_down"
#"ui_left"
#"ui_right"

func _ready():
	connect("pressed", Callable(self, "_pressed")) 

func _pressed():
#	print("[事件] 按钮模拟触发：" + ui_input)
	var event = InputEventAction.new()
	event.action = ui_input
	event.pressed = true
	Input.parse_input_event(event)
	
	# 模拟释放（可选）
	await get_tree().create_timer(0.01).timeout
	event.pressed = false
	Input.parse_input_event(event)
