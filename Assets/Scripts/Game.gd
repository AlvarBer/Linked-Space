extends Node

var number_of_chests
var opened_chests = 0

func _ready():
	var chests = get_tree().get_nodes_in_group("chests")
	self.number_of_chests = len(chests)
	for chest in chests:
		chest.connect("chest_opened", self, "add_opened")

func add_opened():
	self.opened_chests += 1
	if self.opened_chests == self.number_of_chests:
		$Credits.visible = true