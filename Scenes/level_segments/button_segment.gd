extends LevelSegment

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D
@onready var button_container: Node2D = $Buttons

func _physics_process(_delta: float) -> void:
	var all_pressed: bool = true
	for button in button_container.get_children():
		if not button.pressed:
			all_pressed = false
			break
	
	if all_pressed:
		sprite.visible = false
		hitbox.disabled = true
