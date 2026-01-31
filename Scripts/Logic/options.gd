extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Back"):
		Global.game_manager.change_gui_scene("title_screen")

func _on_back_pressed() -> void:
	Global.game_manager.change_gui_scene("title_screen")
