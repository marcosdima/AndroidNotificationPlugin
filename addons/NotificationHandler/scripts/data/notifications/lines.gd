extends Notification
class_name NotificationLines

const LINES = "lines"
@export var lines: Array[String] = []

func set_lines(new_lines: Array[String]) -> NotificationLines:
	lines = new_lines
	return self

func as_dictionary() -> Dictionary:
	var aux = super()
	aux[LINES] = lines
	return aux
