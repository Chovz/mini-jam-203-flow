extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player : SpaceShip = body
		player.get_hit()
		Global.game_manager.player_got_hit()
