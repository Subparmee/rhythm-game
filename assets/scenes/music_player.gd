extends AudioStreamPlayer
var currentTime :float = 0.0
var currentBeat :float = 0.0
var delay :float = 0.0
var start: bool = false
func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if start:
		currentTime = get_playback_position() + AudioServer.get_time_since_last_mix() + delay
		currentBeat = currentTime * get_parent().bps
	pass

func _on_game_load_finish() -> void:
	start = true
