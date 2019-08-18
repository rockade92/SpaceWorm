extends Area2D

signal object_overlap(objName)
signal enemy_encontered()

func area_entered(area):
	var objName = area.get_child(0).name
	print ("overlap ",area.name , " with ",self.name)
	if(area.name != "head" ):
		emit_signal("object_overlap",(objName))
		print ("delete object", area.name)
		area.free()
	elif ( area.name == "head"  ):
		print ("eat fruit", self.name, " by ", area.name)
		emit_signal("enemy_encontered")
		queue_free()

