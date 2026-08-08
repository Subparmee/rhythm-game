#board_control.gd
extends Node2D

var target_scene: PackedScene = preload("res://assets/scenes/target.tscn")

func createLayout():
	for i in range(4):
		var target = target_scene.instantiate()
		target.scale = Vector2(0.105, 0.105)
		target.position = get_parent().basePosition + Vector2(i*get_parent().xDif, 0)
		$Targets.add_child(target)
		get_parent().targets.append(target)
