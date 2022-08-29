extends KinematicBody2D

export var speed = 350.0

var velocity = Vector2.ZERO

onready var timer = $takeDamage
var health = 100.0

func _ready() -> void:
	$bg.play()

func _physics_process(delta: float) -> void:
	var horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	var vertical_direction = (
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	velocity.x =  horizontal_direction * speed
	velocity.y = vertical_direction * speed
	velocity = move_and_slide(velocity)
	
	if(velocity.x<0):
		$playerSprite.flip_h = true
	else:
		$playerSprite.flip_h = false
	
	if(velocity!=Vector2(0,0)):
		$AnimationPlayer.play("run")
	elif (velocity ==Vector2.ZERO):
		$AnimationPlayer.play("idle")
	
	if health <= 0:
		queue_free()
		get_tree().change_scene("res://Scenes/end.tscn")
		
		
func take_damage(damage):
	if timer.is_stopped():
		$hurt.play()
		health = health - damage
	timer.start()

