extends Node

var opened_chests = 0

func _ready():
	pass

func add_opened():
	self.opened_chests += 1
	if opened_chests == 2:
		$Control/Credits.visible = true