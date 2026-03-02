extends Node2D
var buttons = ["button1", "button2", "button3", "button4", "up1", "up2", "up3"]
var start:bool = false

func _process(delta):
	if start:
		for i in range(7):
			if Input.is_action_just_pressed(buttons[i]):
				get_parent().pressKey(i)
		for i in range(7):
			if get_parent().holdStarted[i] == true:
				if !Input.is_action_pressed(buttons[i]):
					get_parent().releaseKey(i)
	pass
	


func _on_game_load_finish() -> void:
	start = true
