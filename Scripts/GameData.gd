class_name GameData extends Node

var score: int = 0
var highscore: int = 0

func game_started() -> void:
	score = 0

func game_ended() -> void:
	if score > highscore:
		highscore = score
