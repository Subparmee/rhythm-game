extends Node2D
var speed:int = 1500

func _process(delta):
	position += speed*delta*Vector2.DOWN
	if Input.is_action_just_pressed("button1"):
		animation()

func animation():
	$AnimatedSprite2D.frame = 1
	$Timer.start(0.1)


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame = 0
