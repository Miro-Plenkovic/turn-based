extends Node2D

@export var characterName: String

var character:Unit

signal character_selected(value:Node)

func _ready() -> void:
	$Character.texture = load("res://Icons/" + characterName + ".png")
	character = CharacterSelectGlobal.characterArray[CharacterSelectGlobal.characterArray.find_custom(func(c): return c.name == characterName)]

func _on_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and  event.is_pressed():
		character_selected.emit(self)
