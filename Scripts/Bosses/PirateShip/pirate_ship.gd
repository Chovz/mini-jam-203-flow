extends StaticBody2D

class_name Boss

signal healthChanged

@onready var cannons: Node2D = $Cannons

const STARTING_HEALTH = 10000

var currentHealth = STARTING_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
