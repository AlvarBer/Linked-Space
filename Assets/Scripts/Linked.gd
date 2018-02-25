extends Node


export(String) var group

func _enter_tree():
	if self.group:
		self.add_to_group(self.group)

func _ready():
	self.set_process(false)

func _process(delta):
	self.on_continued_act(false)

func on_act(active, player):
	pass

func on_continued_act(active):
	pass

func can_stop_act(active, player):
	pass

func on_stop_act(active, player):
	pass
