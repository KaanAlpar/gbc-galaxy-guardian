extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed := 120.0

func _ready() -> void:
	print(speed)

func _physics_process(_delta: float) -> void:
	var horizontal_dir := Input.get_axis("move_left", "move_right")
	var vertical_dir := Input.get_axis("move_up", "move_down")
	
	var direction := Vector2(horizontal_dir, vertical_dir).normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	var viewport_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2.ZERO, viewport_size)
	
	if vertical_dir < 0.0:
		animation_player.play("up")
	elif vertical_dir > 0.0:
		animation_player.play("down")
	else:
		animation_player.play("default")
