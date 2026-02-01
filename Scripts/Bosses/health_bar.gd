extends TextureProgressBar

@export var boss: Boss

func _ready() -> void:
	max_value = boss.STARTING_HEALTH
	boss.healthChanged.connect(update)
	update()

func update() -> void:
	value = boss.currentHealth
