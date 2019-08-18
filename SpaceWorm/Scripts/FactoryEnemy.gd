extends Node

func generate_element(index):
	return get_child(index).duplicate()
