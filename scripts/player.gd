extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	velocity = Vector2(100, 50)
	move_and_slide()
