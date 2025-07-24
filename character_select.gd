extends Node2D

func _ready() -> void:
	for i in range(1, 10):
		get_node("Background/CharacterSelect/Character" + str(i)).character_selected.connect(on_character_selected)

func on_character_selected(value: Node):
	if MainGlobal.unit_list.size() <= 4 and value.character not in MainGlobal.unit_list:
		MainGlobal.unit_list.append(value.character) 
	for i in range(1, 5):
		if MainGlobal.unit_list.size() >= i:
			get_node("Background/Party/PartyMember" + str(i)).texture = load("res://Icons/" + MainGlobal.unit_list[i-1].name + ".png")
	if MainGlobal.unit_list.size() == 4:
		$Background/Button.disabled = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://combat.tscn")
