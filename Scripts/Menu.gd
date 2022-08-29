extends Node2D

export var  mainGameScene : PackedScene


func _on_New_Game_button_up() -> void:
	get_tree().change_scene(mainGameScene.resource_path)



func _on_Continue_button_up() -> void:
	pass # Replace with function body.



func _on_Exit_button_up() -> void:
	pass # Replace with function body.
