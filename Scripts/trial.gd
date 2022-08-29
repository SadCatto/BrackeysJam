extends Node2D

export (int)var enemies

func _process(delta):
	if(enemies != 0):
		$portal.monitoring = false
	if(Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()


func enemyDead():
	enemies -= 1
	if(enemies==0):	
		$door.play()
		$portal.monitoring = true

func _on_portal_body_entered(body):
	pass
