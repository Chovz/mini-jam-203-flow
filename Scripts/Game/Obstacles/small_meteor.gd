extends Meteor

func _ready():
	speed = 3
	health = 100
	rotation_speed = randf_range(0.015, 0.03)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
