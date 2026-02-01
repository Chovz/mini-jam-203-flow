extends Area2D

const SPEED = 2

var health = 100
var direction : Vector2 = Vector2.LEFT

func _physics_process(delta):
	move()
	
func move() -> void:
	global_position = global_position + direction * SPEED

func damage_meteor(damage) -> void:
	health = health - damage
	
	if health <= 0:
		queue_free()


func _on_meteor_damage_area_entered(area):
	if area.is_in_group("Player"):
		pass #hurt player

func _on_bullet_hitbox_area_entered(area):
	
	if area.is_in_group("Player_Bullets"):
		damage_meteor(area.DAMAGE)
		area.queue_free()
