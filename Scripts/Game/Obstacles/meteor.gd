class_name Meteor extends Area2D

var speed = 2
var rotation_speed : float
var health = 100
var direction : Vector2 = Vector2.LEFT
@export var audio : AudioStreamPlayer2D
@export var hitbox : CollisionShape2D
@export var hitbox2 : CollisionShape2D
@export var sprite : AnimatedSprite2D

func _physics_process(delta):
	move()
	
func move() -> void:
	rotate(rotation_speed) 
	position = position + direction * speed

func take_damage(damage) -> void:
	health = health - damage
	
	if health <= 0:
		break_meteor()

func break_meteor():
	audio.pitch_scale += randf_range(-0.1, 0.1)
	audio.play()
	hitbox.set_deferred("disabled", true)
	hitbox2.set_deferred("disabled", true)
	sprite.hide()

func delete():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player : SpaceShip = body
		player.get_hit()
		Global.game_manager.player_got_hit()
		#O directamente mandarlo a la v 

func _on_bullet_hitbox_area_entered(area):
	
	if area.is_in_group("Player_Bullets"):
		# bullet = area.to_bullet o algo asi
		# bullet_damage = bullet.damage
		var bullet_damage = 20
		take_damage(bullet_damage)
		area.queue_free()
