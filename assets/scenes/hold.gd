#hold.gd
extends Node2D
var speed: int = 1500
var lane: int = -1

var balls_scene: PackedScene = preload("res://assets/scenes/balls.tscn")

func _physics_process(delta):
	position += speed*delta*Vector2.DOWN
	
	if lane == -1:
		return
	
	var game = get_parent().get_parent().get_parent()
	var clipping: bool = game.holdStarted[lane]

	material.set_shader_parameter(
		"clipping_enabled",
		clipping
	)
	
	var viewport_height: float = get_viewport_rect().size.y
	var target_screen_y: float = game.basePosition.y / viewport_height

	material.set_shader_parameter(
		"target_screen_y",
		target_screen_y
	)



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


func miss() -> void:
	material.set_shader_parameter("clipping_enabled", false)
