extends Node2D

@onready var player: Player = $Player
@onready var score_label: Label = $Hud/Control/MarginContainer/ScoreLabel

func _ready() -> void:
	player.died.connect(_on_player_died)
	player.bonus_detected.connect(player_got_bonus)
	Game_Data.game_started()

func _on_player_died() -> void:
	Game_Data.game_ended()
	get_tree().call_deferred("reload_current_scene")

func player_got_bonus() -> void:
	Game_Data.score += 10
	update_score_text()

func _on_score_timer_timeout() -> void:
	Game_Data.score += 1
	update_score_text()

func update_score_text() -> void:
	score_label.text = "Score: " + str(Game_Data.score)
