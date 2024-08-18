class_name Player extends CharacterBody2D

@export var move_speed: float = 256.0
@export var acceleration: float = 256.0
@export var rotation_max: float = deg_to_rad(10)
@export var rot_speed: float = deg_to_rad(20)
@export var gravity: float = 80.0

var speed: float = 0.0
var rot: float = 0.0
var tmp_scale: float = 2.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var bounce_sfx: AudioStreamPlayer2D = $Bounce

func _physics_process(delta: float) -> void:
	scale_player()
	move_player(delta)
	screenwrap()

func move_player(delta: float) -> void:
	var move_direction: float = Input.get_axis("Move_up", "Move_down")
	
	speed = move_toward(speed, move_speed * move_direction + gravity, acceleration * delta)
	velocity = Vector2(0, speed)
	
	var rot_dir: float = move_direction
	if rot_dir == 0.0:
		rot_dir = velocity.normalized().y
	rot = move_toward(rot, rotation_max * rot_dir, rot_speed * delta)
	sprite.rotation = rot
	
	move_and_slide()

func scale_player() -> void:
	if Input.is_action_just_pressed("Scale_up"):
		tmp_scale += 0.5
		bounce_sfx.play()
	elif Input.is_action_just_pressed("Scale_down"):
		tmp_scale -= 0.5
		bounce_sfx.play()
	tmp_scale = clampf(tmp_scale, 0.5, 8)
	scale = Vector2(tmp_scale, tmp_scale)

func screenwrap() -> void:
	if position.y > (256 + 8 * tmp_scale):
		position.y = 0
	elif position.y < (0 - 8 * tmp_scale):
		position.y = 256


func _on_hurtbox_area_entered(_area: Area2D) -> void:
	get_tree().call_deferred("reload_current_scene")
