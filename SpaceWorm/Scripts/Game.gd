extends Node2D

onready var factoryInstance = preload("res://Scenes/Factory.tscn").instance()
onready var viewportX = get_viewport_rect().size.x
onready var viewportY = get_viewport_rect().size.y

func _ready():
	startSpawn()
	pass
	
func spawn_next_fruit_and_tail():
	if ( has_node("snake" )):
		get_node("snake").add_tail()	
		
func startSpawn():
	var headX = utils.get_random_number(10 ,30 )
	var headY = utils.get_random_number(100, 150 )
	spawnSnake(headX, headY)
	var y = utils.get_random_number(20, 7)
	for i in range (y):
		var coordinates = getCoordinatesOutsideOfSnake(headX, headY)
		createFruit(coordinates[0] ,coordinates[1])
	
func spawnSnake(headX, headY) -> void:
	get_node("snake").position = Vector2(headX, headY)
	add_child(get_node("snake"))
	#addTail
	
func getCoordinatesOutsideOfSnake(headX, headY) :
	var newX = utils.get_random_number((viewportX as int)-30 ,30 )
	var newY = utils.get_random_number((viewportY as int)-30 ,30 )
	
	while ( !(newX < headX - 200 || newX > headX + 80 || newY < headY - 80 || newY > headY + 80) ):
		if (!(newX < (headX - 200) || newX > (headX + 80))):
			newX = utils.get_random_number((viewportX as int)-30 ,30 )
		else:
			newY = utils.get_random_number((viewportY as int)-30 ,30 )
		
	
	return [newX, newY]
	
func createFruit(fruitX ,fruitY):
	var fruitType = utils.get_random_number(7, 0)
	var newFruit = factoryInstance.generate_element(fruitType)
	newFruit.position = Vector2(fruitX ,fruitY)
	factoryInstance.connect("object_overlap",self,"_on_Factory_object_overlap")
	add_child(newFruit)
	


func _on_Factory_object_overlap(objName):
	if objName=="fruit":
		var snakeCoordinates = get_node("snake").position
		var coordinates = getCoordinatesOutsideOfSnake(snakeCoordinates.x, snakeCoordinates.y)
		createFruit(coordinates[0] ,coordinates[1])
