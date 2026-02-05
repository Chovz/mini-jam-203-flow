extends Control

@onready var progress_bar = $ProgressBar
@onready var player_indicator = $"player indicator"

var initial_player_x_position
var progres_bar_length
var distance_per_percentage_advanced
var progress

func _ready():
	initial_player_x_position = player_indicator.position.x
	progres_bar_length = progress_bar.size.x
	distance_per_percentage_advanced = progres_bar_length / 100
	Global.game_manager.updateTime.connect(update)
	update()

func _on_progress_bar_value_changed(value):
	player_indicator.position.x = initial_player_x_position * distance_per_percentage_advanced

	

func update() -> void:
	progress = Global.game_manager.in_game_seconds_passed
	progress_bar.value = progress
