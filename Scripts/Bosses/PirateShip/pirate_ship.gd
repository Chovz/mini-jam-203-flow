extends StaticBody2D

class_name Boss

signal healthChanged

@onready var cannons: Node2D = $Cannons

const STARTING_HEALTH = 1000

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
