extends Node2D

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://character_select.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://options.tscn")

func _on_exit_game_pressed() -> void:
	get_tree().quit()
