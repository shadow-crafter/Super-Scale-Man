extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var score_label: Label = $Hud/Control/MarginContainer/ScoreLabel

func _ready() -> void:
	player.died.connect(_on_player_died)
	Game_Data.game_started()

func _on_player_died() -> void:
	Game_Data.game_ended()
	get_tree().reload_current_scene()

func _on_score_timer_timeout() -> void:
	Game_Data.score += 1
	score_label.text = "Score: " + str(Game_Data.score)
