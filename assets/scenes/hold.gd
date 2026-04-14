extends Node2D
var speed: int = 1500
var balls_scene: PackedScene = preload("res://assets/scenes/balls.tscn")

func _process(delta):
	position += speed*delta*Vector2.DOWN

func makeNote(y1:float, y2:float):
	var holdLength:float = y2-y1
	$holdSprite.scale.y = holdLength/200
	var ball1 = balls_scene.instantiate()
	$balls.add_child(ball1)
	ball1.down = false
	ball1.scale = Vector2(0.205, 0.205)
	ball1.position = Vector2(0, holdLength/2)
	var ball2 = balls_scene.instantiate()
	$balls.add_child(ball2)
	ball2.down = false
	ball2.scale = Vector2(0.205, 0.205)
	ball2.position = Vector2(0, -holdLength/2)
