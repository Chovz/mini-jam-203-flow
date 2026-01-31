extends Control

@onready var score = $PanelContainer/MarginContainer/VBoxContainer/Score


func _ready():
	score.text = "Your score: %s" % int(Global.game_manager.score)

func _on_yes_button_button_down():
	Global.game_manager.newGame()


func _on_main_menu_button_down():
	Global.game_manager.title_screen()
