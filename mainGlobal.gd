extends Node

var unit_list: Array[Unit] = []
var enemies: Array[Unit] = [Unit.new(150., 75, 3, "Frog", false), Unit.new(200., 75, 2, "Frog2", false)]

var hero_list: Array[Node]
var enemy_list: Array[Node]

var pause_flag: bool

var active_char : Node
var target_node: Node
var target_character: Unit
var target_list: Array[Node]
var action: String

func pause():
	pause_flag = true
	
func restart():
	pause_flag = false
	
func get_pause_flag() -> bool:
	return pause_flag
		
func get_unit_list()-> Array[Unit]:
	return unit_list
	
func get_hero_list()-> Array[Node]:
	return hero_list
	
func get_enemy_list()-> Array[Node]:
	return enemy_list
	
func add_to_list(n: Node, hero: bool):
	
	if hero:
		unit_list[unit_list.find_custom(func (u): return n.character.name == u.name)].active = true
		hero_list.append(n)
	else:
		enemies[enemies.find_custom(func (u): return n.character.name == u.name)].active = true
		enemy_list.append(n)
	
func remove_from_lists(n: Node, hero: bool):
	if hero:
		unit_list[unit_list.find_custom(func (u): return n.character.name == u.name)].active = false
		hero_list.erase(n)
	else:
		enemies[enemies.find_custom(func (u): return n.character.name == u.name)].active = false
		enemy_list.erase(n)
	
func set_targets(nodes: Array[Node]):
	target_list = nodes
	for e in target_list:
		e.modulate = Color8(155, 255, 100, 255) 
		
func reset_targets():
	for e in target_list:
		e.modulate = Color8(255, 255, 255, 255) 
