extends Node2D
var speed:int = 1500
var down:bool = true

func _process(delta):
	if down:
		position += speed*delta*Vector2.DOWN

func animation():
	$AnimatedSprite2D.frame = 1
	$Timer.start(0.1)


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame = 0
