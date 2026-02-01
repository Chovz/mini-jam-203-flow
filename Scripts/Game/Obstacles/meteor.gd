class_name Meteor extends Area2D

var speed = 2
var health = 100
var direction : Vector2 = Vector2.LEFT
var can_delete_offscreen : bool = false

func _physics_process(delta):
	move()
	
func move() -> void:
	position = position + direction * speed

func take_damage(damage) -> void:
	health = health - damage
	
	if health <= 0:
		queue_free()


func _on_meteor_damage_area_entered(area):
	if area.is_in_group("Player"):
		pass #hurt player

func _on_bullet_hitbox_area_entered(area):
	
	if area.is_in_group("Player_Bullets"):
		# bullet = area.to_bullet o algo asi
		# bullet_damage = bullet.damage
		var bullet_damage = 20
		take_damage(bullet_damage)
		area.queue_free()
