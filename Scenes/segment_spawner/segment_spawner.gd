extends Node2D

@export var segments: Array[PackedScene]
@export var spawn_cap: int = 3

var spawned: int = 0

@onready var spawn_delay_timer: Timer = $SpawnDelay

func _on_spawn_delay_timeout() -> void:
	if spawned < spawn_cap:
		var segment_to_spawn: PackedScene = segments.pick_random()
		var new_segment = segment_to_spawn.instantiate()
		add_child(new_segment)
		spawned += 1
		
		await new_segment.tree_exited
		
		spawned -= 1
