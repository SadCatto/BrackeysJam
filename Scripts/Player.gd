extends KinematicBody2D

export var speed = 400.0

var velocity = Vector2.ZERO

onready var timer = $takeDamage

var health = 100.0

func _physics_process(delta: float) -> void:
	var horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	var vertical_direction = (
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	velocity.x =  horizontal_direction * speed
	velocity.y = vertical_direction * speed
	velocity = move_and_slide(velocity)
	
	if health <= 0:
		print("Player Died")
		
func take_damage(damage):
	if timer.is_stopped():
		health = health - damage
		print(health)
	timer.start()

