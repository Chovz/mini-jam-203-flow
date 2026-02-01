extends StaticBody2D

class_name Boss

signal healthChanged

enum Attack {
	CANNONS,
	MINIONS
}

@onready var cannons: Node2D = $Cannons
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var change_attacks: Timer = $ChangeAttacks
const UFO = preload("res://Scenes/Bosses/PirateShip/ufo.tscn")

const CHANGE_TIME_MIN = 10
const CHANGE_TIME_MAX = 15
const MINIONS_MIN = 4
const MINIONS_MAX = 7
const STARTING_HEALTH = 10000

var currentHealth = STARTING_HEALTH
var currentAttack = Attack.CANNONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("opening")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	checkHealth()

func take_damage(damage: int) -> void:
	currentHealth -= damage
	healthChanged.emit()

func checkHealth() -> void:
	if(currentHealth <= 0):
		print("YOU SUNK MY BATTLESHIP!")
		queue_free()

func _on_hitable_area_area_entered(area: Area2D) -> void:
	print("Area entered" )
	if area.is_in_group("Player_Bullets"):
		var bullet_damage = 20
		take_damage(bullet_damage)
		area.queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	print("Finished playing " + animated_sprite_2d.animation)
	if animated_sprite_2d.animation == "closing":
		animated_sprite_2d.play("closed")
	elif animated_sprite_2d.animation == "opening":
		sendMinions()
		
func setTimerRandomTime() -> void:
	change_attacks.start(randf_range(CHANGE_TIME_MIN, CHANGE_TIME_MAX))

func _on_change_attacks_timeout() -> void:
	if currentAttack == Attack.CANNONS:
		prepareCannons()

func prepareCannons() -> void:
	cannons.visible = true
	var cannonArray: Array = cannons.get_children()
	for cannon in cannonArray:
		cannon.prepareFire()
	animated_sprite_2d.play("opened")

func sendMinions() -> void:
	var cannonArray: Array = cannons.get_children()
	for cannon in cannonArray:
		cannon.hide()
	cannons.visible = true
	animated_sprite_2d.play("closing")
	
	for i in randi_range(MINIONS_MIN, MINIONS_MAX):
		var minion = UFO.instantiate()
		minion.position.x += 200
		add_child(minion)
