class_name SpaceShip extends CharacterBody2D

const SPEED = 450.0
const SPACE_SHIP_WIDTH = 54
const BULLET_WIDTH = 5
const BULLET_SPAWN_OFFSET : Vector2 = Vector2(BULLET_WIDTH + SPACE_SHIP_WIDTH/2, 2)

@onready var shooting_cooldown: Timer = $Timers/ShootingCooldown
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var isAttacking: bool = false
var canSpawnBullet: bool = true

func _physics_process(delta):
	playerInput()

func playerInput() -> void:
	playerMovement(Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down"))
	playerActions()

func playerMovement(direction: Vector2) -> void:
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
	
	#get the viewport size and divide by 2 since this is where the camera is positioned
	var view = get_viewport_rect().size / 2

	#get the camera position
	var camera_pos = $"../Camera2D".global_position

	var bounds_bw = camera_pos.x - view.x #the camera bounds at the back
	var bounds_fw = camera_pos.x + view.x #the camera bounds at the front
	
	var bounds_up = camera_pos.y - view.y #the camera bounds up
	var bounds_down = camera_pos.y + view.y #the camera bounds down

	#after the character is moved clamp its position to the end of the camera bounds
	global_position.x = clamp(global_position.x, bounds_bw, bounds_fw)
	global_position.y = clamp(global_position.y, bounds_up, bounds_down)

func playerActions() -> void:
	if Input.is_action_pressed("Attack"):
		isAttacking = true
	else:
		isAttacking = false
		
	if isAttacking:
		if canSpawnBullet:
			audio_stream_player_2d.play()
			spawn_bullet()
			canSpawnBullet = false
			shooting_cooldown.start()
			
func spawn_bullet() -> void:
	var bullet = Global.BULLET.instantiate()
	var position_check = position
	var global_position_check = global_position
	var bullet_position = bullet.position
	bullet.position = global_position + BULLET_SPAWN_OFFSET
	var final_position = bullet.position
	#Siempre van a ir para la derecha
	get_tree().current_scene.add_child(bullet)

func get_hit() -> void:
	#explode
	#reiniciar desde checkpoint
	pass

func _on_shooting_cooldown_timeout():
	canSpawnBullet = true
