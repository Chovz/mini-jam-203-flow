extends CharacterBody2D

const LASER_POINTER = preload("res://Scenes/Bosses/PirateShip/laser_pointer.tscn")
const LASER = preload("res://Scenes/Bosses/PirateShip/laser.tscn")

const UFO_TOP_LEFT = Vector2(-150, -161)
const UFO_BOTTOM_RIGHT = Vector2(-100, 176)
const SPEED = 300

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wait: Timer = $Wait
@onready var spawn_position: Node2D = $SpawnPosition

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
		targetShot.x = position.x - 300
		var pointer = LASER_POINTER.instantiate()
		pointer.position = spawn_position.position
		pointer.look_at(targetShot)
		pointer.rotation_degrees += 180
		add_child(pointer)
		wait.start()

func _on_wait_timeout() -> void:
	var laser = LASER.instantiate()
	laser.position = spawn_position.position
	laser.look_at(targetShot)
	laser.rotation_degrees += 180
	add_child(laser)

func _on_laser_duration_timeout() -> void:
	pass # Replace with function body.
