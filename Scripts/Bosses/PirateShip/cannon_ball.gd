extends CharacterBody2D

const BULLET_SPEED_MIN = 100
const BULLET_SPEED_MAX = 800

var target_position: Vector2
var speed : float

func _ready() -> void:
	speed = randf_range(BULLET_SPEED_MIN, BULLET_SPEED_MAX)

func _physics_process(delta: float) -> void:
	velocity = target_position * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			print(collision.get_collider().name)
			if collision.get_collider().name=="player":
				queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
