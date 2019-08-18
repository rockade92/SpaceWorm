extends Node



signal object_overlap(objName)
#signal _on_Factory__overlap_area_

#signal _on_fruitRed1_area_entered
#signal _on_fruitOrange2_area_entered

func generate_element(index):
	return get_child(index).duplicate()


#
#func _on_fruitRed1_area_entered(area):
#		if(area.name == "head"):
#			queue_free()
#			emit_signal("_on_fruitRed1_area_entered")
#			print ("fruitRed1_eaten")
#		else:
#			print ("fruitRed1_overlap")
#
#
#func _on_fruitOrange2_area_entered(area):
#	if(area.name == "head"):
#		queue_free()
#		emit_signal("_on_fruitOrange2_area_entered")
#		print ("fruitOrange2_eaten")
#	else:
#		print ("fruitOrange2_overlap")
#
#
#func _on_fruitYellow4_area_entered(area):
#	if(area.name == "head"):
#		queue_free()
#		emit_signal("_on_fruitYellow3_area_entered")
#		print ("fruitYellow3_eaten")
#	else:
#		print ("fruitYellow3_overlap")

#
#func __(area):
#	print ("overlap area ",area.name )
#	if(area.name != "Player"  ):
#
#		emit_signal("_overlap_area_")
#		emit_signal("_on_Factory__overlap_area_")
#
#		area.free()

