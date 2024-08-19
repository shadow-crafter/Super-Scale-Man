extends LevelSegment

@export var button_scene: PackedScene

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D
@onready var button_spawns: Array = $ButtonSpawns.get_children()
@onready var button_container: Node2D = $Buttons
@onready var sfx_player: AudioStreamPlayer2D = $ButtonSuccess

func _ready() -> void:
	var to_spawn_positions: Array[Vector2] = []
	
	var button_count: int = randi_range(1, 2)
	button_spawns.shuffle()
	for i in range(button_count):
		to_spawn_positions.append(button_spawns[i].position)
	
	for spawn_pos in to_spawn_positions:
		var new_button = button_scene.instantiate()
		new_button.position = spawn_pos
		button_container.add_child(new_button)

func _physics_process(_delta: float) -> void:
	if sprite.visible:
		var all_pressed: bool = true
		for button in button_container.get_children():
			if not button.pressed:
				all_pressed = false
				break
		
		if all_pressed:
			sprite.visible = false
			hitbox.disabled = true
			sfx_player.play()
			for button in button_container.get_children():
				button.success = true
