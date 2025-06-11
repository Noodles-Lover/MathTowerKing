extends Button

func _ready():
	if is_mobile_device():
		Global.isMobile = true
	self.button_pressed = Global.isMobile

func _toggled(button_pressed):
	print("[事件] mobile: " + str(button_pressed))
	Global.isMobile = button_pressed

func is_mobile_device() -> bool:
	var platform = OS.get_name()
	return platform in ["Android", "iOS"]
