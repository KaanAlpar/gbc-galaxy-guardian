extends Control

@onready var score_label: Label = $ScoreLabel

func set_score_label(new_score: int) -> void:
	score_label.text = "SCORE: " + str(new_score)
