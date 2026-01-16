extends Node2D

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = $SpawnPositions/SpawnPos_3.global_position
	add_child(enemy_instance)
