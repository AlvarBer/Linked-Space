extends Node


export(String) var group

func _enter_tree():
	if self.group:
		self.add_to_group(self.group)

func _ready():
	pass

func can_act():
	return True

func on_act(active, player):
	pass

func on_continued_act(active):
	pass

func can_stop_act(active, player):
	return True

func on_stop_act(active, player):
	pass
