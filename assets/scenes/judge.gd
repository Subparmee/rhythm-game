#judge.gd
extends Node2D
#perfect: 25ms, great 50ms, good 100ms, bad 200ms
var isMissed = [false, false, false, false, false, false, false]

func getJudgement(beat):
	var timing: float = abs(get_parent().getTime() - beat*get_parent().spb)*1000
	if timing >= 0 and timing <= 25:
		return 0
	elif timing <= 50:
		return 1
	elif timing <= 100:
		return 2
	elif timing <= 200:
		return 3
	return 4	

func pressed(lane: int) -> void:
	var beat = get_parent().notes[lane][get_parent().activeBeats[lane]].beat
	var judgement: int = getJudgement(beat)
	var noteType = get_parent().getActiveBeatType(lane)
	if noteType == 2:
		push_error("pressing on a hold end (somehow)")
		return
	
	if judgement == 4:
		return
	
	get_parent().activeBeats[lane] += 1
	
	if noteType == 0:
		get_parent().deleteBall(lane, false)
	elif noteType == 1:
		get_parent().holdStarted[lane] = true
		
	printJudgement(judgement)
	
	

func released(lane: int) -> void:
	if not get_parent().holdStarted[lane]:
		return
	
	if isMissed[lane]:
		return
	
	get_parent().holdStarted[lane] = false

	var note_type: int = get_parent().getActiveBeatType(lane)
	var beat = get_parent().notes[lane][get_parent().activeBeats[lane]].beat
	var judgement: int = getJudgement(beat)
	
	if judgement == 4:
		print("miss!")
		isMissed[lane] = true
		get_parent().missHold(lane)
		return
	
	if note_type == 2:
		get_parent().activeBeats[lane] += 1
		get_parent().deleteHold(lane, false)
		printJudgement(judgement)
	else:
		push_error("expected hold end note")

func checkPassed():
	for i in range(7):
		var timing:float = (get_parent().getTime() - get_parent().getActiveBeat(i)*get_parent().spb)*1000
		if get_parent().getActiveBeatType(i) == 2:
			if timing > 200:
				get_parent().activeBeats[i] += 1
				get_parent().deleteHold(i, true)
				get_parent().holdStarted[i] = false
				if isMissed[i] == true:
					isMissed[i] = false
					continue
				print("bad! (hold)")
		elif timing > 200:
			print("MISS!")
			if get_parent().getActiveBeatType(i) == 1:
				get_parent().activeBeats[i] += 1
				isMissed[i] = true
				get_parent().holdStarted[i] = false
			else:
				get_parent().activeBeats[i] += 1
				get_parent().deleteBall(i, true)

func printJudgement(judgement: int) -> void:
	match judgement:
		0:
			print("perfect!")
		1:
			print("great!")
		2:
			print("good!")
		3:
			print("bad!")
