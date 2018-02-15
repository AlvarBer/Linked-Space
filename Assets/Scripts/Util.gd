extends Node


static func reparent(node, new_parent):
	""" Changes the parent of node to new_parent """
	node.get_parent().remove_child(node)
	new_parent.add_child(node)

static func pos_relative_to(node, grandparent):
	return node.get_relative_transform_to_parent(grandparent).origin

static func act(mirror, player):
	""" Given an actable object that has a linked actable object executes on_act
	on both, setting the active/passive properties properly
	"""
	mirror.on_act(true, player)
	mirror.linked.on_act(false, player)

static func can_stop_act(mirror, player):
	return (
		mirror.can_stop_act(true, player) and
		mirror.linked.can_stop_act(false, player)
	)

static func stop_act(mirror, player):
	mirror.on_stop_act(true, player)
	mirror.linked.on_stop_act(false, player)
