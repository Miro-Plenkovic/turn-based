extends Unit

class_name Healer

func _init(init_name: String):
	super(500, 100, 5, init_name, true, false)
	self.className = "Healer"
	self.moves["skill"] = [{"name": "heal", "cost": 2, "targets": 3}, {"name": "cure", "cost": 2, "targets": 3}, {"name": "blind", "cost": 2, "targets": 1}]
	
func heal(targets: int):
	prepare_for_targetting("heal", targets)
	
func heal_ally(n: Node):
	self.defending = false
	self.action_points -= 2
	n.character.currentHealth += 25
	if n.character.currentHealth > n.character.health:
		n.character.currentHealth = n.character.health
	
func cure_ally(n: Node):
	self.defending = false
	self.action_points -= 2
	n.character.statusCondition = {}
	
func blind_enemy(n: Node):
	self.defending = false
	self.action_points -= 2
	n.character.statusCondition["blind"] = 20
