extends Node2D

onready var factoryInstance = preload("res://Scenes/Factory.tscn").instance()
onready var factoryEnemyInstance = preload("res://Scenes/Enemy.tscn").instance()
	
var _score = 0

func _ready():
	startSpawn()
	set_process(true)
	
func _process(delta):
	var LabelNode = get_node("Score counter/UI/Control/RichTextLabel")
	LabelNode.text = str(_score)
		
func fruit_eaten():
	print ("fruit eaten")
	_score += 10
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".addTail()	
			
func startSpawn():		
	var aHeadCoordinates = utils.getRandomCoordinates()
	spawnSnake(aHeadCoordinates)
	var aNbOfFruits = utils.getRandomNumber(25, 35)
	print ("nb fruits ",aNbOfFruits )
	for i in range (aNbOfFruits):
		var aCoordinates = getCoordinatesOutsideOfSnake(aHeadCoordinates)
		createFruit(aCoordinates[0] ,aCoordinates[1])
		
	var aNbOfEnemies = utils.getRandomNumber(15, 25)
	print ("nb aNbOfEnemies ",aNbOfEnemies )
	for i in range (aNbOfEnemies):
		var aCoordinates = getCoordinatesOutsideOfSnake(aHeadCoordinates)
		createEnemy(aCoordinates[0] ,aCoordinates[1])
	
func spawnSnake(iHeadCoordinates) -> void:
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".position = Vector2(iHeadCoordinates[0], iHeadCoordinates[1])
		$"snake".addTail()
	
func getCoordinatesOutsideOfSnake(iHeadCoordinates) :
	var aNewCoordinates = utils.getRandomCoordinates()
	
	while ( !(aNewCoordinates[0] < (iHeadCoordinates[0] - 200) || aNewCoordinates[0] > (iHeadCoordinates[0] + 80) ||
		 aNewCoordinates[1] < iHeadCoordinates[1] - 80 ||  aNewCoordinates[1] > iHeadCoordinates[1] + 80) ):
		aNewCoordinates = utils.getRandomCoordinates()
	
	return aNewCoordinates
	
func createFruit(fruitX ,fruitY):
	var fruitType = utils.getRandomNumber(0, 7)
	var newFruit = factoryInstance.generate_element(fruitType)
	newFruit.position = Vector2(fruitX ,fruitY)
	newFruit.connect("object_overlap",self,"object_overlap")
	newFruit.connect("fruit_eaten",self,"fruit_eaten")
	add_child(newFruit)
	
		
func createEnemy(enemyX ,enemyY):
	var enemyType = utils.getRandomNumber(0, 3)
	var newEnemy = factoryEnemyInstance.generate_element(enemyType)
	newEnemy.position = Vector2(enemyX ,enemyY)
	newEnemy.connect("object_overlap",self,"object_overlap")
	newEnemy.connect("enemy_encontered",self,"enemy_encontered")
	add_child(newEnemy)

	
func object_overlap(objName):
	print ("game")
	var snakeCoordinates = get_node("snake").position
	var coordinates = getCoordinatesOutsideOfSnake([snakeCoordinates.x, snakeCoordinates.y])
	if objName=="fruit":
		createFruit(coordinates[0] ,coordinates[1])
	else:
		createEnemy(coordinates[0] ,coordinates[1])
		$"snake".removeTail()

func enemy_encontered():
	print ("enemy_encontered")
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".removeTail()
		
	
