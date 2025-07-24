extends Unit

class_name Showman

var awe := 0

func _init(init_name: String):
	super(100, 100, 5, init_name, true, false)
	self.className = "Showman"
	self.moves["skill"] = [{"name": "card_trick", "cost": 0, "targets": 1}, {"name": "fireworks", "cost": 2, "targets": 2}, ]
	
func card_trick_enemy(n: Node):
	self.defending = false
	self.action_points += 1
	self.awe += 25
	n.character.currentHealth -= self.attack
	
func fireworks_all_enemies():
	self.defending = false
	self.action_points -= 2
	self.awe += 50
	for n in MainGlobal.get_enemy_list():
		n.character.currentHealth -= self.attack
