extends "res://Scripts/MyHitBox.gd"


export var speed = 300.0
onready var daggerWaitTime = $daggerWaitTimer

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)

	global_position += speed * direction * delta 

	
func destroy():
	queue_free()
	


func _on_Dagger_area_entered(area: Area2D) -> void:
	destroy()


func _on_Dagger_body_entered(body: Node) -> void:
	destroy()



func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


