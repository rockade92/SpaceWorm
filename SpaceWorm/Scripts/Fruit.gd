extends Area2D

signal object_overlap(objName)
signal fruit_eaten()

func _area_overlap_(area):
	var objName = area.get_child(0).name
	print ("overlap ",area.name , " with ",self.name, "  ", self.get_child(get_child_count()-2).name )
	if(area.name != "head" ):
		emit_signal("object_overlap",(objName))
		print ("delete object", area.name)
		area.free()
	elif ( area.name == "head" &&  self.get_child(get_child_count()-2).name == "fruit"):
		print ("eat fruit", self.name, " by ", area.name)
		emit_signal("fruit_eaten")
		queue_free()