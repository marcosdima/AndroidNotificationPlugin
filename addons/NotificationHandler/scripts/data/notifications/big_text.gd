extends Notification
class_name NotificationBigText

const BIG_TEXT = "bigText"
@export var big_text: String = ""

func set_big_text(str: String) -> NotificationBigText:
	big_text = str
	return self

func as_dictionary() -> Dictionary:
	var aux = super()
	aux[BIG_TEXT] = big_text
	return aux
