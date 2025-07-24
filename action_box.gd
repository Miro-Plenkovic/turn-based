extends TextureRect

var pagination:int
var current_page:int

func draw(node: Node):
	MainGlobal.active_char = node
	$Label.text = MainGlobal.active_char.character.name + "'s turn"
	MainGlobal.active_char.modulate.a = 255.0 / 150
	var combinedMoveList = MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"]
	pagination =  ceil(combinedMoveList.size() / 2.) - 1
	current_page = 1
	set_up_slots(combinedMoveList)
	print(combinedMoveList)
	$UpArrow.disabled = true
	if current_page == pagination:
		$DownArrow.disabled = true
	self.visible = true
	#separate some of this into a function to be called on up arrow /down arrow pressed, and add the functionality of going up/down the moves list, add inputs to allow that via arrows too

func set_up_slots(moves:Array):
	$Slot1.visible = true
	$Slot1.text = moves[(current_page - 1) * 2]["name"]
	$Slot1.disabled = moves[(current_page - 1) * 2]["cost"] > 0 and moves[(current_page - 1) * 2]["cost"] > MainGlobal.active_char.character.action_points
	if moves.size() > (current_page - 1) * 2 + 1:
		$Slot2.visible = true
		$Slot2.text = moves[(current_page - 1) * 2 + 1]["name"]
		$Slot2.disabled = moves[(current_page - 1) * 2 + 1]["cost"] > 0 and moves[(current_page - 1) * 2 + 1]["cost"] > MainGlobal.active_char.character.action_points
	if moves.size() > (current_page - 1) * 2 + 2: 
		$Slot3.visible = true
		$Slot3.text = moves[(current_page - 1) * 2 + 2]["name"]
		$Slot3.disabled = moves[(current_page - 1) * 2 + 2]["cost"] > 0 and moves[(current_page - 1) * 2 + 2]["cost"] > MainGlobal.active_char.character.action_points
	if moves.size() > (current_page - 1) * 2 + 3:
		$Slot4.visible = true
		$Slot4.text = moves[(current_page - 1) * 2 + 3]["name"]
		$Slot4.disabled = moves[(current_page - 1) * 2 + 3]["cost"] > 0 and moves[(current_page - 1) * 2 + 3]["cost"] > MainGlobal.active_char.character.action_points
	else:
		$Slot4.visible = false

func _on_up_arrow_pressed() -> void:
	current_page -= 1
	$UpArrow.disabled = current_page == 1
	$DownArrow.disabled = current_page == pagination
	set_up_slots(MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])
	


func _on_down_arrow_pressed() -> void:
	current_page += 1
	$UpArrow.disabled = current_page == 1
	$DownArrow.disabled = current_page == pagination
	set_up_slots(MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])


func _on_slot_1_pressed() -> void:
	MainGlobal.active_char.prepare_for_targetting((MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2]["name"], (MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2]["targets"])


func _on_slot_2_pressed() -> void:
	MainGlobal.active_char.prepare_for_targetting((MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2 + 1]["name"], (MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2 + 1]["targets"])



func _on_slot_3_pressed() -> void:
	MainGlobal.active_char.prepare_for_targetting((MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2 + 2]["name"], (MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2 + 2]["targets"])



func _on_slot_4_pressed() -> void:
	MainGlobal.active_char.prepare_for_targetting((MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2 + 3]["name"], (MainGlobal.active_char.character.moves["base"] + MainGlobal.active_char.character.moves["skill"])[(current_page - 1) * 2 + 3]["targets"])


func _on_switch_pressed() -> void:
	MainGlobal.active_char.prepare_for_targetting("switch", 5)
