extends Node2D

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	player.shoot_projectile.connect(_on_player_shoot_projectile)

func _on_player_shoot_projectile() -> void:
	print("Player wants to shoot!")
