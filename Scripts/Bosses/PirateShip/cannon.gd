extends Node2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]
const CANNON_BALL = preload("res://Scenes/Bosses/PirateShip/cannon_ball.tscn")
const CANNON_EXPLOSION = preload("res://Scenes/Bosses/PirateShip/explosion.tscn")


const WAIT_TIME_MIN = 0.5
const WAIT_TIME_MAX = 2

@onready var shoot_timer: Timer = $ShootTimer
@onready var wind_up: Timer = $WindUp
@onready var shooting_point: Node2D = $ShootingPoint
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var preparingShot: bool = false
var readyToFire = false

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#shoot_timer.start(randomTimeForShot())
	
func _physics_process(delta: float) -> void:
	if(!preparingShot):
		look_at(player.global_position)
		rotation_degrees += 180
	
func randomTimeForShot() -> float:
	return randf_range(WAIT_TIME_MIN, WAIT_TIME_MAX)

func _on_shoot_timer_timeout() -> void:
	preparingShot = true
	animated_sprite.play("shooting")
	wind_up.start()

func _on_wind_up_timeout() -> void:
	shoot()
	animated_sprite.play("idle")
	preparingShot = false
	shoot_timer.start(randomTimeForShot())

func shoot() -> void:
	var new_cannon_ball = CANNON_BALL.instantiate()
	var explosion = CANNON_EXPLOSION.instantiate()
	new_cannon_ball.position = position + shooting_point.position
	explosion.position = new_cannon_ball.position
	new_cannon_ball.target_position = (shooting_point.global_position - global_position + Vector2(2, 2)).normalized()
	get_parent().add_child(new_cannon_ball)
	get_parent().add_child(explosion)

func prepareFire() -> void:
	animated_sprite.play("prepare")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "prepare":
		shoot_timer.start(randomTimeForShot())
		animated_sprite.play("idle")
