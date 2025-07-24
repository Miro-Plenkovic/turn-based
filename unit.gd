class_name Unit

var name: String
var attack: int
var health: float
var currentHealth: float
var speed: int
var hero: bool
var active:bool
var defending := false
var action_points := 0
var statusConditions:Dictionary = {}
var className:String
var moves: Dictionary = {"base": [{"name": "basic_attack", "cost": 0, "targets": 1}, {"name": "defend", "cost": 0, "targets": 0}], "special": [{"name": "switch", "cost": 0, "targets": 5}, {"name": "ultimate", "cost": 5, "targets": 1}], "skill": []}

func _init(init_speed: int, init_health: int, init_attack: int, init_name: String, init_hero: bool, init_active: bool = false):
	self.name = init_name
	self.attack = init_attack
	self.health = init_health
	self.currentHealth = init_health
	self.speed = init_speed
	self.hero = init_hero
	self.active = init_active
	
func get_effective_speed():
	var modifier := 1
	if self.statusConditions.has("slow") and self.statusConditions["slow"] > 0:
		modifier *= 0.5
	if self.statusConditions.has("amped") and self.statusConditions["amped"] > 0:
		modifier *= 1.5
	return self.speed*modifier
	
func attack_enemy(n: Node, dmg_multiplier: float, action_point_delta: int):
	var modifier = 1
	self.defending = false
	self.action_points += action_point_delta
	if n != null:
		if n.character.defending:
			modifier *= 0.5
		if self.statusConditions.has("cheer") and self.statusConditions["cheer"] > 0:
			modifier *= 1.5
		n.character.currentHealth -= self.attack * dmg_multiplier * modifier
	
func defend_self():
	self.defending = true
	
func prepare_for_targetting(action: String, targets: int):
	MainGlobal.action = action
	if MainGlobal.active_char:
		match targets:
			0:
				MainGlobal.set_targets([])
			1: 
				MainGlobal.set_targets(MainGlobal.get_enemy_list())
			2: 
				MainGlobal.set_targets([])
			3: 
				MainGlobal.set_targets(MainGlobal.get_hero_list())
			4: 
				MainGlobal.set_targets([])
			5: 
				MainGlobal.set_targets([])
			_: 
				print("huh?")
