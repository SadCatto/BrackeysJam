extends KinematicBody2D
var speed = 150.0
var health = 100

onready var timer = $DamageTimer
func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
	

func take_damage(damage):
	if timer.is_stopped():
		health = health - damage
		print(health)
	timer.start()
