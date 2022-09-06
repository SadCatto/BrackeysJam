extends Node2D

func _on_portal_body_entered(body):
	if body.is_in_group('player'):
		print("player entered")
		get_tree().call_group("levelChange", "levelChange")
