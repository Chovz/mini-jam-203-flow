extends Control

@onready var v_box_container: VBoxContainer = $PanelContainer/ScrollContainer/VBoxContainer
@onready var scroll_container: ScrollContainer = $PanelContainer/ScrollContainer

var authors = [
	"Chovz",
	"Kilu682"
]

var assets = [
	"White Scape - Nulltale - https://nulltale.itch.io/white-scape"
]

var music = [
	"Twisting by Kevin MacLeod -- incompetech.com --",
	"Licensed under Creative Commons: By Attribution 4.0 License",
	"Mesmerizing Galaxy by Kevin MacLeod -- incompetech.com --",
	"Licensed under Creative Commons: By Attribution 4.0 License"
]

var sfxs = [
	"Digging.m4a by TheScarlettWitch89 -- freesound.org -- License: Attribution 3.0",
	"ANIMAL_PUG_DOG_BARK_YELP_GROAN_BREATH_NICKER_MONSTER_H4N_NTG3_20120528.wav",
	"by samueljustice00 -- freesound.org -- License: Creative Commons 0",
	"swoosh-1.mp3 by lesaucisson -- freesound.org -- License: Creative Commons 0",
	"Thump by bareform -- freesound.org -- License: Attribution 4.0"
]

func _ready() -> void:
	createLabel("Created by:", 30)
	for author in authors:
		createLabel(author)
	createLabel("", 50)	
	
	createLabel("Assets used:", 30)
	for asset in assets:
		createLabel(asset)
	createLabel("", 50)	
	
	createLabel("Music:", 30)
	for m in music:
		createLabel(m)
	createLabel("", 50)	
	
	createLabel("SFX:", 30)
	for sfx in sfxs:
		createLabel(sfx)
	createLabel("", 50)
		
func createLabel(text: String, fontSize: int = 20) -> void:
	var label = Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", fontSize)
	label.add_theme_color_override("font_color", Color("eff5ef"))
	v_box_container.add_child(label)

func _process(delta: float) -> void:
	scroll_container.get_v_scroll_bar().value += 1
	
	if Input.is_action_just_pressed("Back"):
		Global.game_manager.change_gui_scene("title_screen")

func _on_back_pressed() -> void:
	Global.game_manager.change_gui_scene("title_screen")
