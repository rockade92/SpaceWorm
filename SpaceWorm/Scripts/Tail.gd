extends Area2D

var directions = []
var pos_array = []
var cur_dir = Vector2()

func _process(delta):
	if(directions.size() > 0):
		if(position == pos_array[0]):
			cur_dir = directions[0]
			remove_from_tail()
	position += cur_dir

func remove_from_tail():
	directions.pop_front()
	pos_array.pop_front()

func add_to_tail(head_pos, dir):
	pos_array.append(head_pos)
	directions.append(dir)
	pass

