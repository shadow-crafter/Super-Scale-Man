extends Node2D

@onready var player: Player = $Player
@onready var hud: HUD = get_tree().get_first_node_in_group("Hud")

func _ready() -> void:
	player.died.connect(_on_player_died)
	player.bonus_detected.connect(player_got_bonus)
	Game_Data.game_started()

func _on_player_died() -> void:
	Game_Data.game_ended()
	hud.show_gameover()

func player_got_bonus() -> void:
	Game_Data.score += 10
	hud.update_score_text()
	hud.show_bonus_label()

func _on_score_timer_timeout() -> void:
	if not player.dead:
		Game_Data.score += 1
		hud.update_score_text()
