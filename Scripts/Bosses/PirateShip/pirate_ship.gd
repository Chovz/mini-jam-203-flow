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
const CHANGE_TIME_MAX = 20
const MINIONS_MIN = 5
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
	
	if currentAttack == Attack.MINIONS:
		checkForUfos()
	
func checkForUfos() -> void:
	var ufos: Array = get_children()
	for ufo in ufos:
		if ufo.is_in_group("Enemies"):
			return
			
	animated_sprite_2d.play("opening")
	currentAttack = Attack.CANNONS

func take_damage(damage: int) -> void:
	if currentAttack == Attack.MINIONS:
		return
	
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
	if animated_sprite_2d.animation == "closing":
		sendMinions()
		animated_sprite_2d.play("closed")
	elif animated_sprite_2d.animation == "opening":
		prepareCannons()
		animated_sprite_2d.play("opened")
		
func setTimerRandomTime() -> void:
	change_attacks.start(randf_range(CHANGE_TIME_MIN, CHANGE_TIME_MAX))

func _on_change_attacks_timeout() -> void:
	if currentAttack == Attack.CANNONS:
		var cannonArray: Array = cannons.get_children()
		for cannon in cannonArray:
			if cannon.is_in_group("Cannon"):
				cannon.holdFire()
		animated_sprite_2d.play("closing")

func prepareCannons() -> void:
	cannons.visible = true
	var cannonArray: Array = cannons.get_children()
	for cannon in cannonArray:
		cannon.prepareFire()
	animated_sprite_2d.play("opened")
	setTimerRandomTime()

func sendMinions() -> void:
	cannons.visible = false
	for i in randi_range(MINIONS_MIN, MINIONS_MAX):
		var minion = UFO.instantiate()
		minion.position.x += 500
		add_child(minion)
	
	currentAttack = Attack.MINIONS
