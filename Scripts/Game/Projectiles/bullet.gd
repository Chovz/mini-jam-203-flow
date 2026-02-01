extends Area2D

const DAMAGE = 5
const SPEED = 10

const direction: Vector2 = Vector2.RIGHT

func _physics_process(delta):
	position.x += direction.x * SPEED
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	#body.takeDamage(MAGIC_DAMAGE, Global.Debuffs.BLOOM)
	#queue_free()
	pass
