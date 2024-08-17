extends LevelSegment

@onready var top_sprite: Sprite2D = $Sprite2D
@onready var top_collider: CollisionPolygon2D = $Area2D/CollisionPolygon2D

func _ready() -> void:
	position += Vector2(16, randi_range(-82, 82))
	if randi_range(1, 2) == 2:
		top_sprite.offset.y = randi_range(-42, 42)
		top_collider.position.y = top_sprite.offset.y
