extends Node2D

@export var player = Node2D

const CANNON_BALL = preload("res://Scenes/Bosses/PirateShip/cannon_ball.tscn")
const WAIT_TIME_MIN = 1
const WAIT_TIME_MAX = 5

var shoot_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer = $ShootTimer
	shoot_timer.start(randomTimeForShot())
	
func randomTimeForShot() -> float:
	return randf_range(WAIT_TIME_MIN, WAIT_TIME_MAX)

func shoot() -> void:
	var new_cannon_ball = CANNON_BALL.instantiate()
	#new_cannon_ball.position = position
	new_cannon_ball.target_position = (Vector2.ZERO - global_position).normalized()
	add_child(new_cannon_ball)


func _on_shoot_timer_timeout() -> void:
	print("SHooting....")
	shoot()
	shoot_timer.start(randomTimeForShot())
