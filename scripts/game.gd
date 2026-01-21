extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var respawn_timer: Timer = $RespawnTimer
@onready var player_spawn_position: Marker2D = $PlayerSpawnPosition
@onready var hud: Control = $UILayer/HUD

var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")

var lives := 3
var score := 0

func _ready() -> void:
	hud.set_lives(lives)
	hud.set_score_label(score)
	
	player.shoot_projectile.connect(_on_player_shoot_projectile)
	player.died.connect(_on_player_died)

func _on_player_shoot_projectile() -> void:
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_position = player.muzzle.global_position
	add_child(projectile_instance)

func _on_enemy_spawner_enemy_spawned(instance) -> void:
	instance.died.connect(_on_enemy_died)
	add_child(instance)

func _on_enemy_deathzone_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.queue_free()

func _on_player_died() -> void:
	lives -= 1
	hud.set_lives(lives)
	
	if lives > 0:
		respawn_timer.start()
	else:
		print("Game over")

func _on_respawn_timer_timeout() -> void:
	player.respawn(player_spawn_position.global_position)

func _on_enemy_died() -> void:
	score += 100
	hud.set_score_label(score)
