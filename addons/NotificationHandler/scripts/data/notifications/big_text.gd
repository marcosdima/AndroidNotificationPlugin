extends Notification
class_name NotificationBigText

const BIG_TEXT = "bigText"
@export var big_text: String = ""

func as_dictionary() -> Dictionary:
	var aux = super()
	aux[BIG_TEXT] = big_text
	return aux
