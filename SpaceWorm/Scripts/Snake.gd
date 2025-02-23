extends Node2D

const kMenuScene = preload("res://Scenes/Buttons/TitleScreen.tscn")
var kTailScene = preload("res://Scenes/Tail.tscn")
var direction = Vector2(2,0)

const gap = -20
var prev_dir = Vector2(1,0)

var look_direction = Vector2(1, 0)
	
func _process(delta):
	if(Input.is_action_pressed("ui_up")):
		direction = Vector2(0,-2)
	elif(Input.is_action_pressed("ui_down")):
		direction = Vector2(0,2)
	elif(Input.is_action_pressed("ui_left")):
		direction = Vector2(-2,0)
	elif(Input.is_action_pressed("ui_right")):
		direction = Vector2(2,0)
	moveSnake()

func moveSnake():
	var aIsDirChange = false
	if(prev_dir != direction):
		prev_dir = direction
		aIsDirChange = true
		
	if ( get_node_or_null("head" ) != null ):
		var head_pos = get_node("head").position
		get_node("head").position += direction

		if(aIsDirChange):
			for i in range(1,get_child_count()):
				get_child(i).add_to_tail(head_pos, direction)

func addTail():
	var tailInstance = kTailScene.instance()
	var prev_tail = get_child(get_child_count() -1 )
	if(prev_tail.name != "head"):
		tailInstance.cur_dir = prev_tail.cur_dir
		for i in range(0,prev_tail.pos_array.size()):
			tailInstance.pos_array.append(prev_tail.pos_array[i])
			tailInstance.directions.append(prev_tail.directions[i])
		tailInstance.position = prev_tail.position + prev_tail.cur_dir * gap
	else:
		tailInstance.cur_dir = direction
		tailInstance.position = prev_tail.position + direction * -30
		print("nr of children: ", get_child_count())
	add_child_below_node(  prev_tail, tailInstance)
	

func addFirstTail(iHeadCoordinates):
	var tailInstance = kTailScene.instance()
	tailInstance.cur_dir = direction
	print("addFirstTail")
	tailInstance.position.x = iHeadCoordinates[0] - 30
	tailInstance.position.y =iHeadCoordinates[1]
	add_child_below_node(get_node("head"), tailInstance)
	
func removeTail():
	print("reducing nr of children: ", get_child_count())
	if ( get_child_count() > 1 ):
		var tail = get_child(get_child_count()-1 )
		tail.queue_free()
	else:
		dieStopGame()
		
func dieStopGame():
	print ("died")
	get_tree().change_scene_to(kMenuScene)
