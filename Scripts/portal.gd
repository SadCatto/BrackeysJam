extends Node2D

export(PackedScene) var nextScene

func _on_portal_body_entered(body):
	if body.is_in_group('player'):
		get_tree().change_scene_to(nextScene)
