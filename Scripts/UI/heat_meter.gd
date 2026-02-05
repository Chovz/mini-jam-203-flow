extends TextureProgressBar
@onready var shake: Timer = $Shake

var originalPosition : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game_manager.heatChange.connect(update)
	originalPosition = position
	update()

func update() -> void:
	value = Global.game_manager.heat
	
	if value > 70:
		shake.start()
	else:
		position = originalPosition
		shake.stop()

func _on_shake_timeout() -> void:
	position += Vector2(randf_range(-1, 1), randf_range(-1, 1))
