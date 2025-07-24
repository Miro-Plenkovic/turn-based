extends Unit

class_name Rogue

func _init(init_name: String):
	super(100, 100, 5, init_name, true, false)
	self.className = "Rogue"
	self.moves["skill"] = [{"name": "quick_attack", "cost": 0, "targets": 1}, {"name": "distract", "cost": 1, "targets": 1}]
	
func distract_enemy():
	self.action_points -= 1
	self.defending = false
