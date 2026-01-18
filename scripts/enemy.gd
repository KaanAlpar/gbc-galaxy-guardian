extends Area2D
class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed := 100.0

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func die() -> void:
	animation_player.play("explode")
