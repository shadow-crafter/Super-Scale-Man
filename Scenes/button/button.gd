extends Area2D

var pressed: bool = false

@onready var sprite: Sprite2D = $Sprite2D

func _on_area_entered(_area: Area2D) -> void:
	pressed = true
	sprite.frame = int(pressed)

func _on_area_exited(_area: Area2D) -> void:
	pressed = false
	sprite.frame = int(pressed)
