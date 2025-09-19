extends NotificationSucces
class_name NotificationCancaled

const CANCELED = "canceled"

var canceled: bool = false

func _init(set_canceled: int):
	canceled = set_canceled


func _to_string() -> String:
	return "Was canceled: %s" % canceled
