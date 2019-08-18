extends Node2D

onready var factoryInstance = preload("res://Scenes/Factory.tscn").instance()
onready var enemy = preload("res://Scenes/LadyBug.tscn")

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
	add_enemy()

		
func fruit_eaten():
	print ("fruit eaten")
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".add_tail()	
		print ("has node")
		
				
func _on_red_fruit_eaten():
	print ("fruit eaten")
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".add_tail()	
		print ("has node")
		
func startSpawn():
	var headX = utils.get_random_number(spawnMinX ,spawnMaxX )
	var headY = utils.get_random_number(spawnMinY, spawnMaxY )
	spawnSnake(headX, headY)
	var y = utils.get_random_number(10, 20)
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

func add_enemy():
	var inst = enemy.instance()
	var posX = utils.get_random_number(spawnMinX ,spawnMaxX )
	var posY =  utils.get_random_number(spawnMinY ,spawnMaxY )
	print ("gangac! ", posX , "  ", posY)
	inst.position = Vector2(posX, posY)
	inst.connect("enemy_area_entered", self, "spawn_next_enemy_remove_tail")
	add_child(inst)	
	
func object_overlap(objName):
	print ("game")
	var snakeCoordinates = get_node("snake").position
	var coordinates = getCoordinatesOutsideOfSnake(snakeCoordinates.x, snakeCoordinates.y)
	if objName=="fruit":
		createFruit(coordinates[0] ,coordinates[1])
	else:
		add_enemy()
		$"snake".remove_tail()


func enemy_area_entered(area):
	pass # Replace with function body.


	
