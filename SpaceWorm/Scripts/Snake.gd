extends Node2D

var MenuScene = preload("res://Scenes/Buttons/TitleScreen.tscn")
var direction = Vector2(2,0)
const gap = -20
#var next_tail_dir = Vector2(1,0)
var prev_dir = Vector2(1,0)

onready var tail = preload("res://Scenes/Tail.tscn")

var look_direction = Vector2(1, 0)

func _process(delta):
	if(Input.is_action_pressed("ui_up")):
		direction = Vector2(0,-2)

	elif(Input.is_action_pressed("ui_down")):
		direction = Vector2(0,2)
		#$head/Sprite.flip_v=true
	elif(Input.is_action_pressed("ui_left")):
		direction = Vector2(-2,0)
		#$head/Sprite.flip_h=true
	elif(Input.is_action_pressed("ui_right")):
		direction = Vector2(2,0)
		#$head/Sprite.flip_h= false
	move_snake()


func move_snake():
	var dir_change = false
	if(prev_dir != direction):
		prev_dir = direction
		dir_change = true
		
	if ( get_node_or_null("head" ) != null ):
		var head_pos = get_node("head").position
		get_node("head").position += direction
	
		if(dir_change):
			for i in range(1,get_child_count()):
				get_child(i).add_to_tail(head_pos, direction)

func add_tail():
	var inst = tail.instance()
	var prev_tail = get_child(get_child_count() -1 )
	if(prev_tail.name != "head"):
		inst.cur_dir = prev_tail.cur_dir
		for i in range(0,prev_tail.pos_array.size()):
			inst.pos_array.append(prev_tail.pos_array[i])
			inst.directions.append(prev_tail.directions[i])
		inst.position = prev_tail.position + prev_tail.cur_dir * gap
	else:
		inst.cur_dir = direction
		inst.position = prev_tail.position + direction * -30
	print("nr of children: ", get_child_count())
	add_child_below_node(  prev_tail, inst)
	
func remove_tail():
	print("nr of children: ", get_child_count())
	if ( get_child_count() > 1 ):
		var tail = get_child(get_child_count()-1 )
		tail.queue_free()
	else:
		die_and_stop_game()
		
func die_and_stop_game():
	print ("died")
	get_tree().change_scene_to(MenuScene)
	if (get_node_or_null("Game") != null ):
		print ("died root ", get_node("Game").name, "   ", get_node("Game").get_child(1).name)
	#get_node("Game").queue_free()
	#get_tree().change_scene_to(MenuScene)
