extends Node2D

signal enemy_spawned(instance)

@onready var spawn_positions: Node2D = $SpawnPositions
@onready var spawn_timer: Timer = $SpawnTimer

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")

var difficulty_increase := 0.25
var minimum_difficulty := 0.25

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	var spawn_positions_array := spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	enemy_spawned.emit(enemy_instance)

func _on_difficulty_timer_timeout() -> void:
	if spawn_timer.wait_time > minimum_difficulty:
		spawn_timer.wait_time -= difficulty_increase
