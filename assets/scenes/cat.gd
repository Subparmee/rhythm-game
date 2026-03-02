extends Sprite2D
signal timestart
var canCat: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canCat = true
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_player_button_1() -> void:
	if canCat == true:
		visible = true
		timestart.emit()
		canCat = false
		$Timer.start(0.25)



func _on_timer_timeout() -> void:
	visible = false
	canCat = true
