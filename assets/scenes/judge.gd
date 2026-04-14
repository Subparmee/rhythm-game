extends Node2D
#best: 25ms, perfect 50ms, great 100ms, good 200ms


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

func pressed(button):
	var beat = get_parent().notes[button][get_parent().activeBeats[button]].beat
	var judgement: int = getJudgement(beat)
	if get_parent().getActiveBeatType(button) == 2:
		push_error("pressing on a hold end (somehow)")
		pass
	if judgement != 4:
		get_parent().activeBeats[button] += 1
		if get_parent().getActiveBeatType(button) == 0:
			get_parent().deleteBall(button)
		if judgement == 0:
			print("perfect!")
		elif judgement == 1:
			print("great!")
		elif judgement == 2:
			print("good!")
		elif judgement == 3:
			print("bad!")

func released(button):
	var beat = get_parent().notes[button][get_parent().activeBeats[button]].beat
	var judgement: int = getJudgement(beat)
	if get_parent().getActiveBeatType(button) != 2:
		#add error check
		pass
	if judgement != 4:
		get_parent().activeBeats[button] += 1
		if judgement == 0:
			print("perfect!")
		elif judgement == 1:
			print("great!")
		elif judgement == 2:
			print("good!")
		elif judgement == 3:
			print("bad!")
	else:
		print("MISS!")

func checkPassed():
	for i in range(7):
		var timing:float = (get_parent().getTime() - get_parent().getActiveBeat(i)*get_parent().spb)*1000
		if get_parent().holdStarted[i] == true:
			if timing > 200:
				get_parent().activeBeats[i] += 1
				print("bad! (hold)")
		elif timing > 200:
			print("MISS!")
			if get_parent().getActiveBeatType(i) == 1:
				get_parent().activeBeats[i] += 2
			else:
				get_parent().activeBeats[i] += 1
				get_parent().deleteBall(i)
