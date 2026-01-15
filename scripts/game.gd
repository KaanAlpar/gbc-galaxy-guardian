extends Node2D

@onready var player: CharacterBody2D = $Player

var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	player.shoot_projectile.connect(_on_player_shoot_projectile)

func _on_player_shoot_projectile() -> void:
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = player.muzzle.global_position
	add_child(projectile_instance)
