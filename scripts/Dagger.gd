extends Area2D

export var speed = 800.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta 


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _on_dagger_body_entered(body):
	if body.is_in_group('player') or body.is_in_group('tiles'):
		queue_free()


func _on_dagger_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
