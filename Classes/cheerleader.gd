extends Unit

class_name Cheerleader

func _init(init_name: String):
	super(100, 100, 5, init_name, true, false)
	self.className = "Cheerleader"
	self.moves["skill"] = [{"name": "cheer", "cost": 2, "targets": 4}, {"name": "amp_up", "cost": 2, "targets": 4}]
	
func cheer_allies():
	self.defending = false
	self.action_points -= 2
	for n in MainGlobal.get_hero_list():
		n.character.statusConditions["cheer"] = 40
	
func amp_up_allies():
	self.defending = false
	self.action_points -= 2
	for n in MainGlobal.get_hero_list():
		n.character.statusConditions["amped"] = 40
