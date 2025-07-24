extends Node2D

@export var index:int
@export var hero: bool

func _ready() -> void:
	if hero:
		character = MainGlobal.unit_list[index]
	else:
		character = MainGlobal.enemies[index]
	get_child(1).get_child(1).texture = load("res://Icons/" + character.name + ".png")
	MainGlobal.add_to_list(self, hero)

var character: Unit
var defending: bool

func prepare_for_targetting(action: String, targets: int):
	character.prepare_for_targetting(action, targets)
	
func attack_enemy(n: Node, dmg_multiplier: float, delay: int, action_point_delta):
	character.attack_enemy(n, dmg_multiplier, action_point_delta)
	$"../TurnOrder".reset_turn(self, delay)

func reckless_attack_enemy(n: Node):
	character.reckless_attack_enemy(n)
	$"../TurnOrder".reset_turn(self, 500)
	
func distract_enemy(n):
	character.distract_enemy()
	$"../TurnOrder".reset_turn(self, 1000)
	$"../TurnOrder".reset_turn(n, 700)
	
func defend_self():
	character.defend_self()
	$"../TurnOrder".reset_turn(self, 200)
	
func cheer_allies():
	character.cheer_allies()
	$"../TurnOrder".reset_turn(self, 1000)
	
func amp_up_allies():
	character.amp_up_allies()
	$"../TurnOrder".reset_turn(self, 1000)
	
func slow_enemy(n: Node):
	character.slow_enemy(n)
	$"../TurnOrder".reset_turn(self, 2000)
	
func poison_enemy(n: Node):
	character.poison_enemy(n)
	$"../TurnOrder".reset_turn(self, 1000)
	
func heal_ally(n: Node):
	character.heal_ally(n)
	$"../TurnOrder".reset_turn(self, 1000)
	
func cure_ally(n: Node):
	character.cure_ally(n)
	$"../TurnOrder".reset_turn(self, 1000)
	
func blind_enemy(n: Node):
	character.blind_enemy(n)
	$"../TurnOrder".reset_turn(self, 1000)
	
func card_trick_enemy(n: Node):
	character.card_trick_enemy(n)
	$"../TurnOrder".reset_turn(self, 650)
	
func fireworks_all_enemies():
	character.fireworks_all_enemies()
	$"../TurnOrder".reset_turn(self, 1000)

func _on_turn_order_ready() -> void:
	self.get_child(1).get_child(0).text = "HP: " + str(int(self.character.health))


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if self.character.statusConditions.has("slow"):
		print(self.character.statusConditions["slow"])
	if event is InputEventMouseButton and event.button_index == 1 and  event.is_pressed():
		if self.modulate == Color8(155, 255, 100, 255):
			MainGlobal.target_node = self
			MainGlobal.reset_targets()

func execute(action: String, node: Node2D):
	match action:
		"basic_attack":
			attack_enemy(node, 1, 1000, 1)
		"quick_attack":
			attack_enemy(node, 0.5, 750, 1)
		"heavy_attack":
			attack_enemy(node, 1.5, 2000, 1)
		"reckless_attack":
			reckless_attack_enemy(node)
		"slow":
			slow_enemy(node)
		"poison":
			poison_enemy(node)
		"cure":
			cure_ally(node)
		"heal":
			heal_ally(node)
		"blind":
			blind_enemy(node)
		"cheer":
			cheer_allies()
		"amp_up":
			amp_up_allies()
		"card_trick":
			card_trick_enemy(node)
		"fireworks":
			fireworks_all_enemies()
		"distract":
			distract_enemy(node)
		"defend":
			defend_self()
		"ultimate":
				attack_enemy(node, 4, 500, -5)
		"switch":
				switch_to_ally()
		_:
			print("huh?")
	if node != null:
		if node.character.health <= 0:
			node.visible = false
			MainGlobal.remove_from_lists(node, node.character.hero)
			$"../TurnOrder".remove_from_turn_order(node)
	
func switch_to_ally():
	var new_character := MainGlobal.unit_list[MainGlobal.unit_list.find_custom(func (node): return node.active == false)]
	MainGlobal.remove_from_lists(self, self.character.hero)
	character = new_character
	self.get_child(1).get_child(1).texture = load("res://Icons/" + character.name + ".png")
	print(character.name)
	MainGlobal.add_to_list(self, self.character.hero)
	MainGlobal.restart()
