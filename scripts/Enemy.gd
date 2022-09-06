extends KinematicBody2D


onready var timer = $DamageTimer
onready var alert = $PlayerDetectopn
var Player = null
var velocity = Vector2.ZERO
var speed = 250
var dir = Vector2.ZERO


var knockback = Vector2.ZERO

func _physics_process(delta: float) -> void:

	if Player:
		check_scent()
		velocity = dir * speed
	velocity = move_and_slide(velocity+knockback)
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	"""lerp sometimes sets velocity to infinity so to clip it back to zero
	we check if it is close to zero, if it is we set it to zero"""
	if(is_zero_approx(velocity.x) && is_zero_approx(velocity.y)):
		velocity = Vector2.ZERO

func check_scent():
	var look = get_node("RayCast2D")
	look.cast_to = Player.position - position
	look.force_raycast_update()
	
	if !look.is_colliding():
		dir = look.cast_to.normalized()
	else:
#		if Player.scent_trail.empty():
#			$ColorRect.modulate = Color(0, 1, 0, 1)
#		else:
#			$ColorRect.modulate = Color(1, 0, 0, 1)
		for scent in Player.scent_trail:
			look.cast_to = scent.position - position
			look.force_raycast_update()
			
			if !look.is_colliding():
				dir = look.cast_to.normalized()

func knockBack(enemypos: Vector2):
	var diff = enemypos.direction_to(self.global_position)
	knockback = diff.normalized() * 2000
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()


func _on_PlayerDetectopn_body_entered(body):
	if body.is_in_group("player"):
		Player = body

func _on_bulletDetection_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		knockBack(area.position)

