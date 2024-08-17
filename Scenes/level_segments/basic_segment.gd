extends LevelSegment

func _ready() -> void:
	position += Vector2(0, randi_range(-128, 128))
