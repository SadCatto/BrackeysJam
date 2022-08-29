extends Node2D

export var startScene : PackedScene


func _on_MenuButton_button_up() -> void:
	get_tree().change_scene(startScene.resource_path)
