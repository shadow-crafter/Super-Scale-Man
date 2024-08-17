class_name LevelSegment extends Node2D

@export var move_speed = 64.0

func _physics_process(delta: float) -> void:
	position.x -= move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
