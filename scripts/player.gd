extends CharacterBody2D
class_name Player

signal shoot_projectile
signal died

@onready var main_ap: AnimationPlayer = $MainAP
@onready var flash_ap: AnimationPlayer = $FlashAP
@onready var muzzle: Marker2D = $Muzzle

var speed := 120.0
var is_alive := true

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

func die() -> void:
	died.emit()
	is_alive = false
	main_ap.play("explode")
