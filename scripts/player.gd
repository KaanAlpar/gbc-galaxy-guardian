extends CharacterBody2D
class_name Player

signal shoot_projectile
signal died

@onready var main_ap: AnimationPlayer = $MainAP
@onready var flash_ap: AnimationPlayer = $FlashAP
@onready var muzzle: Marker2D = $Muzzle
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var laser_sound: AudioStreamPlayer = $LaserSound

var laser_sounds := [preload("res://assets/audio/shot 1.wav"), preload("res://assets/audio/shot 2.wav")]

var speed := 120.0
var is_alive := true
var is_invincible := false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if is_alive == false:
		return
	
	if Input.is_action_just_pressed("shoot"):
		flash_ap.play("shoot_laser")

func _physics_process(_delta: float) -> void:
	if is_alive == false:
		return
		
	var horizontal_dir := Input.get_axis("move_left", "move_right")
	var vertical_dir := Input.get_axis("move_up", "move_down")
	
	var direction := Vector2(horizontal_dir, vertical_dir).normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	var viewport_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2.ZERO, viewport_size)
	
	if vertical_dir < 0.0:
		main_ap.play("up")
	elif vertical_dir > 0.0:
		main_ap.play("down")
	else:
		main_ap.play("default")

func shoot() -> void:
	shoot_projectile.emit()
	play_laser_sound()

func die() -> void:
	if is_invincible:
		return
	
	died.emit()
	is_alive = false
	main_ap.play("explode")

func respawn(spawn_position: Vector2) -> void: 
	global_position = spawn_position
	is_alive = true
	sprite_2d.visible = true
	
	is_invincible = true
	invincibility_timer.start()

func _on_invincibility_timer_timeout() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	is_invincible = false

func play_laser_sound():
	var sound_to_play = laser_sounds.pick_random()
	laser_sound.stream = sound_to_play
	laser_sound.play()
