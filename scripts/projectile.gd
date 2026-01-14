extends Area2D

var speed := 5.0

func _physics_process(delta: float) -> void:
	# global_position = global_position + speed
	global_position.x += speed
