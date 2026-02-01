extends CharacterBody2D

const LASER_POINTER = preload("res://Scenes/Bosses/PirateShip/laser_pointer.tscn")
const LASER = preload("res://Scenes/Bosses/PirateShip/laser.tscn")

const UFO_TOP_LEFT = Vector2(-150, -161)
const UFO_BOTTOM_RIGHT = Vector2(-100, 176)
const SPEED = 250

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wait: Timer = $Wait
@onready var laser_duration: Timer = $LaserDuration
@onready var spawn_position: Node2D = $SpawnPosition

var pointer = LASER_POINTER.instantiate()
var laser = LASER.instantiate()

var targetPosition: Vector2
var targetShot: Vector2
var gunReady = false

func _ready() -> void:
	targetPosition = chooseRandomPostion()

func _physics_process(delta: float) -> void:
	var distance_to_destination
	var distance_to_move
	if position != targetPosition: # only move if we aren't there
		distance_to_destination = position.distance_to(targetPosition)
		distance_to_move = SPEED * delta
		if abs(distance_to_destination) < abs(distance_to_move): # if we are close, just move to destination
			distance_to_move = distance_to_destination
		position += position.direction_to(targetPosition) * distance_to_move
	else:
		if !gunReady:
			prepareGun()

func chooseRandomPostion() -> Vector2:
	return Vector2(randf_range(UFO_TOP_LEFT.x, UFO_BOTTOM_RIGHT.x), randf_range(UFO_TOP_LEFT.y, UFO_BOTTOM_RIGHT.y))
	
func prepareGun() -> void:
	gunReady = true
	animated_sprite_2d.play("prepareGun")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "prepareGun":	
		targetShot = chooseRandomPostion()
		targetShot.x = position.x - 350
		pointer.position = spawn_position.position
		pointer.look_at(targetShot)
		pointer.rotation_degrees += 180
		add_child(pointer)
		wait.start()
	elif animated_sprite_2d.animation == "hideGun":
		targetPosition.x = 200

func _on_wait_timeout() -> void:
	pointer.queue_free()
	laser.position = spawn_position.position
	laser.look_at(targetShot)
	laser.rotation_degrees += 180
	add_child(laser)
	laser_duration.start()

func _on_laser_duration_timeout() -> void:
	laser.queue_free()
	animated_sprite_2d.play("hideGun")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
