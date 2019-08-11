extends Node2D

onready var factoryInstance = preload("res://Scenes/Factory.tscn").instance()
onready var playerInstance = preload("res://Scenes/Player.tscn").instance()
onready var viewportSize = get_viewport_rect().size

func _ready():
	startSpawn()
	
	
		
func startSpawn():
	var headX = get_random_number((viewportSize.x as int)-50 ,100 )
	var headY = get_random_number((viewportSize.y as int)-50,50 )
	spawnSnake(headX, headY)
	
	
	var y = get_random_number(20, 7)
	for i in range (y):
		var coordinates = getCoordinatesOutsideOfSnake(headX, headY)
		createFruit(coordinates[0] ,coordinates[1])
	
func spawnSnake(headX, headY) -> void:
	playerInstance.position = Vector2(headX, headY)
	add_child(playerInstance)
	#addTail
	
func getCoordinatesOutsideOfSnake(headX, headY) :
	var newX = get_random_number((viewportSize.x as int)-30 ,30 )
	var newY = get_random_number((viewportSize.y as int)-30 ,30 )
	
	while ( !(newX < headX - 200 || newX > headX + 80 || newY < headY - 80 || newY > headY + 80) ):
		if (!(newX < (headX - 200) || newX > (headX + 80))):
			newX = get_random_number((viewportSize.x as int)-30 ,30 )
		else:
			newY = get_random_number((viewportSize.y as int)-30 ,30 )
		
	
	return [newX, newY]
	
func createFruit(fruitX ,fruitY):
	var fruitType = get_random_number(7, 0)
	var newFruit = factoryInstance.generate_element(fruitType)
	newFruit.position = Vector2(fruitX ,fruitY)
	factoryInstance.connect("object_overlap",self,"_on_Factory_object_overlap")
	add_child(newFruit)
	
func get_random_number(MAX, MIN):
	randomize()
	var num = randi()%(MAX) + MIN
	return num

func _on_Factory_object_overlap(objName):
	if objName=="fruit":
		var snakeCoorinates = playerInstance.position
		var coordinates = getCoordinatesOutsideOfSnake(snakeCoorinates.x, snakeCoorinates.y)
		createFruit(coordinates[0] ,coordinates[1])
