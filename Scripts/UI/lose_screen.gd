extends Control

func _on_yes_button_button_down():
	Global.game_manager.newGame()

func _on_main_menu_button_down():
	Global.game_manager.title_screen()
