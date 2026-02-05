extends Meteor

@onready var time_until_it_starts_moving = $TimeUntilItStartsMoving

func _ready():
	speed = 0
	health = 200
	rotation_speed = randf_range(0.03, 0.05)
	audio.finished.connect(delete)
	time_until_it_starts_moving.start()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	

func _on_time_until_it_starts_moving_timeout():
	speed = 10
