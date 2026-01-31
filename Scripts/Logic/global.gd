extends Node

var game_manager : GameManager

const GUI_SCENE_PATH : String = "res://Scenes/UI/%s.tscn"
const WORLD_2D_SCENE_PATH : String = "res://Scenes/Game/Levels/%s.tscn"

const OPTIONS : String = "Options"
const TITLE_SCREEN : String = "title_screen"
const LOSE_SCREEN : String = "lose_screen"
const TEST_LEVEL : String = "test_level_farmland"
const HUD : String = "hud"

enum Direction 
{
	NONE = 0,
	LEFT = -1, 
	RIGHT = 1,
	UP = 1,
	DOWN = -1
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
