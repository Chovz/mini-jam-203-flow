class_name GameManager extends Node

@export var world_2d : Node2D
@export var gui : Control

var current_world_2d_scene : Node2D
var current_level : String
var current_gui_scene : Control
#var options_scene : Control

@onready var in_game_seconds_timer = $InGameSecondsTimer
@onready var score_timer: Timer = $ScoreTimer

var lose_state : bool = false
var in_game : bool = false
var can_enemies_move : bool = false
var in_game_seconds_passed : int = 0
var score : float = 0
var timePassed : int = 0

func _ready():
	Global.game_manager = self
	current_level = Global.TEST_LEVEL #Reemplazar con un nivel/escena de verdad
	restart_values_for_level()
	setup_scenes()
	change_gui_scene(Global.TITLE_SCREEN)
	
func setup_scenes():
	#current_gui_scene = $GUI/TitleScreen
	#options_scene = load(Global.GUI_SCENE_PATH % Global.OPTIONS).instantiate()
	pass

func change_world_2d_scene(new_scene_name: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_world_2d_scene != null:
		if delete:
			current_world_2d_scene.queue_free()
		elif keep_running:
			current_world_2d_scene.visible = false
		else:
			world_2d.remove_child(current_world_2d_scene)
	
	restart_values_for_level()
	current_level = new_scene_name
	
	var new_scene = load(Global.WORLD_2D_SCENE_PATH % new_scene_name).instantiate()
	world_2d.add_child(new_scene)
	current_world_2d_scene = new_scene
	
func change_gui_scene(new_scene_name: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
			
	var new_scene = load(Global.GUI_SCENE_PATH % new_scene_name).instantiate()
	gui.add_child(new_scene)
	current_gui_scene = new_scene

func restart_values_for_level():
	#spawn_enemies_enabled = false
	lose_state = false
	in_game = false
	can_enemies_move = false
	in_game_seconds_passed = 0
	in_game_seconds_timer.stop()
	score = 0
	
	
func start_level():
	#spawn_enemies_enabled = true
	lose_state = false
	in_game = true
	can_enemies_move = true
	in_game_seconds_passed = 0
	in_game_seconds_timer.start()
	score_timer.start()
		
func game_over():
	lose_state = true
	in_game = false
	#spawn_enemies_enabled = false
	can_enemies_move = false
	in_game_seconds_timer.stop()
	GameMusic.stop()
	change_gui_scene(Global.LOSE_SCREEN)
	current_world_2d_scene.queue_free()

func _on_in_game_seconds_timer_timeout():
	if in_game and not lose_state:
		in_game_seconds_passed += 1

func newGame() -> void:
	TitleScreenMusic.stop()
	gui.remove_child(current_gui_scene)
	#current_gui_scene.queue_free()
	GameMusic.play()
	restart_values_for_level()
	change_world_2d_scene(Global.TEST_LEVEL) #Reemplazar con un nivel/escena de verdad
	change_gui_scene(Global.HUD)
	start_level()
	gameConnections()

func title_screen():
	change_gui_scene(Global.TITLE_SCREEN)
	if TitleScreenMusic.playing == false:
		TitleScreenMusic.play()

func reload_current_level():
	restart_values_for_level()
	change_world_2d_scene(current_level)
	GameMusic.play()
	start_level()

func gameConnections():
	#var playerNode = current_world_2d_scene.get_node("Player")
	score_timer.start()
	


func updateGameScore():
	#score += ceil(POINTS_PER_FARM * farmland_on_current_scene)
	
	current_gui_scene.changeScore(score)

func _on_score_timer_timeout() -> void:
	if current_world_2d_scene == null:
		return
	
	updateGameScore()
	timePassed += 1
	#updateEnemySpawnRates()
