extends Unit

class_name Warlock

func _init(init_name: String):
	super(100, 100, 5, init_name, true, false)
	self.className = "Warlock"
	self.moves["skill"] = [{"name": "slow", "cost": 2, "targets": 1}, {"name": "poison", "cost": 3, "targets": 1}]

func slow_enemy(n: Node):
	self.defending = false
	self.action_points -= 2
	n.character.statusConditions["slow"] = 50
	
func poison_enemy(n: Node):
	self.defending = false
	self.action_points -= 3
	n.character.statusConditions["poison"] = 50
