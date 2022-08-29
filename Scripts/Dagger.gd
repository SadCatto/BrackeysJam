extends Area2D

export var speed = 800.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta 

func destroy():
	queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Area2D_area_entered(area):
	queue_free()
