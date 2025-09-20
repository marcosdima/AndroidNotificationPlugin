extends NotificationSucces
class_name NotificationCreated

const NOTIFICATION_ID = "notificationId"

var notification_id: int

func _init(set_notification_id: int):
	notification_id = set_notification_id


func _to_string() -> String:
	return "Notification: %d" % notification_id
