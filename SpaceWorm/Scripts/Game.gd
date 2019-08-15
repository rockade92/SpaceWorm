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
	disconect_signals()
	add_enemy()
	
	pass
func disconect_signals():
	print("disconect")
	factoryInstance.disconnect("object_overlap",self,"_on_Factory_object_overlap")
		
func spawn_next_fruit_and_tail():
	if ( get_node_or_null("snake" ) !=  null ):
		$"snake".add_tail()	
		print ("has node")
		
func startSpawn():
	var headX = utils.get_random_number(spawnMinX ,spawnMaxX )
	var headY = utils.get_random_number(spawnMinY, spawnMaxY )
	spawnSnake(headX, headY)
	var y = utils.get_random_number(10, 20)
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
	factoryInstance.connect("object_overlap",self,"_on_Factory_object_overlap")
	add_child(newFruit)

func add_enemy():
	var inst = enemy.instance()
	add_child(inst)	
	var posX = utils.get_random_number(spawnMinX ,spawnMaxX )
	var posY =  utils.get_random_number(spawnMinY ,spawnMaxY )
	print ("gangac! ", posX , "  ", posY)
	inst.position = Vector2(posX, posY)
	inst.connect("enemy_area_entered", self, "spawn_next_enemy_remove_tail")
	
	
func _on_Factory_object_overlap(objName):
	if objName=="fruit":
		var snakeCoordinates = get_node("snake").position
		var coordinates = getCoordinatesOutsideOfSnake(snakeCoordinates.x, snakeCoordinates.y)
		createFruit(coordinates[0] ,coordinates[1])


func enemy_area_entered(area):
	pass # Replace with function body.
