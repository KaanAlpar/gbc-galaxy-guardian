extends Area2D

var speed := 100.0

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta
