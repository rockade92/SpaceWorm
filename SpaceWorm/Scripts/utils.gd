# script: utils

extends Node

const kMaxX = 6000
const kMaxY = 1200 
const kMinX = 200
const kMinY = 600

func getRandomNumber(iMin, iMax):
	randomize()
	var aNum = (randi()%(iMax - iMin)) + iMin
	return aNum
	
func getRandomCoordinates():
	var aX = getRandomNumber(kMinX, kMaxX)
	var aY = getRandomNumber(kMinY, kMaxY)
	return [aX,aY]
	
func checkLimits(MIN, MAX):
	var i
	