extends Control

@onready var score_label: Label = $ScoreLabel
@onready var lives_left: Label = $LivesLeft

func set_score_label(new_score: int) -> void:
	score_label.text = "SCORE: " + str(new_score)

func set_lives(amount: int) -> void:
	lives_left.text = str(amount)
