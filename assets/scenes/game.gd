extends Node2D
var bpm :int = 170
var bps :float = bpm/60.0
var spb :float = 60.0/bpm
var balls_scene: PackedScene = preload("res://assets/scenes/balls.tscn")
var hold_scene: PackedScene = preload("res://assets/scenes/hold.tscn")
var speed:int = 1500
var basePosition = Vector2(439.685, 610.485)
var notes = [[],
[],
[],
[],
[],
[],
[]]
var currentNotes = [-1,-1,-1,-1,-1,-1,-1]
var currentHolds = [-1,-1,-1,-1,-1,-1,-1]
var summonedBalls = [[],[],[],[],[],[],[]]
var summonedHolds = [[],[],[],[],[],[],[]]
var activeBeats = [0,0,0,0,0,0,0]
var holdStarted = [false,false,false,false,false,false,false]
signal loadFinish
var start:bool = false

class Note:
	var beat: float
	var type: int
	#type 0 = normal note, type 1 = hold note start, type 2 = hold note end

func _on_composer_checks_finish() -> void:
	for i in range(7):
		for j in range($composer.noteBeats[i].size()):
			var note = Note.new()
			note.beat = $composer.noteBeats[i][j]
			note.type = $composer.noteType[i][j]
			notes[i].append(note)
	for i in range(7):
		currentNotes[i] = 0
	loadFinish.emit()
	start = true
	
func _process(delta: float) -> void:
	if start:
		$judge.checkPassed()
		for i in range(7):
			if notes[i][currentNotes[i]].beat*spb-getTime() < 0.5:
				if notes[i][currentNotes[i]].type == 0:
					playNote(i)
				if notes[i][currentNotes[i]].type == 1:
					playHold(i)
				if notes[i][currentNotes[i]].type == 2:
					#error check
					pass

func playNote(laneNum):
	var note = balls_scene.instantiate()
	var yChange = (notes[laneNum][currentNotes[laneNum]].beat*spb - getTime()) * speed
	var xChange = laneNum*136
	note.position = basePosition + Vector2(xChange, yChange*-1)
	note.scale = Vector2(0.205, 0.205)
	$Notes.add_child(note)
	summonedBalls[laneNum].append(note)
	currentNotes[laneNum] += 1

func deleteBall(laneNum):
	if summonedBalls[laneNum].size() > 0:
		var deletedBall = summonedBalls[laneNum].pop_front()
		if(is_instance_valid(deletedBall)):
			deletedBall.queue_free()

func playHold(laneNum):
	var note1 = balls_scene.instantiate()
	var y1: float = (notes[laneNum][currentNotes[laneNum]].beat*spb - getTime()) * speed
	var xChange: float = laneNum*136
	currentNotes[laneNum] += 1
	var y2:float = (notes[laneNum][currentNotes[laneNum]].beat*spb - getTime()) * speed
	currentNotes[laneNum] += 1
	var hold = hold_scene.instantiate()
	hold.makeNote(y1, y2)
	hold.position = basePosition + Vector2(xChange, (y1+y2)*-1/2)
	$Holds.add_child(hold)
	summonedHolds[laneNum].append(hold)
	

func deleteHold(laneNum):
	if summonedHolds[laneNum].size() > 0:
		var deletedHold = summonedHolds[laneNum].pop_front()
		if(is_instance_valid(deletedHold)):
			deletedHold.queue_free()

func getTime() -> float:
	return $music_player.currentTime

func pressKey(num:int):
	$judge.pressed(num)

func releaseKey(num:int):
	$judge.released(num)

func getActiveBeat(lane:int) -> int:
	return notes[lane][activeBeats[lane]].beat

func getActiveBeatType(lane:int) -> int:
	return notes[lane][activeBeats[lane]].type

func getJudgement(beat) -> int:
	return $judge.getJudgement(beat)
