extends Node2D

export var startScene : PackedScene


func _on_exit_button_down():
	get_tree().quit()


func _on_retry_button_down():
	get_tree().change_scene(startScene.resource_path)
