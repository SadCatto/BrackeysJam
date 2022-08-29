extends KinematicBody2D
var health = 100

onready var timer = $DamageTimer
var Player = null
var velocity = Vector2.ZERO
var speed = 250

func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
	if Player:
		velocity = position.direction_to(Player.position) * speed
	velocity = move_and_slide(velocity)


func take_damage(damage):
	if timer.is_stopped():
		health = health - damage
	timer.start()


func _on_PlayerDetectopn_body_entered(body):
	if body.is_in_group("player"):
		Player = body



func _on_bulletDetection_area_entered(area):
	if area.is_in_group("bullet"):
		get_parent().enemyDead()
		queue_free()
