extends Meteor

const METEOR_SPAWN_OFFSET = 10
const LOWER_ANGLE_LIMIT = -0.5
const UPPER_ANGLE_LIMIT = 0.5

var rng = RandomNumberGenerator.new()

func _ready():
	speed = 1
	health = 150
	rotation_speed = randf_range(0.015, 0.025)
	audio.finished.connect(delete)

func take_damage(damage) -> void:
	health = health - damage
	
	if health <= 0:
		break_meteor()
		var small_meteor_1 = Global.SMALL_METEOR.instantiate()
		var small_meteor_2 = Global.SMALL_METEOR.instantiate()
		add_sibling(small_meteor_1)
		add_sibling(small_meteor_2)
		
		small_meteor_1.position = position + Vector2.UP * METEOR_SPAWN_OFFSET
		small_meteor_2.position = position + Vector2.DOWN * METEOR_SPAWN_OFFSET
		
		# El angulo al que van a ir
		small_meteor_1.direction = Vector2(-1, rng.randf_range(LOWER_ANGLE_LIMIT, 0))
		small_meteor_2.direction = Vector2(-1, rng.randf_range(0, UPPER_ANGLE_LIMIT))
		
		get_tree().current_scene.add_child(small_meteor_1)
		get_tree().current_scene.add_child(small_meteor_2)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
