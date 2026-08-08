extends Node2D

var foo = false

func _ready() -> void:
	setBaseAnimation()

func setHoldAnimation() -> void:
	$TargetSprite.frame = 1
	foo = true

func setBaseAnimation() -> void:
	$TargetSprite.frame = 0
	foo = false
