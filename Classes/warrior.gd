extends Unit

class_name Warrior

func _init(init_name: String):
	super(100, 100, 5, init_name, true, false)
	self.className = "Warrior"
	self.moves["skill"] = [{"name": "heavy_attack", "cost": 0, "targets": 1}, {"name": "reckless_attack", "cost": 1, "targets": 1}]
	
func reckless_attack_enemy(n: Node):
	self.defending = false
	self.attack_enemy(n, 2, -1)
	self.health -= self.attack
