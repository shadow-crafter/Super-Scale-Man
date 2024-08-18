extends LevelSegment

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sfx_player: AudioStreamPlayer2D = $SFX

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get_parent().scale.x >= 5.0 and sprite.visible:
		sprite.visible = false
		sfx_player.play()
		hitbox.set_deferred("disabled", true)
