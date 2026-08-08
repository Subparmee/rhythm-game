extends Node2D

var score: float = 0
var playerTotal: float = 0
var maxTotal: float = 0
var combo: int = 0
var maxCombo: int = 0
var perfectCount: int = 0
var greatCount: int = 0
var goodCount: int = 0
var badCount: int = 0
var missCount: int = 0

var percentages =[
	100,
	90,
	70,
	50,
	0
]

func reset() -> void:
	score = 0
	playerTotal = 0
	maxTotal = 0
	combo = 0
	maxCombo = 0
	perfectCount = 0
	greatCount = 0
	goodCount = 0
	badCount = 0
	missCount = 0

func addScore(judgement: int):
	maxTotal += 100
	playerTotal += percentages[judgement]
	score = playerTotal/maxTotal
