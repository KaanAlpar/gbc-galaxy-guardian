extends CharacterBody2D

var speed := 120

func _physics_process(_delta: float) -> void:
	var horizontal_dir := Input.get_axis("move_left", "move_right")
	var vertical_dir := Input.get_axis("move_up", "move_down")
	
	var direction := Vector2(horizontal_dir, vertical_dir).normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	var viewport_size = get_viewport_rect().size
	if global_position.x < 0.0:
		global_position.x = 0.0
	if global_position.x > viewport_size.x:
		global_position.x = viewport_size.x
		
	if global_position.y < 0.0:
		global_position.y = 0.0
	if global_position.y > viewport_size.y:
		global_position.y = viewport_size.y
