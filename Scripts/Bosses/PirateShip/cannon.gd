extends Node2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]
const CANNON_BALL = preload("res://Scenes/Bosses/PirateShip/cannon_ball.tscn")

const WAIT_TIME_MIN = 1
const WAIT_TIME_MAX = 5

@onready var shoot_timer: Timer = $ShootTimer
@onready var wind_up: Timer = $WindUp
@onready var shooting_point: Node2D = $ShootingPoint
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.start(randomTimeForShot())
	
#func _process(delta: float) -> void:
	#look_at(player.global_position)
	#rotation_degrees += 180
	
func randomTimeForShot() -> float:
	return randf_range(WAIT_TIME_MIN, WAIT_TIME_MAX)

func shoot() -> void:
	var new_cannon_ball = CANNON_BALL.instantiate()
	#new_cannon_ball.position = position
	new_cannon_ball.target_position = (player.global_position - shooting_point.global_position).normalized()
	add_child(new_cannon_ball)


func _on_shoot_timer_timeout() -> void:
	animated_sprite.play("shooting")
	wind_up.start()

func _on_wind_up_timeout() -> void:
	animated_sprite.play("idle")
	shoot()
	shoot_timer.start(randomTimeForShot())
