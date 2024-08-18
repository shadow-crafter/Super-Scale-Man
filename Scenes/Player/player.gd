class_name Player extends CharacterBody2D

signal died
signal bonus_detected

@export var move_speed: float = 256.0
@export var acceleration: float = 256.0
@export var rotation_max: float = deg_to_rad(10)
@export var rot_speed: float = deg_to_rad(20)
@export var gravity: float = 80.0

var speed: float = 0.0
var rot: float = 0.0
var tmp_scale: float = 2.0
var bonus_cd: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var bounce_sfx: AudioStreamPlayer2D = $Bounce
@onready var bonus_sfx: AudioStreamPlayer2D = $Bonus
@onready var bonus_detector: Node2D = $BonusDetector

func _physics_process(delta: float) -> void:
	scale_player()
	move_player(delta)
	check_bonus()
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

func check_bonus() -> void:
	if bonus_cd:
		return
	var both_colliding = true
	for ray in bonus_detector.get_children():
		if not ray.is_colliding():
			both_colliding = false
			break
	
	if both_colliding:
		bonus_detected.emit()
		bonus_sfx.play()
		
		bonus_cd = true
		await get_tree().create_timer(2).timeout
		bonus_cd = false

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	died.emit()
	queue_free()
