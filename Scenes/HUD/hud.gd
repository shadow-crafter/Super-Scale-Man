class_name HUD extends CanvasLayer

@onready var bonus_label: RichTextLabel = $Control/MarginContainer/BonusText
@onready var score_label: Label = $Control/MarginContainer/ScoreLabel
@onready var scorel: Label = $Control/GameOverScreen/Panel/MarginContainer/VBoxContainer/Score
@onready var highscorel: Label = $Control/GameOverScreen/Panel/MarginContainer/VBoxContainer/Highscore
@onready var game_over_screen: MarginContainer = $Control/GameOverScreen

func show_bonus_label() -> void:
	bonus_label.visible = true
	await get_tree().create_timer(1).timeout
	bonus_label.visible = false

func update_score_text() -> void:
	score_label.text = "Score: " + str(Game_Data.score)

func show_gameover() -> void:
	game_over_screen.visible = true
	scorel.text = "Final Score: " + str(Game_Data.score)
	highscorel.text = "Highscore: " + str(Game_Data.highscore)

func _on_try_again_button_pressed() -> void:
	get_tree().reload_current_scene()
