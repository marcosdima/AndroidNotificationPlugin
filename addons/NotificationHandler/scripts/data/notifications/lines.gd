extends Notification
class_name NotificationLines

const LINES = "lines"
@export var lines: Array[String] = []

func as_dictionary() -> Dictionary:
	var aux = super()
	aux[LINES] = lines
	return aux
