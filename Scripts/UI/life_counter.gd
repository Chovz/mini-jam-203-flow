extends Control

@onready var label: Label = $Label

var lives: int = 3

func _ready() -> void:
	Global.game_manager.lostLife.connect(updateLives)
	updateLives()

func updateLives():
	lives = Global.game_manager.player_lives
	label.text = "x" + str(lives)
