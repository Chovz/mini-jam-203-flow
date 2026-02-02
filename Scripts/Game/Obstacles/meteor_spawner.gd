extends Node2D

@export var enabled : bool = false
@export_range(0.01, 10.0, 0.01, "suffix:s") var time_between_spawns : float = 1.0

@export var spawn_area : CollisionShape2D
@onready var spawn_rate_timer = $spawn_rate_timer

@export_subgroup("Enemy spawns")
@export var small_meteor : bool = true
@export var small_meteor_percentage : float = 100.0
@export var extra_large_meteor : bool = true
@export var extra_large_meteor_percentage : float = 10.0

var rng = RandomNumberGenerator.new()

func _ready():
	spawn_rate_timer.wait_time = time_between_spawns
	spawn_area = $spawn_area
	if enabled:
		spawn_rate_timer.start()

func _on_spawn_rate_timer_timeout():
		if enabled:# and Global.game_manager.spawn_enemies_enabled:
			var meteor : Meteor = generate_random_meteor()
			meteor.position = generate_random_position_in_spawner()
			add_sibling(meteor)
			#Global.game_manager.current_world_2d_scene.add_child(enemy)

func generate_random_meteor() -> Meteor:
	var randomNumber = rng.randf_range(0.0, 100.0)
	
	var meteor : Meteor
	
	if extra_large_meteor and randomNumber < extra_large_meteor_percentage:
		meteor = Global.EXTRA_LARGE_METEOR.instantiate()
	elif small_meteor and randomNumber < small_meteor_percentage:
		meteor = Global.SMALL_METEOR.instantiate()
		
	return meteor

func generate_random_position_in_spawner() -> Vector2:
	var rect : Rect2 = spawn_area.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x + rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y + rect.size.y)
	var rand_point = global_position + Vector2(x,y) 
	return rand_point
	
