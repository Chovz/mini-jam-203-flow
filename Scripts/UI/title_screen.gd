extends Control

func _on_start_pressed() -> void:
	Global.game_manager.newGame()


func _on_credits_pressed() -> void:
	Global.game_manager.change_gui_scene("credits")


func _on_options_pressed() -> void:
	Global.game_manager.change_gui_scene("options")
