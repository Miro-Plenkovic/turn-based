extends TextureRect

var turn_order_dict = []

func _process(delta: float) -> void:
	var heroes = MainGlobal.get_hero_list()
	var enemies = MainGlobal.get_enemy_list()
	var awe := false
	for u in heroes + enemies:
		if turn_order_dict.find_custom(func(a): return a["name"] == u.character.name) == -1:
			turn_order_dict.append({"name": u.character.name, "node": u, "speed": 0, "limit": 1000})
	if (not MainGlobal.get_pause_flag()):
		for unit in turn_order_dict:
			unit["limit"] = 1000
			if "awe" in unit["node"].character:
				if unit["node"].character.awe >= 100:
					awe = true
		for unit in turn_order_dict:
			if (not unit["name"] in (heroes + enemies).map(func(u): return u.character.name)):
				turn_order_dict.erase(unit)
				
			unit["node"].get_child(1).get_child(2).value = (unit["node"].character.currentHealth/unit["node"].character.health) * 100
			unit["node"].get_child(1).get_child(0).text = "HP: " + str(int(unit["node"].character.currentHealth))
			for status in unit["node"].character.statusConditions.keys():
				status_effect_check(unit["node"], status, delta)
			if awe == false or ("awe" in unit["node"].character and unit["node"].character.awe >= 100):
					unit["speed"] += round(unit["node"].character.get_effective_speed() * delta * 100) / 100
		turn_order_dict.sort_custom(func(a,b): return (1000 - a["speed"]) / a["node"].character.speed < (1000 - b["speed"]) / b["node"].character.speed)
		for i in range(1, 9):
			var next_unit = turn_order_dict.reduce(func(min, unit): return unit if abs((round((unit["limit"] - unit["speed"]) / unit["node"].character.speed * 100)/100)) < abs((round((min["limit"] - min["speed"]) / min["node"].character.speed * 100) / 100)) or unit == MainGlobal.active_char else min)
			next_unit["limit"] += 1000
			get_node("TurnOrder" + str(i)).texture = next_unit["node"].get_child(1).get_child(1).texture
	if turn_order_dict.size() > 0:
		if turn_order_dict[0]["speed"] > 1000 and MainGlobal.active_char != turn_order_dict[0]["node"]:
				if "awe" in turn_order_dict[0]["node"].character and turn_order_dict[0]["node"].character.awe >= 100:
					turn_order_dict[0]["node"].character.awe -= 100
				if turn_order_dict[0]["node"] in heroes:
					MainGlobal.pause()
					$"../ActionBox".draw(turn_order_dict[0]["node"])
				else:
					turn_order_dict[0]["node"].execute("basic_attack", heroes.pick_random())
	if MainGlobal.active_char != null and (MainGlobal.target_character != null or MainGlobal.target_node != null):
		execute_action()
	if MainGlobal.active_char != null and (MainGlobal.action == "defend" or MainGlobal.action == "switch" or MainGlobal.action == "fireworks" or MainGlobal.action == "cheer" or MainGlobal.action == "amp_up"):
		execute_action()
		
func execute_action():
	MainGlobal.active_char.execute(MainGlobal.action, MainGlobal.target_node)
	MainGlobal.active_char.modulate.a = 150.0/255
	MainGlobal.active_char = null
	MainGlobal.action = ""
	MainGlobal.target_node = null
	MainGlobal.target_character = null
	$"../ActionBox".visible = false
	MainGlobal.restart()

func status_effect_check(node: Node, status: String, delta: float):
	if node.character.statusConditions.has(status) and node.character.statusConditions[status] > 0:
		if status == "poison":
			node.character.health -= delta/5
		node.character.statusConditions[status] -= delta
		if node.character.statusConditions[status] <= 0:
			node.character.statusConditions.erase(status)

func reset_turn(unit: Node, amount: int):
	var index = turn_order_dict.find_custom(func(a): return a["node"].name == unit.name)
	if index != -1:
		turn_order_dict[index]["speed"] -= amount
		
func remove_from_turn_order(unit: Node):
	get_node("TurnOrder" + str(turn_order_dict.size())).visible = false
	turn_order_dict.remove_at(turn_order_dict.find_custom(func(a): return a["node"].name == unit.name))
