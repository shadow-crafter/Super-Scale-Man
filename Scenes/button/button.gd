extends Area2D

var pressed: bool = false
var success: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var sfx_player: AudioStreamPlayer2D = $ButtonPress

func _on_area_entered(_area: Area2D) -> void:
	if not success:
		pressed = true
		sprite.frame = int(pressed)
		sfx_player.play()

func _on_area_exited(_area: Area2D) -> void:
	if not success:
		pressed = false
		sprite.frame = int(pressed)
