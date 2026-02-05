extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game_manager.heatChange.connect(update)
	update()

func update() -> void:
	value = Global.game_manager.heat
