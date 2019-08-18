extends Node2D

onready var factoryInstance = preload("res://Scenes/Factory.tscn").instance()
onready var factoryEnemyInstance = preload("res://Scenes/Enemy.tscn").instance()

onready var viewportX = int( get_viewport_rect().size.x )
onready var viewportY = int( get_viewport_rect().size.y )

onready var spawnMaxX = viewportX - 100
onready var spawnMaxY = viewportY - 100

var spawnMinX = 100
var spawnMinY = 100

var mapMaxX = 6020
var mapMaxY = 1200

func _ready():
	print (viewportX, " ", viewportY)
	startSpawn()
	createEnemy(utils.get_random_number(spawnMinX ,spawnMaxX ), utils.get_random_number(spawnMinY, spawnMaxY ))
	createEnemy(utils.get_random_number(spawnMinX ,spawnMaxX ), utils.get_random_number(spawnMinY, spawnMaxY ))
	createEnemy(utils.get_random_number(spawnMinX ,spawnMaxX ), utils.get_random_number(spawnMinY, spawnMaxY ))
	
	
func fruit_eaten():
	print ("fruit eaten")
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".add_tail()	
			
		
func startSpawn():
	var headX = utils.get_random_number(spawnMinX ,spawnMaxX )
	var headY = utils.get_random_number(spawnMinY, spawnMaxY )
	spawnSnake(headX, headY)
	var y = utils.get_random_number(10, 11)
	print ("nb fruits ",y )
	for i in range (y):
		var coordinates = getCoordinatesOutsideOfSnake(headX, headY)
		createFruit(coordinates[0] ,coordinates[1])
	
func spawnSnake(headX, headY) -> void:
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".position = Vector2(headX, headY)
	$"snake".add_tail()
	
func getCoordinatesOutsideOfSnake(headX, headY) :
	var newX = utils.get_random_number( spawnMinX ,spawnMaxX )
	var newY = utils.get_random_number( spawnMinY, spawnMaxY )
	
	while ( !(newX < headX - 200 || newX > headX + 80 || newY < headY - 80 || newY > headY + 80) ):
		if (!(newX < (headX - 200) || newX > (headX + 80))):
			newX = utils.get_random_number((viewportX as int)-30 ,30 )
		else:
			newY = utils.get_random_number((viewportY as int)-30 ,30 )
		
	
	return [newX, newY]
	
func createFruit(fruitX ,fruitY):
	var fruitType = utils.get_random_number(0, 7)
	var newFruit = factoryInstance.generate_element(fruitType)
	newFruit.position = Vector2(fruitX ,fruitY)
	print ("new fruit position ",fruitX, "  ", fruitY )
	newFruit.connect("object_overlap",self,"object_overlap")
	newFruit.connect("fruit_eaten",self,"fruit_eaten")
	add_child(newFruit)
	
		
func createEnemy(enemyX ,enemyY):
	var enemyType = utils.get_random_number(0, 1)
	var newEnemy = factoryEnemyInstance.generate_element(enemyType)
	newEnemy.position = Vector2(enemyX ,enemyY)
	print ("new enemy position ",enemyX, "  ", enemyY )
	newEnemy.connect("object_overlap",self,"object_overlap")
	newEnemy.connect("enemy_encontered",self,"enemy_encontered")
	add_child(newEnemy)

	
func object_overlap(objName):
	print ("game")
	var snakeCoordinates = get_node("snake").position
	var coordinates = getCoordinatesOutsideOfSnake(snakeCoordinates.x, snakeCoordinates.y)
	if objName=="fruit":
		createFruit(coordinates[0] ,coordinates[1])
	else:
		createEnemy(coordinates[0] ,coordinates[1])
		$"snake".remove_tail()

func enemy_encontered():
	print ("enemy_encontered")
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".remove_tail()
		
	
